const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub fn label(ctx: *nk.Context, title: []const u8, active: *bool) bool {
    var c_active: c.nk_bool = @boolToInt(active.*);
    defer active.* = c_active != 0;
    return c.nk_radio_label(ctx, nk.slice(title), &c_active) != 0;
}

test {
    testing.refAllDecls(@This());
}
