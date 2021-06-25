const c = @import("c.zig");
const nk = @import("nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub const Type = c.nk_tree_type;

pub fn push(
    ctx: *nk.Context,
    comptime Id: type,
    t: Type,
    title: []const u8,
    initial_state: nk.CollapseStates,
) bool {
    const id = nk.typeId(Id);
    return pushHashed(ctx, t, title, initial_state, mem.asBytes(&id), id);
}

pub fn pushId(
    ctx: *nk.Context,
    comptime Id: type,
    t: Type,
    title: []const u8,
    initial_state: nk.CollapseStates,
    seed: usize,
) bool {
    const id = nk.typeId(Id);
    return pushHashed(ctx, t, title, initial_state, mem.asBytes(&id), seed);
}

pub fn pushHashed(
    ctx: *nk.Context,
    t: Type,
    title: []const u8,
    initial_state: nk.CollapseStates,
    hash: []const u8,
    seed: usize,
) bool {
    return c.nk_tree_push_hashed(
        ctx,
        t,
        nk.slice(title),
        initial_state,
        nk.slice(hash),
        @intCast(c_int, seed),
    ) != 0;
}

pub fn imagePush(
    ctx: *nk.Context,
    comptime Id: type,
    t: Type,
    img: nk.Image,
    title: []const u8,
    initial_state: nk.CollapseStates,
) bool {
    const id = nk.typeId(Id);
    return imagePushHashed(ctx, t, img, title, initial_state, mem.asBytes(&id), id);
}

pub fn imagePushId(
    ctx: *nk.Context,
    comptime Id: type,
    t: Type,
    img: nk.Image,
    title: []const u8,
    initial_state: nk.CollapseStates,
    seed: usize,
) bool {
    const id = nk.typeId(Id);
    return imagePushHashed(ctx, t, img, title, initial_state, mem.asBytes(&id), seed);
}

pub fn imagePushHashed(
    ctx: *nk.Context,
    t: Type,
    img: nk.Image,
    title: []const u8,
    initial_state: nk.CollapseStates,
    hash: []const u8,
    seed: usize,
) bool {
    return c.nk_tree_image_push_hashed(
        ctx,
        t,
        img,
        nk.slice(title),
        initial_state,
        nk.slice(hash),
        @intCast(c_int, seed),
    ) != 0;
}

pub fn pop(ctx: *nk.Context) void {
    c.nk_tree_pop(ctx);
}

pub fn statePush(ctx: *nk.Context, t: Type, title: []const u8, state: *nk.CollapseStates) bool {
    return c.nk_tree_state_push(ctx, t, nk.slice(title), state) != 0;
}

pub fn stateImagePush(
    ctx: *nk.Context,
    t: Type,
    img: nk.Image,
    title: []const u8,
    state: *nk.CollapseStates,
) bool {
    return c.nk_tree_state_image_push(ctx, t, img, nk.slice(title), state) != 0;
}

pub fn statePop(ctx: *nk.Context) void {
    c.nk_tree_state_pop(ctx);
}

pub fn elementPush(
    ctx: *nk.Context,
    comptime Id: type,
    t: Type,
    title: []const u8,
    initial_state: nk.CollapseStates,
    selected: *bool,
) bool {
    const id = nk.typeId(Id);
    return elementPushHashed(ctx, t, title, initial_state, selected, mem.asBytes(&id), id);
}

pub fn elementPushId(
    ctx: *nk.Context,
    comptime Id: type,
    t: Type,
    title: []const u8,
    initial_state: nk.CollapseStates,
    selected: *bool,
    seed: usize,
) bool {
    const id = nk.typeId(Id);
    return elementPushHashed(ctx, t, title, initial_state, selected, mem.asBytes(&id), seed);
}

pub fn elementPushHashed(
    ctx: *nk.Context,
    t: Type,
    title: []const u8,
    initial_state: nk.CollapseStates,
    selected: *bool,
    hash: []const u8,
    seed: usize,
) bool {
    var c_selected: c_int = undefined;
    defer selected.* = c_selected != 0;
    return c.nk_tree_element_push_hashed(
        ctx,
        t,
        nk.slice(title),
        initial_state,
        &c_selected,
        nk.slice(hash),
        @intCast(c_int, seed),
    ) != 0;
}

pub fn elementImagePush(
    ctx: *nk.Context,
    comptime Id: type,
    t: Type,
    img: nk.Image,
    title: []const u8,
    initial_state: nk.CollapseStates,
    selected: *bool,
) bool {
    const id = nk.typeId(Id);
    return elementImagePushHashed(ctx, t, img, title, initial_state, selected, mem.asBytes(&id), id);
}

pub fn elementImagePushId(
    ctx: *nk.Context,
    comptime Id: type,
    t: Type,
    img: nk.Image,
    title: []const u8,
    initial_state: nk.CollapseStates,
    selected: *bool,
    seed: usize,
) bool {
    const id = nk.typeId(Id);
    return elementImagePushHashed(ctx, t, img, title, initial_state, selected, mem.asBytes(&id), seed);
}

pub fn elementImagePushHashed(
    ctx: *nk.Context,
    t: Type,
    img: nk.Image,
    title: []const u8,
    initial_state: nk.CollapseStates,
    selected: *bool,
    hash: []const u8,
    seed: usize,
) bool {
    var c_selected: c_int = undefined;
    defer selected.* = c_selected != 0;
    return c.nk_tree_element_image_push_hashed(
        ctx,
        t,
        img,
        nk.slice(title),
        initial_state,
        &c_selected,
        nk.slice(hash),
        @intCast(c_int, seed),
    ) != 0;
}

pub fn elementPop(ctx: *nk.Context) void {
    c.nk_tree_element_pop(ctx);
}

test {
    testing.refAllDecls(@This());
}

test "list" {
    var ctx = &try nk.testing.init();
    defer nk.free(ctx);

    const flags = c.NK_WINDOW_BORDER | c.NK_WINDOW_MOVABLE | c.NK_WINDOW_SCALABLE |
        c.NK_WINDOW_CLOSABLE | c.NK_WINDOW_MINIMIZABLE | c.NK_WINDOW_TITLE;

    var selected: bool = false;
    if (nk.window.begin(ctx, opaque {}, "test", nk.rect(10, 10, 10, 10), flags)) |win| {
        nk.layout.rowDynamic(ctx, 10, 1);
        if (nk.tree.push(ctx, opaque {}, .NK_TREE_TAB, "tree", .NK_MINIMIZED)) {
            defer nk.tree.pop(ctx);
        }
        if (nk.tree.pushId(ctx, opaque {}, .NK_TREE_TAB, "tree", .NK_MINIMIZED, 0)) {
            defer nk.tree.pop(ctx);
        }
        if (nk.tree.imagePush(ctx, opaque {}, .NK_TREE_TAB, undefined, "tree", .NK_MINIMIZED)) {
            defer nk.tree.pop(ctx);
        }
        if (nk.tree.imagePushId(ctx, opaque {}, .NK_TREE_TAB, undefined, "tree", .NK_MINIMIZED, 0)) {
            defer nk.tree.pop(ctx);
        }
        if (nk.tree.elementPush(ctx, opaque {}, .NK_TREE_TAB, "tree", .NK_MINIMIZED, &selected)) {
            defer nk.tree.elementPop(ctx);
        }
        if (nk.tree.elementPushId(ctx, opaque {}, .NK_TREE_TAB, "tree", .NK_MINIMIZED, &selected, 0)) {
            defer nk.tree.elementPop(ctx);
        }
        if (nk.tree.elementImagePush(ctx, opaque {}, .NK_TREE_TAB, undefined, "tree", .NK_MINIMIZED, &selected)) {
            defer nk.tree.elementPop(ctx);
        }
        if (nk.tree.elementImagePushId(ctx, opaque {}, .NK_TREE_TAB, undefined, "tree", .NK_MINIMIZED, &selected, 0)) {
            defer nk.tree.elementPop(ctx);
        }
    }
    nk.window.end(ctx);
}
