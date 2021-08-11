const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

const Buffer = @This();

inner: c.struct_nk_buffer,

pub fn init(allocator: *mem.Allocator, size: usize) Buffer {
    var res: Buffer = undefined;
    c.nk_buffer_init(&res.inner, &nk.allocator(allocator), size);
    return res;
}

pub fn initFixed(bytes: []u8) Buffer {
    var res: Buffer = undefined;
    c.nk_buffer_init_fixed(&res.inner, @ptrCast(*c_void, bytes.ptr), bytes.len);
    return res;
}

pub fn info(buffer: Buffer) nk.MemoryStatus {
    var res: nk.MemoryStatus = undefined;
    c.nk_buffer_info(&res, nk.discardConst(&buffer.inner));
    return res;
}

pub fn push(
    buffer: *nk.Buffer,
    type_: nk.BufferAllocatorType,
    bytes: []const u8,
    @"align": usize,
) void {
    return c.nk_buffer_push(
        &buffer.inner,
        type_,
        @ptrCast(*const c_void, bytes.ptr),
        bytes.len,
        @"align",
    );
}

pub fn mark(buffer: *Buffer, type_: nk.BufferAllocatorType) void {
    return c.nk_buffer_mark(&buffer.inner, type_);
}

pub fn reset(buffer: *nk.Buffer, type_: nk.BufferAllocatorType) void {
    return c.nk_buffer_reset(&buffer.inner, type_);
}

pub fn clear(buffer: *nk.Buffer) void {
    return c.nk_buffer_clear(&buffer.inner);
}

pub fn free(buffer: *Buffer) void {
    return c.nk_buffer_free(&buffer.inner);
}

pub fn memory(buffer: Buffer) []u8 {
    const total = c.nk_buffer_total(nk.discardConst(&buffer.inner));
    const bytes = c.nk_buffer_memory(nk.discardConst(&buffer.inner));
    return @ptrCast([*]u8, bytes)[0..total];
}

test {
    testing.refAllDecls(@This());
}
