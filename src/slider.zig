const c = @import("c.zig");
const nk = @import("nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub fn float(ctx: *nk.Context, min: f32, val: *f32, max: f32, step: f32) bool {
    return c.nk_slider_float(ctx, min, val, max, step) != 0;
}

pub fn int(ctx: *nk.Context, min: c_int, val: *c_int, max: c_int, step: c_int) bool {
    return c.nk_slider_int(ctx, min, val, max, step) != 0;
}

test {
    testing.refAllDecls(@This());
}
