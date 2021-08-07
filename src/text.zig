const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub const Align = struct {
    vertical: Vertical = .left,
    horizontal: Horizontal = .middle,

    pub const top_left: Alignment = .{ .vertical = .top, .horizontal = .left };
    pub const mid_left: Alignment = .{ .vertical = .middle, .horizontal = .left };
    pub const bot_left: Alignment = .{ .vertical = .bot, .horizontal = .left };
    pub const top_center: Alignment = .{ .vertical = .top, .horizontal = .center };
    pub const mid_center: Alignment = .{ .vertical = .middle, .horizontal = .center };
    pub const bot_center: Alignment = .{ .vertical = .bot, .horizontal = .center };
    pub const top_right: Alignment = .{ .vertical = .top, .horizontal = .right };
    pub const mid_right: Alignment = .{ .vertical = .middle, .horizontal = .right };
    pub const bot_right: Alignment = .{ .vertical = .bot, .horizontal = .right };

    pub const Vertical = enum(u8) {
        top = c.NK_TEXT_ALIGN_TOP,
        middle = c.NK_TEXT_ALIGN_MIDDLE,
        bottom = c.NK_TEXT_ALIGN_BOTTOM,
    };

    pub const Horizontal = enum(u8) {
        left = c.NK_TEXT_ALIGN_LEFT,
        center = c.NK_TEXT_ALIGN_CENTERED,
        right = c.NK_TEXT_ALIGN_RIGHT,
    };

    pub fn toNuklear(flags: Align) nk.Flags {
        return @enumToInt(flags.horizontal) | @enumToInt(flags.vertical);
    }
};

pub fn label(ctx: *nk.Context, text: []const u8, alignment: Align) void {
    return c.nk_label(ctx, nk.slice(text), alignment.toNuklear());
}

pub fn labelColored(ctx: *nk.Context, text: []const u8, alignment: Align, color: nk.Color) void {
    return c.nk_label_colored(ctx, nk.slice(text), alignment.toNuklear(), color);
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
