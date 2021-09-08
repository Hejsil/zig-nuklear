const std = @import("std");
pub const c = @import("src/c.zig");

const builtin = std.builtin;
const debug = std.debug;
const math = std.math;
const mem = std.mem;
const meta = std.meta;

const nk = @This();

pub const atlas = @import("src/atlas.zig");
pub const bar = @import("src/bar.zig");
pub const button = @import("src/button.zig");
pub const chart = @import("src/chart.zig");
pub const checkbox = @import("src/checkbox.zig");
pub const check = @import("src/check.zig");
pub const color = @import("src/color.zig");
pub const combo = @import("src/combo.zig");
pub const contextual = @import("src/contextual.zig");
pub const edit = @import("src/edit.zig");
pub const group = @import("src/group.zig");
pub const input = @import("src/input.zig");
pub const layout = @import("src/layout.zig");
pub const list = @import("src/list.zig");
pub const menubar = @import("src/menubar.zig");
pub const menu = @import("src/menu.zig");
pub const option = @import("src/option.zig");
pub const popup = @import("src/popup.zig");
pub const property = @import("src/property.zig");
pub const radio = @import("src/radio.zig");
pub const selectable = @import("src/selectable.zig");
pub const select = @import("src/select.zig");
pub const slide = @import("src/slide.zig");
pub const slider = @import("src/slider.zig");
pub const stroke = @import("src/stroke.zig");
pub const style = @import("src/style.zig");
pub const testing = @import("src/testing.zig");
pub const Text = @import("src/TextEdit.zig");
pub const text = @import("src/text.zig");
pub const tooltip = @import("src/tooltip.zig");
pub const tree = @import("src/tree.zig");
pub const vertex = @import("src/vertex.zig");
pub const widget = @import("src/widget.zig");
pub const window = @import("src/window.zig");

pub const Buffer = @import("src/Buffer.zig");
pub const Str = @import("src/Str.zig");

pub const utf_size = c.NK_UTF_SIZE;

