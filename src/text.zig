const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

const Type = c.nk_text_alignment;

pub fn label(ctx: *nk.Context, text: []const u8, textalign: Type) void {
    return c.nk_label(ctx, nk.slice(text), @intCast(c_uint,@enumToInt(textalign)));
}

pub fn labelColored(ctx: *nk.Context, text: []const u8, textalign: Type, color: nk.Color) void {
    return c.nk_label_colored(ctx, nk.slice(text),  @intCast(c_uint,@enumToInt(textalign)), color);
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
