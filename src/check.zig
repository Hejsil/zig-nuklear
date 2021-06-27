const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub fn label(ctx: *nk.Context, title: []const u8, active: bool) bool {
    return c.nk_check_label(ctx, nk.slice(title), @boolToInt(active)) != 0;
}

pub fn flagsLabel(ctx: *nk.Context, title: []const u8, flags: usize, value: usize) usize {
    return c.nk_check_flags_label(
        ctx,
        nk.slice(title),
        @intCast(c_uint, flags),
        @intCast(c_uint, value),
    );
}

test {
    testing.refAllDecls(@This());
}