pub const rest = struct {
    test {
        std.testing.refAllDecls(@This());
    }

    pub fn nkRgbIv(_rgb: [*c]const c_int) nk.Color {
        return c.nk_rgb_iv(_rgb);
    }
    pub fn nkRgbBv(_rgb: [*c]const u8) nk.Color {
        return c.nk_rgb_bv(_rgb);
    }
    pub fn nkRgbFv(_rgb: [*c]const f32) nk.Color {
        return c.nk_rgb_fv(_rgb);
    }
    pub fn nkRgbCf(y: nk.Colorf) nk.Color {
        return c.nk_rgb_cf(y);
    }
    pub fn nkRgbHex(_rgb: []const u8) nk.Color {
        return c.nk_rgb_hex(nk.slice(_rgb));
    }
    pub fn nkRgbaU32(i: c_uint) nk.Color {
        return c.nk_rgba_u32(i);
    }
    pub fn nkRgbaIv(_rgba: [*c]const c_int) nk.Color {
        return c.nk_rgba_iv(_rgba);
    }
    pub fn nkRgbaBv(_rgba: [*c]const u8) nk.Color {
        return c.nk_rgba_bv(_rgba);
    }
    pub fn nkRgbaF(r: f32, g: f32, b: f32, a: f32) nk.Color {
        return c.nk_rgba_f(r, g, b, a);
    }
    pub fn nkRgbaFv(_rgba: [*c]const f32) nk.Color {
        return c.nk_rgba_fv(_rgba);
    }
    pub fn nkRgbaCf(y: nk.Colorf) nk.Color {
        return c.nk_rgba_cf(y);
    }
    pub fn nkRgbaHex(_rgb: []const u8) nk.Color {
        return c.nk_rgba_hex(nk.slice(_rgb));
    }
    pub fn nkHsvaColorf(h: f32, s: f32, v: f32, a: f32) nk.Colorf {
        return c.nk_hsva_colorf(h, s, v, a);
    }
    pub fn nkHsvaColorfv(y: [*c]f32) nk.Colorf {
        return c.nk_hsva_colorfv(y);
    }
    pub fn nkColorfHsvaF(out_h: [*c]f32, out_s: [*c]f32, out_v: [*c]f32, out_a: [*c]f32, in: nk.Colorf) void {
        return c.nk_colorf_hsva_f(out_h, out_s, out_v, out_a, in);
    }
    pub fn nkColorfHsvaFv(_hsva: [*c]f32, in: nk.Colorf) void {
        return c.nk_colorf_hsva_fv(_hsva, in);
    }
    pub fn nkHsvIv(_hsv: [*c]const c_int) nk.Color {
        return c.nk_hsv_iv(_hsv);
    }
    pub fn nkHsvBv(_hsv: [*c]const u8) nk.Color {
        return c.nk_hsv_bv(_hsv);
    }
    pub fn nkHsvFv(_hsv: [*c]const f32) nk.Color {
        return c.nk_hsv_fv(_hsv);
    }
    pub fn nkHsvaIv(_hsva: [*c]const c_int) nk.Color {
        return c.nk_hsva_iv(_hsva);
    }
    pub fn nkHsvaBv(_hsva: [*c]const u8) nk.Color {
        return c.nk_hsva_bv(_hsva);
    }
    pub fn nkHsvaFv(_hsva: [*c]const f32) nk.Color {
        return c.nk_hsva_fv(_hsva);
    }
    pub fn nkColorF(r: [*c]f32, g: [*c]f32, b: [*c]f32, a: [*c]f32, u: nk.Color) void {
        return c.nk_color_f(r, g, b, a, u);
    }
    pub fn nkColorFv(rgba_out: [*c]f32, u: nk.Color) void {
        return c.nk_color_fv(rgba_out, u);
    }
    pub fn nkColorCf(y: nk.Color) nk.Colorf {
        return c.nk_color_cf(y);
    }
    pub fn nkColorD(r: [*c]f64, g: [*c]f64, b: [*c]f64, a: [*c]f64, u: nk.Color) void {
        return c.nk_color_d(r, g, b, a, u);
    }
    pub fn nkColorDv(rgba_out: [*c]f64, u: nk.Color) void {
        return c.nk_color_dv(rgba_out, u);
    }
    pub fn nkColorHexRgba(output: [*c]u8, u: nk.Color) void {
        return c.nk_color_hex_rgba(output, u);
    }
    pub fn nkColorHexRgb(output: [*c]u8, u: nk.Color) void {
        return c.nk_color_hex_rgb(output, u);
    }
    pub fn nkColorHsvI(out_h: [*c]c_int, out_s: [*c]c_int, out_v: [*c]c_int, u: nk.Color) void {
        return c.nk_color_hsv_i(out_h, out_s, out_v, u);
    }
    pub fn nkColorHsvB(out_h: [*c]u8, out_s: [*c]u8, out_v: [*c]u8, u: nk.Color) void {
        return c.nk_color_hsv_b(out_h, out_s, out_v, u);
    }
    pub fn nkColorHsvIv(hsv_out: [*c]c_int, u: nk.Color) void {
        return c.nk_color_hsv_iv(hsv_out, u);
    }
    pub fn nkColorHsvBv(hsv_out: [*c]u8, u: nk.Color) void {
        return c.nk_color_hsv_bv(hsv_out, u);
    }
    pub fn nkColorHsvF(out_h: [*c]f32, out_s: [*c]f32, out_v: [*c]f32, u: nk.Color) void {
        return c.nk_color_hsv_f(out_h, out_s, out_v, u);
    }
    pub fn nkColorHsvFv(hsv_out: [*c]f32, u: nk.Color) void {
        return c.nk_color_hsv_fv(hsv_out, u);
    }
    pub fn nkColorHsvaI(h: [*c]c_int, s: [*c]c_int, v: [*c]c_int, a: [*c]c_int, u: nk.Color) void {
        return c.nk_color_hsva_i(h, s, v, a, u);
    }
    pub fn nkColorHsvaB(h: [*c]u8, s: [*c]u8, v: [*c]u8, a: [*c]u8, u: nk.Color) void {
        return c.nk_color_hsva_b(h, s, v, a, u);
    }
    pub fn nkColorHsvaIv(hsva_out: [*c]c_int, u: nk.Color) void {
        return c.nk_color_hsva_iv(hsva_out, u);
    }
    pub fn nkColorHsvaBv(hsva_out: [*c]u8, u: nk.Color) void {
        return c.nk_color_hsva_bv(hsva_out, u);
    }
    pub fn nkColorHsvaF(out_h: [*c]f32, out_s: [*c]f32, out_v: [*c]f32, out_a: [*c]f32, u: nk.Color) void {
        return c.nk_color_hsva_f(out_h, out_s, out_v, out_a, u);
    }
    pub fn nkColorHsvaFv(hsva_out: [*c]f32, u: nk.Color) void {
        return c.nk_color_hsva_fv(hsva_out, u);
    }

    //

    pub fn nkHandlePtr(ptr: ?*c_void) nk.Handle {
        return c.nk_handle_ptr(ptr);
    }
    pub fn nkHandleId(h: c_int) nk.Handle {
        return c.nk_handle_id(h);
    }
    pub fn nkImageHandle(h: nk.Handle) nk.Image {
        return c.nk_image_handle(h);
    }
    pub fn nkImagePtr(ptr: ?*c_void) nk.Image {
        return c.nk_image_ptr(ptr);
    }
    pub fn nkImageId(_id: c_int) nk.Image {
        return c.nk_image_id(_id);
    }
    pub fn nkImageIsSubimage(img: [*c]const nk.Image) bool {
        return c.nk_image_is_subimage(img) != 0;
    }
    pub fn nkSubimagePtr(ptr: ?*c_void, w: c_ushort, h: c_ushort, sub_region: nk.Rect) nk.Image {
        return c.nk_subimage_ptr(ptr, w, h, sub_region);
    }
    pub fn nkSubimageId(_id: c_int, w: c_ushort, h: c_ushort, sub_region: nk.Rect) nk.Image {
        return c.nk_subimage_id(_id, w, h, sub_region);
    }
    pub fn nkSubimageHandle(h: nk.Handle, w: c_ushort, q: c_ushort, sub_region: nk.Rect) nk.Image {
        return c.nk_subimage_handle(h, w, q, sub_region);
    }
    pub fn nkMurmurHash(key: []const u8, seed: nk.Hash) nk.Hash {
        return c.nk_murmur_hash(nk.slice(key), seed);
    }
    pub fn nkTriangleFromDirection(result: [*c]nk.Vec2, r: nk.Rect, pad_x: f32, pad_y: f32, u: nk.Heading) void {
        return c.nk_triangle_from_direction(result, r, pad_x, pad_y, u);
    }
    pub fn nkGetNullRect() nk.Rect {
        return c.nk_get_null_rect();
    }

    //

    pub fn nkFontDefaultGlyphRanges() [*c]const nk.Rune {
        return c.nk_font_default_glyph_ranges();
    }
    pub fn nkFontChineseGlyphRanges() [*c]const nk.Rune {
        return c.nk_font_chinese_glyph_ranges();
    }
    pub fn nkFontCyrillicGlyphRanges() [*c]const nk.Rune {
        return c.nk_font_cyrillic_glyph_ranges();
    }
    pub fn nkFontKoreanGlyphRanges() [*c]const nk.Rune {
        return c.nk_font_korean_glyph_ranges();
    }

    //

    // pub fn nkFilterDefault(t: [*c]const nk.TextEdit, unicode: nk.Rune) bool {
    //     return c.nk_filter_default(t, unicode) != 0;
    // }
    // pub fn nkFilterAscii(t: [*c]const nk.TextEdit, unicode: nk.Rune) bool {
    //     return c.nk_filter_ascii(t, unicode) != 0;
    // }
    // pub fn nkFilterFloat(t: [*c]const nk.TextEdit, unicode: nk.Rune) bool {
    //     return c.nk_filter_float(t, unicode) != 0;
    // }
    // pub fn nkFilterDecimal(t: [*c]const nk.TextEdit, unicode: nk.Rune) bool {
    //     return c.nk_filter_decimal(t, unicode) != 0;
    // }
    // pub fn nkFilterHex(t: [*c]const nk.TextEdit, unicode: nk.Rune) bool {
    //     return c.nk_filter_hex(t, unicode) != 0;
    // }
    // pub fn nkFilterOct(t: [*c]const nk.TextEdit, unicode: nk.Rune) bool {
    //     return c.nk_filter_oct(t, unicode) != 0;
    // }
    // pub fn nkFilterBinary(t: [*c]const nk.TextEdit, unicode: nk.Rune) bool {
    //     return c.nk_filter_binary(t, unicode) != 0;
    // }

    //

    pub fn nkFillRect(b: [*c]nk.CommandBuffer, r: nk.Rect, rounding: f32, u: nk.Color) void {
        return c.nk_fill_rect(b, r, rounding, u);
    }
    pub fn nkFillRectMultiColor(b: [*c]nk.CommandBuffer, r: nk.Rect, left: nk.Color, top: nk.Color, right: nk.Color, bottom: nk.Color) void {
        return c.nk_fill_rect_multi_color(b, r, left, top, right, bottom);
    }
    pub fn nkFillCircle(b: [*c]nk.CommandBuffer, r: nk.Rect, a: nk.Color) void {
        return c.nk_fill_circle(b, r, a);
    }
    pub fn nkFillArc(b: [*c]nk.CommandBuffer, cx: f32, cy: f32, radius: f32, a_min: f32, a_max: f32, u: nk.Color) void {
        return c.nk_fill_arc(b, cx, cy, radius, a_min, a_max, u);
    }
    pub fn nkFillTriangle(b: [*c]nk.CommandBuffer, x0: f32, y0: f32, x1: f32, y1: f32, x2: f32, y2: f32, u: nk.Color) void {
        return c.nk_fill_triangle(b, x0, y0, x1, y1, x2, y2, u);
    }
    pub fn nkFillPolygon(b: [*c]nk.CommandBuffer, a: [*c]f32, point_count: c_int, u: nk.Color) void {
        return c.nk_fill_polygon(b, a, point_count, u);
    }

    //

    pub fn nkDrawImage(b: [*c]nk.CommandBuffer, r: nk.Rect, y: [*c]const nk.Image, a: nk.Color) void {
        return c.nk_draw_image(b, r, y, a);
    }
    pub fn nkDrawText(b: [*c]nk.CommandBuffer, r: nk.Rect, t: []const u8, d: [*c]const nk.UserFont, y: nk.Color, q: nk.Color) void {
        return c.nk_draw_text(b, r, nk.slice(t), d, y, q);
    }

    //

    pub fn nkPushScissor(b: [*c]nk.CommandBuffer, r: nk.Rect) void {
        return c.nk_push_scissor(b, r);
    }
    pub fn nkPushCustom(b: [*c]nk.CommandBuffer, r: nk.Rect, a: nk.CustomCallback, usr: nk.Handle) void {
        return c.nk_push_custom(b, r, a, usr);
    }

    //
};

