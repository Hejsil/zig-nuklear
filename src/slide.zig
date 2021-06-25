const c = @import("c.zig");
const nk = @import("nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub fn float(ctx: *nk.Context, min: f32, val: f32, max: f32, step: f32) f32 {
    return c.nk_slide_float(ctx, min, val, max, step);
}

pub fn int(ctx: *nk.Context, min: c_int, val: c_int, max: c_int, step: c_int) c_int {
    return c.nk_slide_int(ctx, min, val, max, step);
}

test {
    testing.refAllDecls(@This());
}
