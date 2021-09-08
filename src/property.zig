const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const testing = std.testing;

pub fn int(ctx: *nk.Context, name: []const u8, min: c_int, val: *c_int, max: c_int, step: c_int, inc_per_pixel: f32) void {
    return c.nk_property_int(ctx, nk.slice(name), min, val, max, step, inc_per_pixel);
}

pub fn float(ctx: *nk.Context, name: []const u8, min: f32, val: *f32, max: f32, step: f32, inc_per_pixel: f32) void {
    return c.nk_property_float(ctx, nk.slice(name), min, val, max, step, inc_per_pixel);
}

pub fn double(ctx: *nk.Context, name: []const u8, min: f64, val: *f64, max: f64, step: f64, inc_per_pixel: f32) void {
    return c.nk_property_double(ctx, nk.slice(name), min, val, max, step, inc_per_pixel);
}

pub fn i(ctx: *nk.Context, name: []const u8, min: c_int, val: c_int, max: c_int, step: c_int, inc_per_pixel: f32) c_int {
    return c.nk_propertyi(ctx, nk.slice(name), min, val, max, step, inc_per_pixel);
}

pub fn f(ctx: *nk.Context, name: []const u8, min: f32, val: f32, max: f32, step: f32, inc_per_pixel: f32) f32 {
    return c.nk_propertyf(ctx, nk.slice(name), min, val, max, step, inc_per_pixel);
}

pub fn d(ctx: *nk.Context, name: []const u8, min: f64, val: f64, max: f64, step: f64, inc_per_pixel: f32) f64 {
    return c.nk_propertyd(ctx, nk.slice(name), min, val, max, step, inc_per_pixel);
}

test {
    std.testing.refAllDecls(@This());
}