pub const Allocator = c.struct_nk_allocator;
pub const BufferAllocatorType = c.enum_nk_buffer_allocation_type;
pub const Buttons = c.nk_buttons;
pub const ChartType = c.enum_nk_chart_type;
pub const CollapseStates = c.nk_collapse_states;
pub const Color = c.struct_nk_color;
pub const Colorf = c.struct_nk_colorf;
pub const CommandBuffer = c.struct_nk_command_buffer;
pub const Context = c.struct_nk_context;
pub const ConvertConfig = c.struct_nk_convert_config;
pub const Cursor = c.struct_nk_cursor;
pub const CustomCallback = c.nk_command_custom_callback;
pub const DrawCommand = c.struct_nk_draw_command;
pub const DrawIndex = c.nk_draw_index;
pub const DrawNullTexture = c.struct_nk_draw_null_texture;
pub const DrawVertexLayoutElement = c.struct_nk_draw_vertex_layout_element;
pub const Filter = c.nk_plugin_filter;
pub const Flags = c.nk_flags;
pub const FontAtlas = c.struct_nk_font_atlas;
pub const Handle = c.nk_handle;
pub const Hash = c.nk_hash;
pub const Heading = c.enum_nk_heading;
pub const Image = c.struct_nk_image;
pub const Input = c.struct_nk_input;
pub const Keys = c.nk_keys;
pub const MemoryStatus = c.struct_nk_memory_status;
pub const PopupType = c.enum_nk_popup_type;
pub const Rect = c.struct_nk_rect;
pub const Rune = c.nk_rune;
pub const Scroll = c.struct_nk_scroll;
pub const Slice = c.struct_nk_slice;
pub const StyleButton = c.struct_nk_style_button;
pub const StyleColors = c.enum_nk_style_colors;
pub const StyleCursor = c.enum_nk_style_cursor;
pub const StyleItem = c.struct_nk_style_item;
pub const UserFont = c.struct_nk_user_font;
pub const Vec2 = c.struct_nk_vec2;
pub const Window = c.struct_nk_window;

