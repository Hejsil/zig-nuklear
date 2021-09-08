const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const testing = std.testing;

pub fn items(
    ctx: *nk.Context,
    strings: []const nk.Slice,
    selected: usize,
    item_height: c_int,
    size: nk.Vec2,
) usize {
    return @intCast(usize, c.nk_combo(
        ctx,
        nk.discardConst(strings.ptr),
        @intCast(c_int, strings.len),
        @intCast(c_int, selected),
        item_height,
        size,
    ));
}

pub fn separator(
    ctx: *nk.Context,
    items_separated_by_separator: []const u8,
    seb: c_int,
    selected: usize,
    count: c_int,
    item_height: c_int,
    size: nk.Vec2,
) usize {
    return @intCast(usize, c.nk_combo_separator(
        ctx,
        nk.slice(items_separated_by_separator),
        seb,
        @intCast(c_int, selected),
        count,
        item_height,
        size,
    ));
}

pub fn string(
    ctx: *nk.Context,
    items_separated_by_zeros: []const u8,
    selected: usize,
    count: c_int,
    item_height: c_int,
    size: nk.Vec2,
) usize {
    return @intCast(usize, c.nk_combo_string(
        ctx,
        nk.slice(items_separated_by_zeros),
        @intCast(c_int, selected),
        count,
        item_height,
        size,
    ));
}

pub fn callback(
    ctx: *nk.Context,
    userdata: anytype,
    getter: fn (@TypeOf(userdata), usize) []const u8,
    selected: usize,
    count: usize,
    item_height: usize,
    size: nk.Vec2,
) usize {
    const T = @TypeOf(userdata);
    const Wrapped = struct {
        userdata: T,
        getter: fn (T, usize) []const u8,

        fn valueGetter(user: ?*c_void, index: c_int, out: [*c]nk.Slice) callconv(.C) void {
            const casted = @ptrCast(*const @This(), @alignCast(@alignOf(@This()), user));
            out.* = nk.slice(casted.getter(casted.userdata, @intCast(usize, index)));
        }
    };

    var wrapped = Wrapped{ .userdata = userdata, .getter = getter };
    return @intCast(usize, c.nk_combo_callback(
        ctx,
        Wrapped.valueGetter,
        @ptrCast(*c_void, &wrapped),
        @intCast(c_int, selected),
        @intCast(c_int, count),
        @intCast(c_int, item_height),
        size,
    ));
}

pub fn beginLabel(ctx: *nk.Context, selected: []const u8, size: nk.Vec2) bool {
    return c.nk_combo_begin_label(ctx, nk.slice(selected), size) != 0;
}

pub fn beginColor(ctx: *nk.Context, q: nk.Color, size: nk.Vec2) bool {
    return c.nk_combo_begin_color(ctx, q, size) != 0;
}

pub fn beginSymbol(ctx: *nk.Context, a: nk.SymbolType, size: nk.Vec2) bool {
    return c.nk_combo_begin_symbol(ctx, a, size) != 0;
}

pub fn beginSymbolLabel(
    ctx: *nk.Context,
    selected: []const u8,
    a: nk.SymbolType,
    size: nk.Vec2,
) bool {
    return c.nk_combo_begin_symbol_label(ctx, nk.slice(selected), a, size) != 0;
}

pub fn beginImage(ctx: *nk.Context, img: nk.Image, size: nk.Vec2) bool {
    return c.nk_combo_begin_image(ctx, img, size) != 0;
}

pub fn beginImageLabel(ctx: *nk.Context, selected: []const u8, a: nk.Image, size: nk.Vec2) bool {
    return c.nk_combo_begin_image_label(ctx, nk.slice(selected), a, size) != 0;
}

pub fn itemLabel(ctx: *nk.Context, a: []const u8, alignment: nk.Flags) bool {
    return c.nk_combo_item_label(ctx, nk.slice(a), alignment) != 0;
}

pub fn itemImageLabel(ctx: *nk.Context, y: nk.Image, a: []const u8, alignment: nk.Flags) bool {
    return c.nk_combo_item_image_label(ctx, y, nk.slice(a), alignment) != 0;
}

pub fn itemSymbolLabel(
    ctx: *nk.Context,
    y: nk.SymbolType,
    a: []const u8,
    alignment: nk.Flags,
) bool {
    return c.nk_combo_item_symbol_label(ctx, y, nk.slice(a), alignment) != 0;
}

pub fn close(ctx: *nk.Context) void {
    return c.nk_combo_close(ctx);
}

pub fn end(ctx: *nk.Context) void {
    return c.nk_combo_end(ctx);
}

test {
    testing.refAllDecls(@This());
}

test "chart" {
    var ctx = &try nk.testing.init();
    defer nk.free(ctx);

    if (nk.window.begin(ctx, &nk.id(opaque {}), nk.rect(10, 10, 10, 10), .{})) |_| {
        nk.layout.rowDynamic(ctx, 0.0, 1);
        _ = nk.combo.callback(ctx, {}, struct {
            fn func(_: void, i: usize) []const u8 {
                return switch (i) {
                    0 => "1",
                    1 => "2",
                    else => unreachable,
                };
            }
        }.func, 0, 2, 10, nk.vec2(10, 10));
    }
    nk.window.end(ctx);
}
