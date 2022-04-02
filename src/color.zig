const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub const Format = enum(u8) {
    rgb = c.NK_RGB,
    rgba = c.NK_RGBA,
};

pub fn picker(ctx: *nk.Context, color: nk.Colorf, format: Format) nk.Colorf {
    return c.nk_color_picker(ctx, color, @enumToInt(format));
}

pub fn pick(ctx: *nk.Context, color: *nk.Colorf, format: Format) bool {
    return c.nk_color_pick(ctx, color, @enumToInt(format)) != 0;
}

test {
    testing.refAllDecls(@This());
}