pub const Command = union(enum) {
    scissor: *const c.struct_nk_command_scissor,
    line: *const c.struct_nk_command_line,
    curve: *const c.struct_nk_command_curve,
    rect: *const c.struct_nk_command_rect,
    rect_filled: *const c.struct_nk_command_rect_filled,
    rect_multi_color: *const c.struct_nk_command_rect_multi_color,
    circle: *const c.struct_nk_command_circle,
    circle_filled: *const c.struct_nk_command_circle_filled,
    arc: *const c.struct_nk_command_arc,
    arc_filled: *const c.struct_nk_command_arc_filled,
    triangle: *const c.struct_nk_command_triangle,
    triangle_filled: *const c.struct_nk_command_triangle_filled,
    polygon: *const c.struct_nk_command_polygon,
    polygon_filled: *const c.struct_nk_command_polygon_filled,
    polyline: *const c.struct_nk_command_polyline,
    text: *const c.struct_nk_command_text,
    image: *const c.struct_nk_command_image,
    custom: *const c.struct_nk_command,

    pub fn fromNuklear(cmd: *const c.struct_nk_command) Command {
        switch (cmd.type) {
            .NK_COMMAND_SCISSOR => return .{ .scissor = @ptrCast(*const c.struct_nk_command_scissor, cmd) },
            .NK_COMMAND_LINE => return .{ .line = @ptrCast(*const c.struct_nk_command_line, cmd) },
            .NK_COMMAND_CURVE => return .{ .curve = @ptrCast(*const c.struct_nk_command_curve, cmd) },
            .NK_COMMAND_RECT => return .{ .rect = @ptrCast(*const c.struct_nk_command_rect, cmd) },
            .NK_COMMAND_RECT_FILLED => return .{ .rect_filled = @ptrCast(*const c.struct_nk_command_rect_filled, cmd) },
            .NK_COMMAND_RECT_MULTI_COLOR => return .{ .rect_multi_color = @ptrCast(*const c.struct_nk_command_rect_multi_color, cmd) },
            .NK_COMMAND_CIRCLE => return .{ .circle = @ptrCast(*const c.struct_nk_command_circle, cmd) },
            .NK_COMMAND_CIRCLE_FILLED => return .{ .circle_filled = @ptrCast(*const c.struct_nk_command_circle_filled, cmd) },
            .NK_COMMAND_ARC => return .{ .arc = @ptrCast(*const c.struct_nk_command_arc, cmd) },
            .NK_COMMAND_ARC_FILLED => return .{ .arc_filled = @ptrCast(*const c.struct_nk_command_arc_filled, cmd) },
            .NK_COMMAND_TRIANGLE => return .{ .triangle = @ptrCast(*const c.struct_nk_command_triangle, cmd) },
            .NK_COMMAND_TRIANGLE_FILLED => return .{ .triangle_filled = @ptrCast(*const c.struct_nk_command_triangle_filled, cmd) },
            .NK_COMMAND_POLYGON => return .{ .polygon = @ptrCast(*const c.struct_nk_command_polygon, cmd) },
            .NK_COMMAND_POLYGON_FILLED => return .{ .polygon_filled = @ptrCast(*const c.struct_nk_command_polygon_filled, cmd) },
            .NK_COMMAND_POLYLINE => return .{ .polyline = @ptrCast(*const c.struct_nk_command_polyline, cmd) },
            .NK_COMMAND_TEXT => return .{ .text = @ptrCast(*const c.struct_nk_command_text, cmd) },
            .NK_COMMAND_IMAGE => return .{ .image = @ptrCast(*const c.struct_nk_command_image, cmd) },
            .NK_COMMAND_CUSTOM => return .{ .custom = cmd },
            .NK_COMMAND_NOP => unreachable,
            else => unreachable,
        }
    }
};

