const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub const LayoutState = c.nk_widget_layout_states;

pub fn widget(rect: *nk.Rect, ctx: *const nk.Context) LayoutState {
    return c.nk_widget(rect, ctx);
}

pub fn fitting(rect: *nk.Rect, ctx: *nk.Context) LayoutState {
    return c.nk_widget_fitting(rect, ctx);
}

pub fn bounds(ctx: *nk.Context) nk.Rect {
    return c.nk_widget_bounds(ctx);
}

pub fn position(ctx: *nk.Context) nk.Vec2 {
    return c.nk_widget_position(ctx);
}

pub fn size(ctx: *nk.Context) nk.Vec2 {
    return c.nk_widget_size(ctx);
}

pub fn width(ctx: *nk.Context) f32 {
    return c.nk_widget_width(ctx);
}

pub fn height(ctx: *nk.Context) f32 {
    return c.nk_widget_height(ctx);
}

pub fn isHovered(ctx: *nk.Context) bool {
    return c.nk_widget_is_hovered(ctx) != 0;
}

pub fn isMouseClicked(ctx: *nk.Context, bots: nk.input.Buttons) bool {
    return c.nk_widget_is_mouse_clicked(ctx, bots) != 0;
}

pub fn hasMouseClickDown(ctx: *nk.Context, bots: nk.input.Buttons, down: bool) bool {
    return c.nk_widget_has_mouse_click_down(ctx, bots, @boolToInt(down)) != 0;
}

pub fn spacing(ctx: *nk.Context, cols: usize) void {
    return c.nk_spacing(ctx, @intCast(c_int, cols));
}

test {
    testing.refAllDecls(@This());
}
