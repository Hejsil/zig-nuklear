const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const testing = std.testing;

pub const Buttons = c.nk_buttons;
pub const Keys = c.nk_keys;

const input = @This();

pub fn begin(ctx: *nk.Context) void {
    c.nk_input_begin(ctx);
}

pub fn motion(ctx: *nk.Context, x: c_int, y: c_int) void {
    c.nk_input_motion(ctx, x, y);
}

pub fn key(ctx: *nk.Context, keys: Keys, down: bool) void {
    c.nk_input_motion(ctx, @enumToInt(keys), @boolToInt(down));
}

pub fn button(ctx: *nk.Context, bot: Buttons, x: c_int, y: c_int, down: bool) void {
    c.nk_input_button(ctx, bot, x, y, @boolToInt(down));
}

pub fn scroll(ctx: *nk.Context, val: c.struct_nk_vec2) void {
    c.nk_input_scroll(ctx, val);
}

pub fn char(ctx: *nk.Context, ch: u8) void {
    c.nk_input_char(ctx, ch);
}

pub fn glyph(ctx: *nk.Context, gl: [4]u8) void {
    c.nk_input_glyph(ctx, &gl);
}

pub fn unicode(ctx: *nk.Context, cp: u21) void {
    c.nk_input_unicode(ctx, @intCast(c.nk_rune, cp));
}

pub fn end(ctx: *nk.Context) void {
    c.nk_input_end(ctx);
}

pub fn hasMouseClick(in: nk.Input, bots: nk.Buttons) bool {
    return c.nk_input_has_mouse_click(&in, bots) != 0;
}

pub fn hasMouseClickInRect(in: nk.Input, bots: nk.Buttons, r: nk.Rect) bool {
    return c.nk_input_has_mouse_click_in_rect(&in, bots, r) != 0;
}

pub fn hasMouseClickDownInRect(in: nk.Input, bots: nk.Buttons, r: nk.Rect, down: bool) bool {
    return c.nk_input_has_mouse_click_down_in_rect(&in, bots, r, @boolToInt(down)) != 0;
}

pub fn isMouseClickInRect(in: nk.Input, bots: nk.Buttons, r: nk.Rect) bool {
    return c.nk_input_is_mouse_click_in_rect(&in, bots, r) != 0;
}

pub fn isMouseClickDownInRect(in: nk.Input, id: nk.Buttons, b: nk.Rect, down: bool) bool {
    return c.nk_input_is_mouse_click_down_in_rect(&in, id, b, @boolToInt(down)) != 0;
}

pub fn anyMouseClickInRect(in: nk.Input, r: nk.Rect) bool {
    return c.nk_input_any_mouse_click_in_rect(&in, r) != 0;
}

pub fn isMousePrevHoveringRect(in: nk.Input, r: nk.Rect) bool {
    return c.nk_input_is_mouse_prev_hovering_rect(&in, r) != 0;
}

pub fn isMouseHoveringRect(in: nk.Input, r: nk.Rect) bool {
    return c.nk_input_is_mouse_hovering_rect(&in, r) != 0;
}

pub fn mouseClicked(in: nk.Input, bots: nk.Buttons, r: nk.Rect) bool {
    return c.nk_input_mouse_clicked(&in, bots, r) != 0;
}

pub fn isMouseDown(in: nk.Input, bots: nk.Buttons) bool {
    return c.nk_input_is_mouse_down(&in, bots) != 0;
}

pub fn isMousePressed(in: nk.Input, bots: nk.Buttons) bool {
    return c.nk_input_is_mouse_pressed(&in, bots) != 0;
}

pub fn isMouseReleased(in: nk.Input, bots: nk.Buttons) bool {
    return c.nk_input_is_mouse_released(&in, bots) != 0;
}

pub fn isKeyPressed(in: nk.Input, keys: nk.Keys) bool {
    return c.nk_input_is_key_pressed(&in, keys) != 0;
}

pub fn isKeyReleased(in: nk.Input, keys: nk.Keys) bool {
    return c.nk_input_is_key_released(&in, keys) != 0;
}

pub fn isKeyDown(in: nk.Input, keys: nk.Keys) bool {
    return c.nk_input_is_key_down(&in, keys) != 0;
}

test {
    testing.refAllDecls(@This());
}

test "input" {
    var ctx = &try nk.testing.init();
    defer nk.free(ctx);

    input.begin(ctx);
    input.motion(ctx, 20, 20);
    input.key(ctx, .NK_KEY_DEL, true);
    input.button(ctx, .NK_BUTTON_LEFT, 40, 40, true);
    input.scroll(ctx, nk.vec2(20.0, 20.0));
    input.char(ctx, 'a');
    input.glyph(ctx, "👀".*);
    input.unicode(ctx, '👀');
    input.end(ctx);
}
