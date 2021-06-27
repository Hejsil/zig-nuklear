const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub fn label(ctx: *nk.Context, title: []const u8, active: bool) bool {
    return c.nk_option_label(ctx, nk.slice(title), @boolToInt(active)) != 0;
}

test {
    testing.refAllDecls(@This());
}
