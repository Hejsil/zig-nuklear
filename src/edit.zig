const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const testing = std.testing;

pub const Text = c.nk_text_edit;

pub const Flags = struct {
    read_only: bool = false,
    auto_select: bool = false,
    sig_enter: bool = false,
    allow_tab: bool = false,
    no_cursor: bool = false,
    selectable: bool = false,
    clipboard: bool = false,
    ctrl_enter_newline: bool = false,
    no_horizontal_scroll: bool = false,
    always_insert_mode: bool = false,
    multiline: bool = false,
    goto_end_on_activate: bool = false,

    fn toNulkear(flags: Flags) nk.Flags {
        return @intCast(nk.Flags, (c.NK_EDIT_READ_ONLY * @boolToInt(flags.read_only)) |
            (c.NK_EDIT_AUTO_SELECT * @boolToInt(flags.auto_select)) |
            (c.NK_EDIT_SIG_ENTER * @boolToInt(flags.sig_enter)) |
            (c.NK_EDIT_ALLOW_TAB * @boolToInt(flags.allow_tab)) |
            (c.NK_EDIT_NO_CURSOR * @boolToInt(flags.no_cursor)) |
            (c.NK_EDIT_SELECTABLE * @boolToInt(flags.selectable)) |
            (c.NK_EDIT_CLIPBOARD * @boolToInt(flags.clipboard)) |
            (c.NK_EDIT_CTRL_ENTER_NEWLINE * @boolToInt(flags.ctrl_enter_newline)) |
            (c.NK_EDIT_NO_HORIZONTAL_SCROLL * @boolToInt(flags.no_horizontal_scroll)) |
            (c.NK_EDIT_ALWAYS_INSERT_MODE * @boolToInt(flags.always_insert_mode)) |
            (c.NK_EDIT_MULTILINE * @boolToInt(flags.multiline)) |
            (c.NK_EDIT_GOTO_END_ON_ACTIVATE * @boolToInt(flags.goto_end_on_activate)));
    }

    pub const simple = Flags{ .always_insert_mode = true };
    pub const field = Flags{
        .always_insert_mode = true,
        .selectable = true,
        .clipboard = true,
    };
    pub const box = Flags{
        .always_insert_mode = true,
        .selectable = true,
        .clipboard = true,
        .multiline = true,
        .allow_tab = true,
    };
    pub const editor = Flags{
        .selectable = true,
        .multiline = true,
        .allow_tab = true,
        .clipboard = true,
    };
};

pub const Options = struct {
    filter: nk.Filter = c.nk_filter_default,
    flags: Flags = Flags{},
};

pub fn string(
    ctx: *nk.Context,
    buf: *[]u8,
    max: usize,
    opts: Options,
) nk.Flags {
    var c_len = @intCast(c_int, buf.len);
    defer buf.len = @intCast(usize, c_len);
    return c.nk_edit_string(
        ctx,
        opts.flags.toNulkear(),
        buf.ptr,
        &c_len,
        @intCast(c_int, max),
        opts.filter,
    );
}

pub fn stringZ(
    ctx: *nk.Context,
    buf: [*:0]u8,
    max: usize,
    opts: Options,
) nk.Flags {
    return c.nk_edit_string_zero_terminated(
        ctx,
        opts.flags.toNulkear(),
        buf,
        @intCast(c_int, max),
        opts.filter,
    );
}

pub fn buffer(ctx: *nk.Context, t: *Text, opts: Options) nk.Flags {
    return c.nk_edit_buffer(ctx, opts.flags.toNulkear(), t, opts.filter);
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
