const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const testing = std.testing;

pub const Type = enum(u8) {
    lines = c.NK_CHART_LINES,
    column = c.NK_CHART_COLUMN,

    pub fn toNuklear(_type: Type) c.enum_nk_chart_type {
        return @intToEnum(c.enum_nk_chart_type, @enumToInt(_type));
    }
};

pub const Event = enum(nk.Flags) {
    hovering = c.NK_CHART_HOVERING,
    clicked = c.NK_CHART_CLICKED | c.NK_CHART_HOVERING,
    _,
};

pub fn begin(ctx: *nk.Context, _type: Type, num: usize, min: f32, max: f32) bool {
    return c.nk_chart_begin(ctx, _type.toNuklear(), @intCast(c_int, num), min, max) != 0;
}

pub fn beginColored(ctx: *nk.Context, _type: Type, a: nk.Color, active: nk.Color, num: usize, min: f32, max: f32) bool {
    return c.nk_chart_begin_colored(ctx, _type.toNuklear(), a, active, @intCast(c_int, num), min, max) != 0;
}

pub fn addSlot(ctx: *nk.Context, _type: Type, count: usize, min_value: f32, max_value: f32) void {
    return c.nk_chart_add_slot(ctx, _type.toNuklear(), @intCast(c_int, count), min_value, max_value);
}

pub fn addSlotColored(ctx: *nk.Context, _type: Type, a: nk.Color, active: nk.Color, count: usize, min_value: f32, max_value: f32) void {
    return c.nk_chart_add_slot_colored(ctx, _type.toNuklear(), a, active, @intCast(c_int, count), min_value, max_value);
}

pub fn push(ctx: *nk.Context, value: f32) Event {
    return @intToEnum(Event, c.nk_chart_push(ctx, value));
}

pub fn pushSlot(ctx: *nk.Context, value: f32, slot: usize) Event {
    return @intToEnum(Event, c.nk_chart_push_slot(ctx, value, @intCast(c_int, slot)));
}

pub fn end(ctx: *nk.Context) void {
    return c.nk_chart_end(ctx);
}

pub fn plot(ctx: *nk.Context, _type: Type, values: []const f32) void {
    return c.nk_plot(
        ctx,
        _type.toNuklear(),
        values.ptr,
        @intCast(c_int, values.len),
        0,
    );
}

pub fn function(
    ctx: *nk.Context,
    _type: Type,
    count: usize,
    offset: usize,
    userdata: anytype,
    getter: fn (@TypeOf(userdata), usize) f32,
) void {
    const T = @TypeOf(userdata);
    const Wrapped = struct {
        userdata: T,
        getter: fn (T, usize) f32,

        fn valueGetter(user: ?*c_void, index: c_int) callconv(.C) f32 {
            const casted = @ptrCast(*const @This(), @alignCast(@alignOf(@This()), user));
            return casted.getter(casted.userdata, @intCast(usize, index));
        }
    };

    var wrapped = Wrapped{ .userdata = userdata, .getter = getter };
    return c.nk_plot_function(
        ctx,
        _type.toNuklear(),
        @ptrCast(*c_void, &wrapped),
        Wrapped.valueGetter,
        @intCast(c_int, count),
        @intCast(c_int, offset),
    );
}

test {
    testing.refAllDecls(@This());
}

test "chart" {
    var ctx = &try nk.testing.init();
    defer nk.free(ctx);

    if (nk.window.begin(ctx, &nk.id(opaque {}), nk.rect(10, 10, 10, 10), .{})) |_| {
        nk.layout.rowDynamic(ctx, 0.0, 1);
        nk.chart.function(ctx, .lines, 10, 0, {}, struct {
            fn func(_: void, i: usize) f32 {
                return @intToFloat(f32, i);
            }
        }.func);
    }
    nk.window.end(ctx);
}
