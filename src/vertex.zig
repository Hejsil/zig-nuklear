const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const testing = std.testing;

pub fn convert(
    ctx: *nk.Context,
    cmds: *nk.Buffer,
    vertices: *nk.Buffer,
    elements: *nk.Buffer,
    config: nk.ConvertConfig,
) nk.Flags {
    return c.nk_convert(ctx, &cmds.c, &vertices.c, &elements.c, &config);
}

pub fn iterator(ctx: *const nk.Context, buf: *const nk.Buffer) Iterator {
    return .{ .ctx = ctx, .buf = buf };
}

pub const Iterator = struct {
    ctx: *const nk.Context,
    buf: *const nk.Buffer,
    prev: ?*const nk.DrawCommand = null,

    pub fn next(it: *Iterator) ?*const nk.DrawCommand {
        const res = (if (it.prev) |p|
            c.nk__draw_next(p, &it.buf.c, it.ctx)
        else
            c.nk__draw_begin(it.ctx, &it.buf.c)) orelse return null;

        defer it.prev = res;
        return res;
    }
};

test {
    testing.refAllDecls(@This());
}
