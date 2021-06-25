const c = @import("c.zig");
const nk = @import("nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub fn label(ctx: *nk.Context, title: []const u8, active: *bool) bool {
    var c_active: c.nk_bool = @boolToInt(active.*);
    defer active.* = c_active != 0;
    return c.nk_checkbox_label(ctx, nk.slice(title), &c_active) != 0;
}

pub fn flagsLabel(ctx: *nk.Context, title: []const u8, flags: *usize, value: usize) bool {
    var c_flags: c_uint = @intCast(c_uint, flags.*);
    defer flags.* = @intCast(usize, c_flags);
    return c.nk_checkbox_flags_label(ctx, nk.slice(title), &c_flags, @intCast(c_uint, value)) != 0;
}

test {
    testing.refAllDecls(@This());
}