pub const PanelFlags = struct {
    title: ?[]const u8 = null,
    border: bool = false,
    moveable: bool = false,
    scalable: bool = false,
    closable: bool = false,
    minimizable: bool = false,
    scrollbar: bool = true,
    scroll_auto_hide: bool = false,
    background: bool = false,
    input: bool = true,

    pub fn toNuklear(flags: PanelFlags) nk.Flags {
        return @intCast(nk.Flags, (if (flags.title) |_| c.NK_WINDOW_TITLE else 0) |
            (if (flags.border) c.NK_WINDOW_BORDER else 0) |
            (if (flags.moveable) c.NK_WINDOW_MOVABLE else 0) |
            (if (flags.scalable) c.NK_WINDOW_SCALABLE else 0) |
            (if (flags.closable) c.NK_WINDOW_CLOSABLE else 0) |
            (if (flags.minimizable) c.NK_WINDOW_MINIMIZABLE else 0) |
            (if (!flags.scrollbar) c.NK_WINDOW_NO_SCROLLBAR else 0) |
            (if (flags.scroll_auto_hide) c.NK_WINDOW_SCROLL_AUTO_HIDE else 0) |
            (if (flags.background) c.NK_WINDOW_BACKGROUND else 0) |
            (if (!flags.input) c.NK_WINDOW_NO_INPUT else 0));
    }
};

