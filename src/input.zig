const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const testing = std.testing;

pub const Buttons = enum(u8) {
    left = c.NK_BUTTON_LEFT,
    middle = c.NK_BUTTON_MIDDLE,
    right = c.NK_BUTTON_RIGHT,
    double = c.NK_BUTTON_DOUBLE,
};

pub const Keys = enum(u8) {
    none = c.NK_KEY_NONE,
    shift = c.NK_KEY_SHIFT,
    ctrl = c.NK_KEY_CTRL,
    del = c.NK_KEY_DEL,
    enter = c.NK_KEY_ENTER,
    tab = c.NK_KEY_TAB,
    backspace = c.NK_KEY_BACKSPACE,
    copy = c.NK_KEY_COPY,
    cut = c.NK_KEY_CUT,
    paste = c.NK_KEY_PASTE,
    up = c.NK_KEY_UP,
    down = c.NK_KEY_DOWN,
    left = c.NK_KEY_LEFT,
    right = c.NK_KEY_RIGHT,
    text_insert_mode = c.NK_KEY_TEXT_INSERT_MODE,
    text_replace_mode = c.NK_KEY_TEXT_REPLACE_MODE,
    text_reset_mode = c.NK_KEY_TEXT_RESET_MODE,
    text_line_start = c.NK_KEY_TEXT_LINE_START,
    text_line_end = c.NK_KEY_TEXT_LINE_END,
    text_start = c.NK_KEY_TEXT_START,
    text_end = c.NK_KEY_TEXT_END,
    text_undo = c.NK_KEY_TEXT_UNDO,
    text_redo = c.NK_KEY_TEXT_REDO,
    text_select_all = c.NK_KEY_TEXT_SELECT_ALL,
    text_word_left = c.NK_KEY_TEXT_WORD_LEFT,
    text_word_right = c.NK_KEY_TEXT_WORD_RIGHT,
    scroll_start = c.NK_KEY_SCROLL_START,
    scroll_end = c.NK_KEY_SCROLL_END,
    scroll_down = c.NK_KEY_SCROLL_DOWN,
    scroll_up = c.NK_KEY_SCROLL_UP,
};

const input = @This();

pub fn begin(ctx: *nk.Context) void {
    c.nk_input_begin(ctx);
}

pub fn motion(ctx: *nk.Context, x: c_int, y: c_int) void {
    c.nk_input_motion(ctx, x, y);
}

pub fn key(ctx: *nk.Context, keys: Keys, down: bool) void {
    c.nk_input_key(ctx, @intToEnum(c.enum_nk_keys, @enumToInt(keys)), @boolToInt(down));
}

pub fn button(ctx: *nk.Context, bot: Buttons, x: c_int, y: c_int, down: bool) void {
    c.nk_input_button(
        ctx,
        @intToEnum(c.enum_nk_buttons, @enumToInt(bot)),
        x,
        y,
        @boolToInt(down),
    );
}

pub fn scroll(ctx: *nk.Context, val: nk.Vec2) void {
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
    input.key(ctx, .del, true);
    input.button(ctx, .left, 40, 40, true);
    input.scroll(ctx, nk.vec2(20.0, 20.0));
    input.char(ctx, 'a');
    input.glyph(ctx, "👀".*);
    input.unicode(ctx, '👀');
    input.end(ctx);
}
