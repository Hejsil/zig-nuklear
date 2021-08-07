const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub const TextHorizontalAlignment = enum(c_uint) { Left = 0x01, // NK_TEXT_ALIGN_LEFT
Centered = 0x02, // NK_TEXT_ALIGN_CENTERED
Right = 0x04 // NK_TEXT_ALIGN_RIGHT
};

pub const TextVerticalAlignment = enum(c_uint) { Top = 0x08, // NK_TEXT_ALIGN_TOP
Middle = 0x10, // NK_TEXT_ALIGN_MIDDLE
Bottom = 0x20 // NK_TEXT_ALIGN_BOTTOM
};

pub const TextAlignment = struct {
    horizontal: TextHorizontalAlignment = Middle,
    vertical: TextVerticalAlignment = Left,

    pub fn toNuklear(flags: TextAlignment) nk.Flags {
        return @enumToInt(flags.horizontal) | @enumToInt(flags.vertical);
    }
};

pub const TextAlignmentLeft: TextAlignment = .{ .horizontal = .Left, .vertical = .Middle };
pub const TextAlignmentCentered: TextAlignment = .{ .horizontal = .Centered, .vertical = .Middle };
pub const TextAlignmentRight: TextAlignment = .{ .horizontal = .Right, .vertical = .Middle };

pub fn label(ctx: *nk.Context, text: []const u8, textalign: TextAlignment) void {
    return c.nk_label(ctx, nk.slice(text), textalign.toNuklear());
}

pub fn labelColored(ctx: *nk.Context, text: []const u8, textalign: TextAlignment, color: nk.Color) void {
    return c.nk_label_colored(ctx, nk.slice(text), textalign.toNuklear(), color);
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
