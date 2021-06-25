const c = @import("c.zig");
const nk = @import("nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

/// Same as `beginTitled` but instead of taking a `name` which the caller needs to ensure
/// is a unique string, this function generates a unique name for each unique type passed
/// to `id`.
pub fn begin(
    ctx: *nk.Context,
    comptime Id: type,
    title: []const u8,
    bounds: nk.Rect,
    flags: nk.Flags,
) ?*const nk.Window {
    const id = nk.typeId(Id);
    return beginTitled(ctx, mem.asBytes(&id), title, bounds, flags);
}

pub fn beginTitled(
    ctx: *nk.Context,
    name: []const u8,
    title: []const u8,
    bounds: nk.Rect,
    flags: nk.Flags,
) ?*const nk.Window {
    const res = c.nk_begin_titled(
        ctx,
        nk.slice(name),
        nk.slice(title),
        bounds,
        flags,
    );
    if (res == 0)
        return null;

    return ctx.current;
}

pub fn end(ctx: *nk.Context) void {
    c.nk_end(ctx);
}

pub fn find(ctx: *nk.Context, comptime Id: type) ?*const nk.Window {
    const id = nk.typeId(Id);
    return findByName(ctx, mem.asBytes(&id));
}

pub fn findByName(ctx: *nk.Context, name: []const u8) ?*const nk.Window {
    return c.nk_window_find(ctx, nk.slice(name));
}

pub fn hasFocus(ctx: *nk.Context, win: *const nk.Window) bool {
    return win == @as(*const nk.Window, ctx.active);
}

pub fn isHovered(ctx: *nk.Context, win: *const nk.Window) bool {
    if ((win.flags & c.NK_WINDOW_HIDDEN) != 0)
        return false;
    return c.nk_input_is_mouse_hovering_rect(&ctx.input, win.bounds) != 0;
}

pub fn isAnyHovered(ctx: *nk.Context) bool {
    return c.nk_window_is_any_hovered(ctx) != 0;
}

pub fn isAnyActive(ctx: *nk.Context) bool {
    return c.nk_item_is_any_active(ctx) != 0;
}

test {
    testing.refAllDecls(@This());
}

test "window" {
    var ctx = &try nk.testing.init();
    defer nk.free(ctx);

    const flags = c.NK_WINDOW_BORDER | c.NK_WINDOW_MOVABLE | c.NK_WINDOW_SCALABLE |
        c.NK_WINDOW_CLOSABLE | c.NK_WINDOW_MINIMIZABLE | c.NK_WINDOW_TITLE;

    const Id = opaque {};
    if (nk.window.begin(ctx, Id, "test", nk.rect(10, 10, 10, 10), flags)) |win| {
        try std.testing.expectEqual(@as(?*const nk.Window, win), nk.window.find(ctx, Id));
    }
    nk.window.end(ctx);
}
