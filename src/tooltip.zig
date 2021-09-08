const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const testing = std.testing;

pub fn text(ctx: *nk.Context, t: []const u8) void {
    return c.nk_tooltip(ctx, nk.slice(t));
}

pub fn begin(ctx: *nk.Context, width: f32) bool {
    return c.nk_tooltip_begin(ctx, width) != 0;
}

pub fn end(ctx: *nk.Context) void {
    return c.nk_tooltip_end(ctx);
}

test {
    testing.refAllDecls(@This());
}
