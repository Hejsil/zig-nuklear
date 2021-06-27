const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const builtin = std.builtin;
const debug = std.debug;
const heap = std.heap;
const math = std.math;
const mem = std.mem;
const meta = std.meta;
const testing = std.testing;

pub const Format = c.nk_layout_format;

pub fn resetMinRowHeight(ctx: *nk.Context) void {
    c.nk_layout_reset_min_row_height(ctx);
}

// pub fn widgetBounds(ctx: *nk.Context) nk.Rect {
//     const res = c.nk_layout_widget_bounds(ctx);
//     return nk.Rect.fromNuklear(&res).*;
// }

pub fn ratioFromPixel(ctx: *nk.Context, pixel_width: f32) f32 {
    return c.nk_layout_ratio_from_pixel(ctx, pixel_width);
}

pub fn rowDynamic(ctx: *nk.Context, height: f32, cols: usize) void {
    c.nk_layout_row_dynamic(ctx, height, @intCast(c_int, cols));
}

pub fn rowStatic(ctx: *nk.Context, height: f32, item_width: usize, cols: usize) void {
    c.nk_layout_row_static(ctx, height, @intCast(c_int, item_width), @intCast(c_int, cols));
}

pub fn rowBegin(ctx: *nk.Context, format: Format, row_height: f32, cols: usize) void {
    c.nk_layout_row_begin(ctx, format, row_height, @intCast(c_int, cols));
}

pub fn rowPush(ctx: *nk.Context, value: f32) void {
    c.nk_layout_row_push(ctx, value);
}

pub fn rowEnd(ctx: *nk.Context) void {
    c.nk_layout_row_end(ctx);
}

pub fn row(ctx: *nk.Context, format: Format, height: f32, ratios: []const f32) void {
    c.nk_layout_row(ctx, format, height, @intCast(c_int, ratios.len), ratios.ptr);
}

pub fn rowTemplateBegin(ctx: *nk.Context, row_height: f32) void {
    c.nk_layout_row_template_begin(ctx, row_height);
}

pub fn rowTemplatePushDynamic(ctx: *nk.Context) void {
    c.nk_layout_row_template_push_dynamic(ctx);
}

pub fn rowTemplatePushVariable(ctx: *nk.Context, min_width: f32) void {
    c.nk_layout_row_template_push_variable(ctx, min_width);
}

pub fn rowTemplatePushStatic(ctx: *nk.Context, width: f32) void {
    c.nk_layout_row_template_push_static(ctx, width);
}

pub fn rowTemplateEnd(ctx: *nk.Context) void {
    c.nk_layout_row_template_end(ctx);
}

pub fn spaceBegin(ctx: *nk.Context, format: Format, height: f32, widget_count: usize) void {
    const count = @intCast(c_int, math.max(widget_count, math.maxInt(c_int)));
    c.nk_layout_space_begin(ctx, format, height, count);
}

pub fn spacePush(ctx: *nk.Context, bounds: nk.Rect) void {
    c.nk_layout_space_push(ctx, bounds);
}

pub fn spaceEnd(ctx: *nk.Context) void {
    c.nk_layout_space_end(ctx);
}

// pub fn spaceBounds(ctx: *nk.Context) nk.Rect {
//     const res = c.nk_layout_space_bounds(ctx);
//     return nk.Rect.fromNuklear(&res).*;
// }

// pub fn spaceToScreen(ctx: *nk.Context, ret: Vec2) Vec2 {
//     const res = c.nk_layout_space_to_screen(ctx, ret);
//     return Vec2.fromNuklear(&res).*;
// }

// pub fn spaceToLocal(ctx: *nk.Context, ret: Vec2) Vec2 {
//     const res = c.nk_layout_space_to_local(ctx, ret);
//     return Vec2.fromNuklear(&res).*;
// }

// pub fn spaceRectToScreen(ctx: *nk.Context, ret: nk.Rect) nk.Rect {
//     const res = c.nk_layout_space_rect_to_screen(ctx, ret);
//     return nk.Rect.fromNuklear(&res).*;
// }

// pub fn spaceRectToLocal(ctx: *nk.Context, ret: nk.Rect) nk.Rect {
//     const res = c.nk_layout_space_rect_to_local(ctx, ret);
//     return nk.Rect.fromNuklear(&res).*;
// }

test {
    testing.refAllDecls(@This());
}
