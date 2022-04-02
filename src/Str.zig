const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

const Str = @This();

c: c.struct_nk_str,

pub fn init(allocator: mem.Allocator, size: usize) Str {
    var res: Str = undefined;
    c.nk_str_init(&res.c, &nk.allocator(allocator), size);
    return res;
}

pub fn initFixed(bytes: []u8) Str {
    var res: Str = undefined;
    c.nk_str_init_fixed(&res.c, @ptrCast(*anyopaque, bytes.ptr), bytes.len);
    return res;
}

pub fn clear(str: *Str) void {
    return c.nk_str_clear(&str.c);
}

pub fn free(str: *Str) void {
    return c.nk_str_free(&str.c);
}

pub fn appendStrChar(str: *Str, t: []const u8) usize {
    const res = c.nk_str_append_str_char(&str.c, nk.slice(t));
    return @intCast(usize, res);
}

pub fn appendStrRunes(str: *Str, runes: []const nk.Rune) c_int {
    return c.nk_str_append_str_runes(&str.c, runes.ptr, runes.len);
}

pub fn insertAtChar(str: *Str, pos: c_int, t: []const u8) c_int {
    return c.nk_str_insert_at_char(&str.c, pos, nk.slice(t));
}

pub fn insertAtRune(str: *Str, pos: c_int, t: []const u8) c_int {
    return c.nk_str_insert_at_rune(&str.c, pos, nk.slice(t));
}

pub fn insertTextRunes(str: *Str, pos: c_int, a: [*c]const nk.Rune, u: c_int) c_int {
    return c.nk_str_insert_text_runes(&str.c, pos, a, u);
}

pub fn insertStrRunes(str: *Str, pos: c_int, a: [*c]const nk.Rune) c_int {
    return c.nk_str_insert_str_runes(&str.c, pos, a);
}

pub fn removeChars(str: *Str, n: usize) void {
    return c.nk_str_remove_chars(&str.c, @intCast(c_int, n));
}

pub fn removeRunes(str: *Str, n: usize) void {
    return c.nk_str_remove_runes(&str.c, @intCast(c_int, n));
}

pub fn deleteChars(str: *Str, pos: usize, n: usize) void {
    return c.nk_str_delete_chars(&str.c, @intCast(c_int, pos), @intCast(c_int, n));
}

pub fn deleteRunes(str: *Str, pos: usize, n: usize) void {
    return c.nk_str_delete_runes(&str.c, @intCast(c_int, pos), @intCast(c_int, n));
}

pub fn atChar(str: *Str, pos: usize) *u8 {
    return c.nk_str_at_char(&str.c, @intCast(c_int, pos));
}

pub const RuneAtResult = struct {
    unicode: nk.Rune,
    slice: []u8,
};

pub fn atRune(str: *Str, pos: usize) RuneAtResult {
    var unicode: nk.Rune = undefined;
    var l: c_int = undefined;
    const ptr = c.nk_str_at_rune(&str.c, @intCast(c_int, pos), &unicode, &l);
    return .{ .unicode = unicode, .slice = ptr[0..@intCast(usize, l)] };
}

pub fn runeAt(str: Str, pos: c_int) nk.Rune {
    return c.nk_str_rune_at(&str.c, pos);
}

pub fn atCharConst(str: Str, pos: c_int) *const u8 {
    return c.nk_str_at_char_const(&str.c, pos);
}

pub fn atConst(str: Str, pos: c_int, unicode: [*c]nk.Rune) []const u8 {
    const res = c.nk_str_at_const(&str.c, pos, unicode);
    return res.ptr[0..res.len];
}

pub fn get(str: *Str) []u8 {
    return nk.discardConst(str.getConst());
}

pub fn getConst(str: Str) []const u8 {
    const res = c.nk_str_get_const(&str.c);
    return res.ptr[0..res.len];
}

pub fn len(str: *Str) c_int {
    return c.nk_str_len(&str.c);
}

test {
    testing.refAllDecls(@This());
}
