const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const testing = std.testing;

pub fn begin(ctx: *nk.Context) void {
    return c.nk_menubar_begin(ctx);
}

pub fn end(ctx: *nk.Context) void {
    return c.nk_menubar_end(ctx);
}

test {
    testing.refAllDecls(@This());
}
