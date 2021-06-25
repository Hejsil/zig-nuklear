const c = @import("c.zig");
const nk = @import("nuklear.zig");
const std = @import("std");

const builtin = std.builtin;
const debug = std.debug;
const heap = std.heap;
const math = std.math;
const mem = std.mem;
const meta = std.meta;
const testing = std.testing;

/// Same as `beginTitled` but instead of taking a `name` which the caller needs to ensure
/// is a unique string, this function generates a unique name for each unique type passed
/// to `id`.
pub fn begin(
    ctx: *nk.Context,
    comptime Id: type,
    title: []const u8,
    flags: nk.Flags,
) bool {
    const id = nk.typeId(Id);
    return beginTitled(ctx, mem.asBytes(&id), title, flags);
}

pub fn beginTitled(
    ctx: *nk.Context,
    name: []const u8,
    title: []const u8,
    flags: nk.Flags,
) bool {
    return c.nk_group_begin_titled(ctx, nk.slice(name), nk.slice(title), flags) != 0;
}

pub fn end(ctx: *nk.Context) void {
    c.nk_group_end(ctx);
}

pub fn scrolledOffsetBegin(
    ctx: *nk.Context,
    offset: *nk.ScrollOffset,
    title: []const u8,
    flags: nk.Flags,
) bool {
    var c_x_offset: c.nk_uint = @intCast(c.nk_uint, offset.x);
    var c_y_offset: c.nk_uint = @intCast(c.nk_uint, offset.y);
    defer {
        offset.x = @intCast(usize, c_x_offset);
        offset.y = @intCast(usize, c_y_offset);
    }
    return c.nk_group_scrolled_offset_begin(
        ctx,
        &c_x_offset,
        &c_y_offset,
        nk.slice(title),
        flags,
    ) != 0;
}

pub fn scrolledBegin(ctx: *nk.Context, off: *nk.Scroll, title: []const u8, flags: nk.Flags) bool {
    return c.nk_group_scrolled_begin(ctx, off, nk.slice(title), flags) != 0;
}

pub fn scrolledEnd(ctx: *nk.Context) void {
    c.nk_group_scrolled_end(ctx);
}

pub fn getScroll(ctx: *nk.Context, id: []const u8) nk.ScrollOffset {
    var x_offset: c.nk_uint = undefined;
    var y_offset: c.nk_uint = undefined;
    c.nk_group_get_scroll(ctx, nk.slice(id), &x_offset, &y_offset);
    return .{
        .x = x_offset,
        .y = y_offset,
    };
}

pub fn setScroll(ctx: *nk.Context, id: []const u8, offset: nk.ScrollOffset) void {
    c.nk_group_set_scroll(
        ctx,
        nk.slice(id),
        @intCast(c.nk_uint, offset.x),
        @intCast(c.nk_uint, offset.y),
    );
}

test {
    testing.refAllDecls(@This());
}

test "list" {
    var ctx = &try nk.testing.init();
    defer nk.free(ctx);

    const flags = c.NK_WINDOW_BORDER | c.NK_WINDOW_MOVABLE | c.NK_WINDOW_SCALABLE |
        c.NK_WINDOW_CLOSABLE | c.NK_WINDOW_MINIMIZABLE | c.NK_WINDOW_TITLE;

    if (nk.window.begin(ctx, opaque {}, "test", nk.rect(10, 10, 10, 10), flags)) |win| {
        nk.layout.rowDynamic(ctx, 10, 1);
        if (nk.group.begin(ctx, opaque {}, "yo", flags)) {
            defer nk.group.end(ctx);
        }
    }
    nk.window.end(ctx);
}
