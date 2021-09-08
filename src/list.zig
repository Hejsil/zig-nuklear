const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub fn begin(
    ctx: *nk.Context,
    id: []const u8,
    row_height: usize,
    row_count: usize,
    flags: nk.PanelFlags,
) ?View {
    const h = @intCast(c_int, row_height);
    const cnt = @intCast(c_int, row_count);

    var out: c.nk_list_view = undefined;
    if (c.nk_list_view_begin(
        ctx,
        &out,
        nk.slice(flags.title orelse id),
        flags.toNuklear(),
        h,
        cnt,
    ) == 0)
        return null;

    return View{
        .begin = @intCast(usize, out.begin),
        .end = @intCast(usize, out.end),
        .count = @intCast(usize, out.count),
        ._ctx = out.ctx,
        ._total_height = out.total_height,
        ._scroll_ptr = out.scroll_pointer,
        ._scroll_value = out.scroll_value,
    };
}

pub fn end(view: View) void {
    var list = c.nk_list_view{
        .begin = @intCast(c_int, view.begin),
        .end = @intCast(c_int, view.end),
        .count = @intCast(c_int, view.count),
        .total_height = view._total_height,
        .ctx = view._ctx,
        .scroll_pointer = view._scroll_ptr,
        .scroll_value = view._scroll_value,
    };
    c.nk_list_view_end(&list);
}

pub const View = struct {
    begin: usize,
    end: usize,
    count: usize,

    _total_height: c_int,
    _ctx: *nk.Context,
    _scroll_ptr: *c.nk_uint,
    _scroll_value: c.nk_uint,
};

test {
    testing.refAllDecls(@This());
}

test "list" {
    var ctx = &try nk.testing.init();
    defer nk.free(ctx);

    if (nk.window.begin(ctx, &nk.id(opaque {}), nk.rect(10, 10, 10, 10), .{})) |_| {
        nk.layout.rowDynamic(ctx, 10, 1);
        if (nk.list.begin(ctx, &nk.id(opaque {}), 10, 10, .{})) |list| {
            defer nk.list.end(list);
        }
    }
    nk.window.end(ctx);
}
