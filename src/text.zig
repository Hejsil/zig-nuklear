const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub fn label(ctx: *nk.Context, text: []const u8, flags: nk.Flags) void {
    return c.nk_label(ctx, nk.slice(text), flags);
}

pub fn labelColored(ctx: *nk.Context, text: []const u8, flags: nk.Flags, color: nk.Color) void {
    return c.nk_label_colored(ctx, nk.slice(text), flags, color);
}

pub fn labelWrap(ctx: *nk.Context, text: []const u8) void {
    return c.nk_label_wrap(ctx, nk.slice(text));
}

pub fn labelWrapColored(ctx: *nk.Context, text: []const u8, color: nk.Color) void {
    return c.nk_label_wrap_colored(ctx, nk.slice(text), color);
}

pub fn image(ctx: *nk.Context, img: nk.Image) void {
    return c.nk_image(ctx, img);
}

pub fn imageColor(ctx: *nk.Context, img: nk.Image, color: nk.Color) void {
    return c.nk_image_color(ctx, img, color);
}

test {
    testing.refAllDecls(@This());
}
