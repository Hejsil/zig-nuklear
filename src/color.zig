const c = @import("c.zig");
const nk = @import("nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub const Format = c.nk_color_format;

pub fn picker(ctx: *nk.Context, color: nk.Colorf, format: Format) nk.Colorf {
    return c.nk_color_picker(ctx, color, format);
}

pub fn pick(ctx: *nk.Context, color: *nk.Colorf, format: Format) bool {
    return c.nk_color_pick(ctx, color, format) != 0;
}

test {
    testing.refAllDecls(@This());
}
