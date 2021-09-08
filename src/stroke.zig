const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const testing = std.testing;

pub fn line(b: *nk.CommandBuffer, x0: f32, y0: f32, x1: f32, y1: f32, line_thickness: f32, col: nk.Color) void {
    return c.nk_stroke_line(b, x0, y0, x1, y1, line_thickness, col);
}

pub fn curve(
    b: *nk.CommandBuffer,
    ax: f32,
    ay: f32,
    ctrl0x: f32,
    ctrl0y: f32,
    ctrl1x: f32,
    ctrl1y: f32,
    bx: f32,
    by: f32,
    line_thickness: f32,
    col: nk.Color,
) void {
    return c.nk_stroke_curve(
        b,
        ax,
        ay,
        ctrl0x,
        ctrl0y,
        ctrl1x,
        ctrl1y,
        bx,
        by,
        line_thickness,
        col,
    );
}

pub fn rect(b: *nk.CommandBuffer, r: nk.Rect, rounding: f32, line_thickness: f32, col: nk.Color) void {
    return c.nk_stroke_rect(b, r, rounding, line_thickness, col);
}

pub fn circle(b: *nk.CommandBuffer, r: nk.Rect, line_thickness: f32, col: nk.Color) void {
    return c.nk_stroke_circle(b, r, line_thickness, col);
}

pub fn arc(b: *nk.CommandBuffer, cx: f32, cy: f32, radius: f32, a_min: f32, a_max: f32, line_thickness: f32, col: nk.Color) void {
    return c.nk_stroke_arc(b, cx, cy, radius, a_min, a_max, line_thickness, col);
}

pub fn triangle(b: *nk.CommandBuffer, h: f32, o: f32, q: f32, d: f32, y: f32, a: f32, line_thichness: f32, u: nk.Color) void {
    return c.nk_stroke_triangle(b, h, o, q, d, y, a, line_thichness, u);
}

pub fn polyline(b: *nk.CommandBuffer, points: [][2]f32, line_thickness: f32, col: nk.Color) void {
    return c.nk_stroke_polyline(
        b,
        @ptrCast([*]f32, points.ptr),
        @intCast(c_int, points.len),
        line_thickness,
        col,
    );
}

pub fn polygon(b: *nk.CommandBuffer, points: [][2]f32, line_thickness: f32, col: nk.Color) void {
    return c.nk_stroke_polygon(
        b,
        @ptrCast([*]f32, points.ptr),
        @intCast(c_int, points.len),
        line_thickness,
        col,
    );
}

test {
    testing.refAllDecls(@This());
}
