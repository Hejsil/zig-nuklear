const c = @import("c.zig");
const nk = @import("../nuklear.zig");
const std = @import("std");

const mem = std.mem;
const testing = std.testing;

pub const Type = c.nk_tree_type;

pub fn push(
    ctx: *nk.Context,
    t: Type,
    title: []const u8,
    initial_state: nk.CollapseStates,
) bool {
    return pushId(ctx, t, title, initial_state, 0);
}

pub fn pushId(
    ctx: *nk.Context,
    t: Type,
    title: []const u8,
    initial_state: nk.CollapseStates,
    seed: usize,
) bool {
    return pushHashed(ctx, t, title, initial_state, title, seed);
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
    t: Type,
    img: nk.Image,
    title: []const u8,
    initial_state: nk.CollapseStates,
) bool {
    return imagePushId(ctx, t, img, title, initial_state, 0);
}

pub fn imagePushId(
    ctx: *nk.Context,
    t: Type,
    img: nk.Image,
    title: []const u8,
    initial_state: nk.CollapseStates,
    seed: usize,
) bool {
    return imagePushHashed(ctx, t, img, title, initial_state, title, seed);
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
    t: Type,
    title: []const u8,
    initial_state: nk.CollapseStates,
    selected: *bool,
) bool {
    return elementPushId(ctx, t, title, initial_state, selected, 0);
}

pub fn elementPushId(
    ctx: *nk.Context,
    t: Type,
    title: []const u8,
    initial_state: nk.CollapseStates,
    selected: *bool,
    seed: usize,
) bool {
    return elementPushHashed(ctx, t, title, initial_state, selected, title, seed);
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
    t: Type,
    img: nk.Image,
    title: []const u8,
    initial_state: nk.CollapseStates,
    selected: *bool,
) bool {
    return elementImagePushId(ctx, t, img, title, initial_state, selected, 0);
}

pub fn elementImagePushId(
    ctx: *nk.Context,
    t: Type,
    img: nk.Image,
    title: []const u8,
    initial_state: nk.CollapseStates,
    selected: *bool,
    seed: usize,
) bool {
    return elementImagePushHashed(ctx, t, img, title, initial_state, selected, title, seed);
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

    var selected: bool = false;
    if (nk.window.begin(ctx, &nk.id(opaque {}), nk.rect(10, 10, 10, 10), .{})) |_| {
        nk.layout.rowDynamic(ctx, 10, 1);
        if (nk.tree.push(ctx, .NK_TREE_TAB, "tree1", .NK_MINIMIZED)) {
            defer nk.tree.pop(ctx);
        }
        if (nk.tree.pushId(ctx, .NK_TREE_TAB, "tree2", .NK_MINIMIZED, 0)) {
            defer nk.tree.pop(ctx);
        }
        if (nk.tree.imagePush(ctx, .NK_TREE_TAB, undefined, "tree3", .NK_MINIMIZED)) {
            defer nk.tree.pop(ctx);
        }
        if (nk.tree.imagePushId(ctx, .NK_TREE_TAB, undefined, "tree4", .NK_MINIMIZED, 0)) {
            defer nk.tree.pop(ctx);
        }
        if (nk.tree.elementPush(ctx, .NK_TREE_TAB, "tree5", .NK_MINIMIZED, &selected)) {
            defer nk.tree.elementPop(ctx);
        }
        if (nk.tree.elementPushId(ctx, .NK_TREE_TAB, "tree6", .NK_MINIMIZED, &selected, 0)) {
            defer nk.tree.elementPop(ctx);
        }
        if (nk.tree.elementImagePush(ctx, .NK_TREE_TAB, undefined, "tree7", .NK_MINIMIZED, &selected)) {
            defer nk.tree.elementPop(ctx);
        }
        if (nk.tree.elementImagePushId(ctx, .NK_TREE_TAB, undefined, "tree8", .NK_MINIMIZED, &selected, 0)) {
            defer nk.tree.elementPop(ctx);
        }
    }
    nk.window.end(ctx);
}
