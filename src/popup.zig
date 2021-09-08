const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const testing = std.testing;

pub fn begin(ctx: *nk.Context, _type: nk.PopupType, str: []const u8, flags: nk.Flags, bounds: nk.Rect) bool {
    return c.nk_popup_begin(ctx, _type, nk.slice(str), flags, bounds) != 0;
}

pub fn close(ctx: *nk.Context) void {
    return c.nk_popup_close(ctx);
}

pub fn end(ctx: *nk.Context) void {
    return c.nk_popup_end(ctx);
}

pub fn getScroll(ctx: *nk.Context) nk.ScrollOffset {
    var x_offset: c.nk_uint = undefined;
    var y_offset: c.nk_uint = undefined;
    c.nk_popup_get_scroll(ctx, &x_offset, &y_offset);
    return .{
        .x = x_offset,
        .y = y_offset,
    };
}

pub fn setScroll(ctx: *nk.Context, offset: nk.ScrollOffset) void {
    c.nk_popup_set_scroll(
        ctx,
        @intCast(c.nk_uint, offset.x),
        @intCast(c.nk_uint, offset.y),
    );
}

test {
    testing.refAllDecls(@This());
}
