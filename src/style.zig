const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub const Colors = enum(u8) {
    text = c.NK_COLOR_TEXT,
    window = c.NK_COLOR_WINDOW,
    header = c.NK_COLOR_HEADER,
    border = c.NK_COLOR_BORDER,
    button = c.NK_COLOR_BUTTON,
    button_hover = c.NK_COLOR_BUTTON_HOVER,
    button_active = c.NK_COLOR_BUTTON_ACTIVE,
    toggle = c.NK_COLOR_TOGGLE,
    toggle_hover = c.NK_COLOR_TOGGLE_HOVER,
    toggle_cursor = c.NK_COLOR_TOGGLE_CURSOR,
    select = c.NK_COLOR_SELECT,
    select_active = c.NK_COLOR_SELECT_ACTIVE,
    slider = c.NK_COLOR_SLIDER,
    slider_cursor = c.NK_COLOR_SLIDER_CURSOR,
    slider_cursor_hover = c.NK_COLOR_SLIDER_CURSOR_HOVER,
    slider_cursor_active = c.NK_COLOR_SLIDER_CURSOR_ACTIVE,
    property = c.NK_COLOR_PROPERTY,
    edit = c.NK_COLOR_EDIT,
    edit_cursor = c.NK_COLOR_EDIT_CURSOR,
    combo = c.NK_COLOR_COMBO,
    chart = c.NK_COLOR_CHART,
    chart_color = c.NK_COLOR_CHART_COLOR,
    chart_color_highlight = c.NK_COLOR_CHART_COLOR_HIGHLIGHT,
    scrollbar = c.NK_COLOR_SCROLLBAR,
    scrollbar_cursor = c.NK_COLOR_SCROLLBAR_CURSOR,
    scrollbar_cursor_hover = c.NK_COLOR_SCROLLBAR_CURSOR_HOVER,
    scrollbar_cursor_active = c.NK_COLOR_SCROLLBAR_CURSOR_ACTIVE,
    tab_header = c.NK_COLOR_TAB_HEADER,

    fn toNuklear(color: Colors) c.enum_nk_style_colors {
        return @intToEnum(c.enum_nk_style_colors, @enumToInt(color));
    }
};

pub const ColorArray = std.EnumArray(Colors, nk.Color);

pub fn default(ctx: *nk.Context) void {
    return c.nk_style_default(ctx);
}

pub fn fromTable(ctx: *nk.Context, table: ColorArray) void {
    return c.nk_style_from_table(ctx, &table.values);
}

pub fn loadCursor(ctx: *nk.Context, cursor: nk.StyleCursor, cur: nk.Cursor) void {
    return c.nk_style_load_cursor(ctx, cursor, &cur);
}

pub fn loadAllCursors(ctx: *nk.Context, cursors: *const [c.NK_CURSOR_COUNT]nk.Cursor) void {
    return c.nk_style_load_all_cursors(ctx, nk.discardConst(cursors));
}

pub fn getColorByName(color: Colors) [:0]const u8 {
    const name = getColorByNameZ(color);
    return mem.spanZ(name);
}

pub fn getColorByNameZ(color: Colors) [*:0]const u8 {
    return @ptrCast([*:0]const u8, c.nk_style_get_color_by_name(color.toNuklear()));
}

pub fn setFont(ctx: *nk.Context, font: *const nk.UserFont) void {
    return c.nk_style_set_font(ctx, font);
}

pub fn setCursor(ctx: *nk.Context, u: nk.StyleCursor) bool {
    return c.nk_style_set_cursor(ctx, u) != 0;
}

pub fn showCursor(ctx: *nk.Context) void {
    return c.nk_style_show_cursor(ctx);
}

pub fn hideCursor(ctx: *nk.Context) void {
    return c.nk_style_hide_cursor(ctx);
}

pub fn pushFont(ctx: *nk.Context, font: *const nk.UserFont) bool {
    return c.nk_style_push_font(ctx, font) != 0;
}

pub fn popFont(ctx: *nk.Context) bool {
    return c.nk_style_pop_font(ctx) != 0;
}

pub fn itemImage(img: nk.Image) nk.StyleItem {
    return c.nk_style_item_image(img);
}

pub fn itemColor(y: nk.Color) nk.StyleItem {
    return c.nk_style_item_color(y);
}

pub fn itemHide() nk.StyleItem {
    return c.nk_style_item_hide();
}

test {
    std.testing.refAllDecls(@This());
}
