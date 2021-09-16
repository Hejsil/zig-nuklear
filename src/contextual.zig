const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const testing = std.testing;

pub fn begin(ctx: *nk.Context, y: nk.Flags, a: nk.Vec2, trigger_bounds: nk.Rect) bool {
    return c.nk_contextual_begin(ctx, y, a, trigger_bounds) != 0;
}

pub fn itemLabel(ctx: *nk.Context, a: []const u8, alignment: nk.Flags) bool {
    return c.nk_contextual_item_label(ctx, nk.slice(a), alignment) != 0;
}

pub fn itemImageLabel(ctx: *nk.Context, y: nk.Image, a: []const u8, alignment: nk.Flags) bool {
    return c.nk_contextual_item_image_label(ctx, y, nk.slice(a), alignment) != 0;
}

pub fn itemSymbolLabel(
    ctx: *nk.Context,
    symbol: nk.SymbolType,
    a: []const u8,
    alignment: nk.Flags,
) bool {
    return c.nk_contextual_item_symbol_label(ctx, symbol.toNuklear(), nk.slice(a), alignment) != 0;
}

pub fn close(ctx: *nk.Context) void {
    return c.nk_contextual_close(ctx);
}

pub fn end(ctx: *nk.Context) void {
    return c.nk_contextual_end(ctx);
}

test {
    std.testing.refAllDecls(@This());
}
