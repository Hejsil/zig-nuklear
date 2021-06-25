const c = @import("c.zig");
const nk = @import("nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub fn progress(ctx: *nk.Context, cur: *usize, max: usize, modifyable: bool) bool {
    return c.nk_progress(ctx, cur, max, @boolToInt(modifyable)) != 0;
}

pub fn prog(ctx: *nk.Context, cur: usize, max: usize, modifyable: bool) usize {
    return c.nk_prog(ctx, cur, max, @boolToInt(modifyable));
}

test {
    testing.refAllDecls(@This());
}
