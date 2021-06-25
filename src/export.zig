const c = @import("c.zig");
const std = @import("std");

const debug = std.debug;
const fmt = std.fmt;
const math = std.math;
const mem = std.mem;
const sort = std.sort;

export fn zigNuklearAssert(ok: c_int) callconv(.C) void {
    debug.assert(ok != 0);
}

export fn zigNuklearSqrt(x: f32) callconv(.C) f32 {
    return math.sqrt(x);
}

export fn zigNuklearSin(x: f32) callconv(.C) f32 {
    return math.sin(x);
}

export fn zigNuklearCos(x: f32) callconv(.C) f32 {
    return math.cos(x);
}

export fn zigNuklearAcos(x: f32) callconv(.C) f32 {
    return math.acos(x);
}

export fn zigNuklearFmod(x: f32, y: f32) callconv(.C) f32 {
    return @rem(x, y);
}

export fn zigNuklearFabs(x: f32) callconv(.C) f32 {
    return math.fabs(x);
}

export fn zigNuklearDtoa(out: [*]u8, n: f64) callconv(.C) [*]u8 {
    const res = fmt.bufPrint(out[0..c.NK_MAX_NUMBER_BUFFER], "{}", .{n}) catch unreachable;
    return out + res.len;
}

export fn zigNuklearStrlen(str: [*:0]const u8) callconv(.C) c.nk_size {
    return mem.lenZ(str);
}

export fn zigNuklearMemcopy(dst: [*]u8, src: [*]const u8, n: c.nk_size) callconv(.C) [*]u8 {
    @memcpy(dst, src, n);
    return dst;
}

export fn zigNuklearMemset(dst: [*]u8, char: c_int, n: c.nk_size) callconv(.C) [*]u8 {
    @memset(dst, @intCast(u8, char), n);
    return dst;
}

const Compare = fn (*const [16]u8, *const [16]u8) callconv(.C) c_int;

export fn zigNuklearSort(
    base: [*][16]u8,
    nmemb: c.nk_size,
    size: c.nk_size,
    cmp: Compare,
) callconv(.C) void {
    // This only ever sorts stbrp_rect types, which are documented to be 16 bytes.
    debug.assert(size == 16);
    sort.sort([16]u8, base[0..nmemb], cmp, struct {
        fn compare(ctx: Compare, a: [16]u8, b: [16]u8) bool {
            const res = ctx(&a, &b);
            return math.order(res, 0) == .lt;
        }
    }.compare);
}

export fn zigNuklearStrtod(str: c.struct_nk_slice, end_ptr: ?*c.struct_nk_slice) callconv(.C) f64 {
    // We don't support setting the end_ptr and nuklear always passes null to us
    debug.assert(end_ptr == null);
    return fmt.parseFloat(f64, str.ptr[0..str.len]) catch 0.0;
}
