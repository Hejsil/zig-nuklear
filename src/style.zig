const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub fn default(ctx: *nk.Context) void {
    return c.nk_style_default(ctx);
}

pub fn fromTable(ctx: *nk.Context, table: *const [c.NK_COLOR_COUNT]nk.Color) void {
    return c.nk_style_from_table(ctx, table);
}

pub fn loadCursor(ctx: *nk.Context, cursor: nk.StyleCursor, cur: nk.Cursor) void {
    return c.nk_style_load_cursor(ctx, cursor, &cur);
}

pub fn loadAllCursors(ctx: *nk.Context, cursors: *const [c.NK_CURSOR_COUNT]nk.Cursor) void {
    return c.nk_style_load_all_cursors(ctx, nk.discardConst(cursors));
}

pub fn getColorByName(s: nk.StyleColors) [:0]const u8 {
    const name = getColorByNameZ(s);
    return mem.spanZ(name);
}

pub fn getColorByNameZ(s: nk.StyleColors) [*:0]const u8 {
    return @ptrCast([*:0]const u8, c.nk_style_get_color_by_name(s));
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
