const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub const Align = enum(u8) {
    top_left = c.NK_TEXT_ALIGN_TOP | c.NK_TEXT_ALIGN_LEFT,
    mid_left = c.NK_TEXT_ALIGN_MIDDLE | c.NK_TEXT_ALIGN_LEFT,
    bot_left = c.NK_TEXT_ALIGN_BOTTOM | c.NK_TEXT_ALIGN_LEFT,
    top_center = c.NK_TEXT_ALIGN_TOP | c.NK_TEXT_ALIGN_CENTERED,
    mid_center = c.NK_TEXT_ALIGN_MIDDLE | c.NK_TEXT_ALIGN_CENTERED,
    bot_center = c.NK_TEXT_ALIGN_BOTTOM | c.NK_TEXT_ALIGN_CENTERED,
    top_right = c.NK_TEXT_ALIGN_TOP | c.NK_TEXT_ALIGN_RIGHT,
    mid_right = c.NK_TEXT_ALIGN_MIDDLE | c.NK_TEXT_ALIGN_RIGHT,
    bot_right = c.NK_TEXT_ALIGN_BOTTOM | c.NK_TEXT_ALIGN_RIGHT,
};

pub fn label(ctx: *nk.Context, text: []const u8, alignment: Align) void {
    return c.nk_label(ctx, nk.slice(text), @enumToInt(alignment));
}

pub fn labelColored(ctx: *nk.Context, text: []const u8, alignment: Align, color: nk.Color) void {
    return c.nk_label_colored(ctx, nk.slice(text), @enumToInt(alignment), color);
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
