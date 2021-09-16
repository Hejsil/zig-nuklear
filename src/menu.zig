const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const testing = std.testing;

pub fn beginLabel(ctx: *nk.Context, a: []const u8, alignment: nk.Flags, size: nk.Vec2) bool {
    return c.nk_menu_begin_label(ctx, nk.slice(a), alignment, size) != 0;
}

pub fn beginImage(ctx: *nk.Context, y: []const u8, a: nk.Image, size: nk.Vec2) bool {
    return c.nk_menu_begin_image(ctx, nk.slice(y), a, size) != 0;
}

pub fn beginImageLabel(
    ctx: *nk.Context,
    y: []const u8,
    alignment: nk.Flags,
    a: nk.Image,
    size: nk.Vec2,
) bool {
    return c.nk_menu_begin_image_label(ctx, nk.slice(y), alignment, a, size) != 0;
}

pub fn beginSymbol(ctx: *nk.Context, y: []const u8, symbol: nk.SymbolType, size: nk.Vec2) bool {
    return c.nk_menu_begin_symbol(ctx, nk.slice(y), symbol.toNuklear(), size) != 0;
}

pub fn beginSymbolLabel(
    ctx: *nk.Context,
    y: []const u8,
    alignment: nk.Flags,
    symbol: nk.SymbolType,
    size: nk.Vec2,
) bool {
    return c.nk_menu_begin_symbol_label(
        ctx,
        nk.slice(y),
        alignment,
        symbol.toNuklear(),
        size,
    ) != 0;
}

pub fn itemLabel(ctx: *nk.Context, a: []const u8, alignment: nk.Flags) bool {
    return c.nk_menu_item_label(ctx, nk.slice(a), alignment) != 0;
}

pub fn itemImageLabel(ctx: *nk.Context, y: nk.Image, a: []const u8, alignment: nk.Flags) bool {
    return c.nk_menu_item_image_label(ctx, y, nk.slice(a), alignment) != 0;
}

pub fn itemSymbolLabel(
    ctx: *nk.Context,
    symbol: nk.SymbolType,
    a: []const u8,
    alignment: nk.Flags,
) bool {
    return c.nk_menu_item_symbol_label(
        ctx,
        symbol.toNuklear(),
        nk.slice(a),
        alignment,
    ) != 0;
}

pub fn close(ctx: *nk.Context) void {
    return c.nk_menu_close(ctx);
}

pub fn end(ctx: *nk.Context) void {
    return c.nk_menu_end(ctx);
}

test {
    testing.refAllDecls(@This());
}
