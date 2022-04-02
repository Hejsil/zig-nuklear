const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub const Behavior = c.nk_button_behavior;

pub fn label(ctx: *nk.Context, title: []const u8) bool {
    return c.nk_button_label(ctx, nk.slice(title)) != 0;
}

pub fn color(ctx: *nk.Context, col: nk.Color) bool {
    return c.nk_button_color(ctx, col) != 0;
}

pub fn symbol(ctx: *nk.Context, sym: nk.SymbolType) bool {
    return c.nk_button_symbol(ctx, @enumToInt(sym)) != 0;
}

pub fn image(ctx: *nk.Context, img: nk.Image) bool {
    return c.nk_button_image(ctx, img) != 0;
}

pub fn symbolLabel(
    ctx: *nk.Context,
    sym: nk.SymbolType,
    title: []const u8,
    flags: nk.text.Align,
) bool {
    return c.nk_button_symbol_label(
        ctx,
        @enumToInt(sym),
        nk.slice(title),
        @enumToInt(flags),
    ) != 0;
}

pub fn imageLabel(ctx: *nk.Context, img: nk.Image, title: []const u8, flags: nk.Flags) bool {
    return c.nk_button_image_label(ctx, img, nk.slice(title), flags) != 0;
}

pub fn labelStyled(ctx: *nk.Context, style: *const nk.StyleButton, title: []const u8) bool {
    return c.nk_button_label_styled(ctx, style, nk.slice(title)) != 0;
}

pub fn symbolStyled(ctx: *nk.Context, sym: nk.SymbolType, style: nk.StyleButton) bool {
    return c.nk_button_symbol_styled(ctx, &style, @enumToInt(sym)) != 0;
}

pub fn imageStyled(ctx: *nk.Context, img: nk.Image, style: nk.StyleButton) bool {
    return c.nk_button_image_styled(ctx, &style, img) != 0;
}

pub fn symbolLabelStyled(
    ctx: *nk.Context,
    sym: nk.SymbolType,
    title: []const u8,
    flags: nk.text.Align,
    style: nk.StyleButton,
) bool {
    return c.nk_button_symbol_label_styled(
        ctx,
        &style,
        @enumToInt(sym),
        nk.slice(title),
        @enumToInt(flags),
    ) != 0;
}

pub fn imageLabelStyled(
    ctx: *nk.Context,
    img: nk.Image,
    title: []const u8,
    flags: nk.Flags,
    style: nk.StyleButton,
) bool {
    return c.nk_button_image_label_styled(
        ctx,
        &style,
        img,
        nk.slice(title),
        flags,
    ) != 0;
}

pub fn setBehavior(ctx: *nk.Context, behavior: Behavior) void {
    return c.nk_button_set_behavior(ctx, behavior);
}

pub fn pushBehavior(ctx: *nk.Context, behavior: Behavior) bool {
    return c.nk_button_push_behavior(ctx, behavior) != 0;
}

pub fn popBehavior(ctx: *nk.Context) bool {
    return c.nk_button_pop_behavior(ctx) != 0;
}

test {
    testing.refAllDecls(@This());
}