pub const SymbolType = enum(u8) {
    none = c.NK_SYMBOL_NONE,
    x = c.NK_SYMBOL_X,
    underscore = c.NK_SYMBOL_UNDERSCORE,
    circle_solid = c.NK_SYMBOL_CIRCLE_SOLID,
    circle_outline = c.NK_SYMBOL_CIRCLE_OUTLINE,
    rect_solid = c.NK_SYMBOL_RECT_SOLID,
    rect_outline = c.NK_SYMBOL_RECT_OUTLINE,
    triangle_up = c.NK_SYMBOL_TRIANGLE_UP,
    triangle_down = c.NK_SYMBOL_TRIANGLE_DOWN,
    triangle_left = c.NK_SYMBOL_TRIANGLE_LEFT,
    triangle_right = c.NK_SYMBOL_TRIANGLE_RIGHT,
    plus = c.NK_SYMBOL_PLUS,
    minus = c.NK_SYMBOL_MINUS,

    pub fn toNuklear(sym: SymbolType) c.enum_nk_symbol_type {
        return @intToEnum(c.enum_nk_symbol_type, @enumToInt(sym));
    }
};

pub const ScrollOffset = struct {
    x: usize,
    y: usize,
};

pub fn init(alloc: *mem.Allocator, font: ?*const UserFont) Context {
    var res: Context = undefined;
    const status = c.nk_init(&res, &allocator(alloc), font);

    // init only returns `0` if we pass `null` as the allocator.
    debug.assert(status != 0);
    return res;
}

pub fn initFixed(buf: []u8, font: *const UserFont) Context {
    var res: Context = undefined;
    const status = c.nk_init_fixed(&res, buf.ptr, buf.len, font);

    // init only returns `0` if we pass `null` as the buffer.
    debug.assert(status != 0);
    return res;
}
// pub fn initCustom(cmds: *Buffer, pool: *Buffer, font: Font) Context {}

pub fn clear(ctx: *Context) void {
    c.nk_clear(ctx);
}

pub fn free(ctx: *Context) void {
    c.nk_free(ctx);
}

pub fn iterator(ctx: *Context) Iterator {
    return .{ .ctx = ctx };
}

pub const Iterator = struct {
    ctx: *Context,
    prev: ?*const c.struct_nk_command = null,

    pub fn next(it: *Iterator) ?Command {
        const res = (if (it.prev) |p|
            c.nk__next(it.ctx, p)
        else
            c.nk__begin(it.ctx)) orelse return null;

        defer it.prev = res;
        return Command.fromNuklear(res);
    }
};

pub fn slice(s: []const u8) Slice {
    return .{
        .ptr = s.ptr,
        .len = s.len,
        ._pad = undefined,
    };
}

pub fn rect(x: f32, y: f32, w: f32, h: f32) Rect {
    return .{ .x = x, .y = y, .w = w, .h = h, ._pad = undefined };
}

pub fn vec2(x: f32, y: f32) Vec2 {
    return .{ .x = x, .y = y, ._pad = undefined, ._pad2 = undefined };
}

pub fn rgb(r: u8, g: u8, b: u8) nk.Color {
    return rgba(r, g, b, 255);
}

pub fn rgba(r: u8, g: u8, b: u8, a: u8) nk.Color {
    return c.nk_rgba(r, g, b, a);
}

pub fn rgbf(r: f32, g: f32, b: f32) nk.Color {
    return c.nk_rgb_f(r, g, b);
}

pub fn rgbaf(r: f32, g: f32, b: f32, a: f32) nk.Color {
    return c.nk_rgba_f(r, g, b, a);
}

