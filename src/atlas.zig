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

pub const Config = c.struct_nk_font_config;
pub const Font = c.struct_nk_font;

pub const Format = enum(u8) {
    alpha8 = c.NK_FONT_ATLAS_ALPHA8,
    rgba32 = c.NK_FONT_ATLAS_RGBA32,
};

pub fn init(allocator: *mem.Allocator) nk.FontAtlas {
    var res: nk.FontAtlas = undefined;
    c.nk_font_atlas_init(&res, &nk.allocator(allocator));
    return res;
}

pub fn initCustom(persistent: *mem.Allocator, transient: *mem.Allocator) nk.FontAtlas {
    var res: nk.FontAtlas = undefined;
    c.nk_font_atlas_init_custom(
        &res,
        &nk.allocator(persistent),
        &nk.allocator(transient),
    );
    return res;
}

pub fn cleanup(atlas: *nk.FontAtlas) void {
    c.nk_font_atlas_cleanup(atlas);
}

pub fn clear(atlas: *nk.FontAtlas) void {
    c.nk_font_atlas_clear(atlas);
}

pub fn begin(atlas: *nk.FontAtlas) void {
    c.nk_font_atlas_begin(atlas);
}

pub fn add(atlas: *nk.FontAtlas, config: ?*const Config) !*Font {
    return c.nk_font_atlas_add(atlas, config) orelse
        return error.OutOfMemory;
}

pub fn addDefault(atlas: *nk.FontAtlas, height: f32, config: ?*const Config) !*Font {
    return c.nk_font_atlas_add_default(atlas, height, config) orelse
        return error.OutOfMemory;
}

pub fn addFromMemory(
    atlas: *nk.FontAtlas,
    memory: []const u8,
    height: f32,
    config: ?*const Config,
) !*Font {
    const ptr = @ptrCast(*const c_void, memory.ptr);
    return c.nk_font_atlas_add_from_memory(atlas, ptr, memory.len, height, config) orelse
        return error.OutOfMemory;
}

pub fn addCompressed(
    atlas: *nk.FontAtlas,
    data: []const u8,
    height: f32,
    config: ?*const Config,
) !*Font {
    const ptr = @ptrCast(*const c_void, data.ptr);
    return c.nk_font_atlas_add_compressed(atlas, ptr, data.len, height, config) orelse
        return error.OutOfMemory;
}

pub fn addCompressedBase85(
    atlas: *nk.FontAtlas,
    data: []const u8,
    height: f32,
    config: ?*const Config,
) !*Font {
    return c.nk_font_atlas_add_compressed_base85(atlas, nk.slice(data), height, config) orelse
        return error.OutOfMemory;
}

pub fn bake(atlas: *nk.FontAtlas, format: Format) !Baked {
    var w: c_int = undefined;
    var h: c_int = undefined;
    const data = c.nk_font_atlas_bake(
        atlas,
        &w,
        &h,
        @intToEnum(c.enum_nk_font_atlas_format, @enumToInt(format)),
    ) orelse
        return error.OutOfMemory;

    return Baked{
        .data = @ptrCast([*]const u8, data),
        .w = @intCast(usize, w),
        .h = @intCast(usize, h),
    };
}

pub fn end(atlas: *nk.FontAtlas, tex: nk.Handle, null_tex: ?*c.nk_draw_null_texture) void {
    c.nk_font_atlas_end(atlas, tex, null_tex);
}

pub const Baked = struct {
    data: [*]const u8,
    w: usize,
    h: usize,
};

test {
    testing.refAllDecls(@This());
}
