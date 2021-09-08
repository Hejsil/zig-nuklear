const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const testing = std.testing;

pub const Text = c.nk_text_edit;

pub fn string(ctx: *nk.Context, flags: nk.Flags, buf: *[]u8, max: usize, filter: nk.Filter) nk.Flags {
    var c_len = @intCast(c_int, buf.len);
    defer buf.len = @intCast(usize, c_len);
    return c.nk_edit_string(ctx, flags, buf.ptr, &c_len, @intCast(c_int, max), filter);
}

pub fn stringZ(ctx: *nk.Context, flags: nk.Flags, buf: [*:0]u8, max: usize, filter: nk.Filter) nk.Flags {
    return c.nk_edit_string_zero_terminated(ctx, flags, buf, @intCast(c_int, max), filter);
}

pub fn buffer(ctx: *nk.Context, flags: nk.Flags, t: *Text, filter: nk.Filter) nk.Flags {
    return c.nk_edit_buffer(ctx, flags, t, filter);
}

pub fn focus(ctx: *nk.Context, flags: nk.Flags) void {
    return c.nk_edit_focus(ctx, flags);
}

pub fn unfocus(ctx: *nk.Context) void {
    return c.nk_edit_unfocus(ctx);
}

test {
    testing.refAllDecls(@This());
}
