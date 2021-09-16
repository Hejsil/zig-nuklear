const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub fn label(ctx: *nk.Context, title: []const u8, flags: nk.Flags, value: *bool) bool {
    var c_value: c.nk_bool = @boolToInt(value.*);
    defer value.* = c_value != 0;
    return c.nk_selectable_label(ctx, nk.slice(title), flags, &c_value) != 0;
}

pub fn imageLabel(
    ctx: *nk.Context,
    img: nk.Image,
    title: []const u8,
    flags: nk.Flags,
    value: *bool,
) bool {
    var c_value: c.nk_bool = @boolToInt(value.*);
    defer value.* = c_value != 0;
    return c.nk_selectable_image_label(ctx, img, nk.slice(title), flags, &c_value) != 0;
}

pub fn symbolLabel(
    ctx: *nk.Context,
    symbol: nk.SymbolType,
    title: []const u8,
    flags: nk.Flags,
    value: *bool,
) bool {
    var c_value: c.nk_bool = @boolToInt(value.*);
    defer value.* = c_value != 0;
    return c.nk_selectable_symbol_label(
        ctx,
        symbol.toNuklear(),
        nk.slice(title),
        flags,
        &c_value,
    ) != 0;
}

test {
    testing.refAllDecls(@This());
}