pub fn hsv(h: u8, s: u8, v: u8) nk.Color {
    return hsva(h, s, v, 255);
}

pub fn hsva(h: u8, s: u8, v: u8, a: u8) nk.Color {
    return c.nk_hsva(h, s, v, a);
}

pub fn hsvf(h: f32, s: f32, v: f32) nk.Color {
    return c.nk_hsv_f(h, s, v);
}

pub fn hsvaf(h: f32, s: f32, v: f32, a: f32) nk.Color {
    return c.nk_hsva_f(h, s, v, a);
}

pub fn colorToU32(y: nk.Color) u32 {
    return @intCast(u32, c.nk_color_u32(y));
}

pub fn typeId(comptime T: type) usize {
    _ = T;

    // We generate a completly unique id by declaring a global variable `id` and taking
    // the address of that variable.
    const Id = struct {
        var addr: u8 = 0;
    };
    return @ptrToInt(&Id.addr);
}

pub fn id(comptime T: type) [@sizeOf(usize)]u8 {
    return @bitCast([@sizeOf(usize)]u8, typeId(T));
}

pub fn allocator(alloc: *mem.Allocator) Allocator {
    return .{
        .userdata = .{ .ptr = @ptrCast(*c_void, alloc) },
        .alloc = heap.alloc,
        .free = heap.free,
    };
}

fn DiscardConst(comptime Ptr: type) type {
    var info = @typeInfo(Ptr);
    info.Pointer.is_const = false;
    return @Type(info);
}

pub fn discardConst(ptr: anytype) DiscardConst(@TypeOf(ptr)) {
    const Res = DiscardConst(@TypeOf(ptr));
    switch (@typeInfo(Res).Pointer.size) {
        .Slice => {
            const res = discardConst(ptr.ptr);
            return res[0..ptr.len];
        },
        else => return @intToPtr(Res, @ptrToInt(ptr)),
    }
}

const heap = struct {
    // Nuklears allocator interface does not send back and forth the size of the allocation.
    // This is a problem, as zigs interface really wants you to pass back the size when
    // reallocating and freeing. To solve this, we store the size in a header block that is
    // stored in the memory before the pointer we return to nuklear.
    const header_align = @alignOf(Header);
    const header_size = @sizeOf(Header);
    const Header = struct {
        size: usize,
    };

    fn alloc(handle: Handle, m_old: ?*c_void, n: c.nk_size) callconv(.C) ?*c_void {
        const al = alignPtrCast(*mem.Allocator, handle.ptr);

        const res = if (@ptrCast(?[*]u8, m_old)) |old| blk: {
            const old_with_header = old - header_size;
            const header = alignPtrCast([*]Header, old_with_header)[0];

            const old_mem = old_with_header[0 .. header_size + header.size];
            if (al.resize(old_mem, n + header_size)) |resized| {
                break :blk resized;
            } else |_| {}

            // Resize failed. Give the caller new memory instead
            break :blk al.allocAdvanced(u8, header_align, n + header_size, .exact) catch
                return null;
        } else blk: {
            break :blk al.allocAdvanced(u8, header_align, n + header_size, .exact) catch
                return null;
        };

        // Store the size of the allocation in the extra memory we allocated, and return
        // a pointer after the header.
        alignPtrCast([*]Header, res.ptr)[0] = .{ .size = n };
        return @ptrCast(*c_void, res[header_size..].ptr);
    }

    fn free(handle: Handle, m_old: ?*c_void) callconv(.C) void {
        const old = @ptrCast(?[*]u8, m_old) orelse return;
        const old_with_header = old - header_size;
        const header = alignPtrCast([*]Header, old_with_header)[0];

        const al = alignPtrCast(*mem.Allocator, handle.ptr);
        al.free(old_with_header[0 .. header_size + header.size]);
    }

    fn alignPtrCast(comptime Ptr: type, ptr: anytype) Ptr {
        return @ptrCast(Ptr, @alignCast(@typeInfo(Ptr).Pointer.alignment, ptr));
    }
};

test {
    std.testing.refAllDecls(@This());
}

test "initFixed" {
    var font: UserFont = undefined;
    var buf: [1024]u8 = undefined;
    var ctx = &initFixed(&buf, &font);
    defer free(ctx);
}

// test "Context.initCustom" {
//     var ctx = Context.initCustom(&buf, null);
//     defer ctx.free();
// }
//
