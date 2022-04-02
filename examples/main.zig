const nk = @import("nuklear");
const std = @import("std");
const c = @cImport({
    @cInclude("GLFW/glfw3.h");
});
const examples = @import("examples.zig");

const heap = std.heap;
const math = std.math;
const mem = std.mem;
const unicode = std.unicode;

pub fn main() !void {
    const allocator = heap.c_allocator;

    if (c.glfwInit() == 0)
        return error.InitFailed;

    const win = c.glfwCreateWindow(800, 600, "yo", null, null) orelse
        return error.CouldNotCreateWindow;
    _ = c.glfwMakeContextCurrent(win);
    _ = c.glfwSetScrollCallback(win, scrollCallback);
    _ = c.glfwSetCharCallback(win, charCallback);

    var width: c_int = undefined;
    var height: c_int = undefined;
    c.glfwGetWindowSize(win, &width, &height);

    var atlas = nk.atlas.init(&allocator);
    defer nk.atlas.clear(&atlas);

    nk.atlas.begin(&atlas);
    const baked = try nk.atlas.bake(&atlas, .rgba32);
    const font_tex = uploadAtlas(baked.data, baked.w, baked.h);
    var _null: nk.DrawNullTexture = undefined;
    nk.atlas.end(
        &atlas,
        nk.rest.nkHandleId(@intCast(c_int, font_tex)),
        &_null,
    );

    var ctx = nk.init(&allocator, &atlas.default_font.*.handle);
    defer nk.free(&ctx);

    ctx.clip.copy = undefined;
    ctx.clip.paste = undefined;
    ctx.clip.userdata = undefined;

    var program = Program{
        .ctx = ctx,
        .null_texture = _null,
        .cmds = nk.Buffer.init(&allocator, mem.page_size),
        .vbuf = nk.Buffer.init(&allocator, mem.page_size),
        .ebuf = nk.Buffer.init(&allocator, mem.page_size),

        .win = win,
    };
    defer {
        program.cmds.free();
        program.vbuf.free();
        program.ebuf.free();
    }

    c.glfwSetWindowUserPointer(win, @ptrCast(*anyopaque, &program));

    while (c.glfwWindowShouldClose(program.win) == 0) {
        program.input();
        examples.showcase(&program.ctx);
        program.render();
    }
}

const Program = @This();

ctx: nk.Context,
null_texture: nk.DrawNullTexture,
cmds: nk.Buffer,
vbuf: nk.Buffer,
ebuf: nk.Buffer,

win: *c.GLFWwindow,

fn input(program: *Program) void {
    const ctx = &program.ctx;
    const win = program.win;

    nk.input.begin(ctx);
    c.glfwPollEvents();

    if (ctx.input.mouse.grab != 0) {
        c.glfwSetInputMode(win, c.GLFW_CURSOR, c.GLFW_CURSOR_HIDDEN);
    } else if (ctx.input.mouse.ungrab != 0) {
        c.glfwSetInputMode(win, c.GLFW_CURSOR, c.GLFW_CURSOR_NORMAL);
    }

    nk.input.key(ctx, .del, c.glfwGetKey(win, c.GLFW_KEY_DELETE) == c.GLFW_PRESS);
    nk.input.key(ctx, .enter, c.glfwGetKey(win, c.GLFW_KEY_ENTER) == c.GLFW_PRESS);
    nk.input.key(ctx, .tab, c.glfwGetKey(win, c.GLFW_KEY_TAB) == c.GLFW_PRESS);
    nk.input.key(ctx, .backspace, c.glfwGetKey(win, c.GLFW_KEY_BACKSPACE) == c.GLFW_PRESS);
    nk.input.key(ctx, .up, c.glfwGetKey(win, c.GLFW_KEY_UP) == c.GLFW_PRESS);
    nk.input.key(ctx, .down, c.glfwGetKey(win, c.GLFW_KEY_DOWN) == c.GLFW_PRESS);
    nk.input.key(ctx, .text_start, c.glfwGetKey(win, c.GLFW_KEY_HOME) == c.GLFW_PRESS);
    nk.input.key(ctx, .text_end, c.glfwGetKey(win, c.GLFW_KEY_END) == c.GLFW_PRESS);
    nk.input.key(ctx, .scroll_start, c.glfwGetKey(win, c.GLFW_KEY_HOME) == c.GLFW_PRESS);
    nk.input.key(ctx, .scroll_end, c.glfwGetKey(win, c.GLFW_KEY_END) == c.GLFW_PRESS);
    nk.input.key(ctx, .scroll_down, c.glfwGetKey(win, c.GLFW_KEY_PAGE_DOWN) == c.GLFW_PRESS);
    nk.input.key(ctx, .scroll_up, c.glfwGetKey(win, c.GLFW_KEY_PAGE_UP) == c.GLFW_PRESS);
    nk.input.key(ctx, .shift, c.glfwGetKey(win, c.GLFW_KEY_LEFT_SHIFT) == c.GLFW_PRESS or
        c.glfwGetKey(win, c.GLFW_KEY_RIGHT_SHIFT) == c.GLFW_PRESS);

    if (c.glfwGetKey(win, c.GLFW_KEY_LEFT_CONTROL) == c.GLFW_PRESS or
        c.glfwGetKey(win, c.GLFW_KEY_RIGHT_CONTROL) == c.GLFW_PRESS)
    {
        nk.input.key(ctx, .copy, c.glfwGetKey(win, c.GLFW_KEY_C) == c.GLFW_PRESS);
        nk.input.key(ctx, .paste, c.glfwGetKey(win, c.GLFW_KEY_V) == c.GLFW_PRESS);
        nk.input.key(ctx, .cut, c.glfwGetKey(win, c.GLFW_KEY_X) == c.GLFW_PRESS);
        nk.input.key(ctx, .text_undo, c.glfwGetKey(win, c.GLFW_KEY_Z) == c.GLFW_PRESS);
        nk.input.key(ctx, .text_redo, c.glfwGetKey(win, c.GLFW_KEY_R) == c.GLFW_PRESS);
        nk.input.key(ctx, .text_word_left, c.glfwGetKey(win, c.GLFW_KEY_LEFT) == c.GLFW_PRESS);
        nk.input.key(ctx, .text_word_right, c.glfwGetKey(win, c.GLFW_KEY_RIGHT) == c.GLFW_PRESS);
        nk.input.key(ctx, .text_line_start, c.glfwGetKey(win, c.GLFW_KEY_B) == c.GLFW_PRESS);
        nk.input.key(ctx, .text_line_end, c.glfwGetKey(win, c.GLFW_KEY_E) == c.GLFW_PRESS);
    } else {
        nk.input.key(ctx, .left, c.glfwGetKey(win, c.GLFW_KEY_LEFT) == c.GLFW_PRESS);
        nk.input.key(ctx, .right, c.glfwGetKey(win, c.GLFW_KEY_RIGHT) == c.GLFW_PRESS);
        nk.input.key(ctx, .copy, false);
        nk.input.key(ctx, .paste, false);
        nk.input.key(ctx, .cut, false);
        nk.input.key(ctx, .shift, false);
    }

    var fx: f64 = undefined;
    var fy: f64 = undefined;
    c.glfwGetCursorPos(win, &fx, &fy);

    const x = @floatToInt(c_int, fx);
    const y = @floatToInt(c_int, fy);
    nk.input.motion(ctx, x, y);

    if (ctx.input.mouse.grabbed != 0) {
        c.glfwSetCursorPos(win, ctx.input.mouse.prev.x, ctx.input.mouse.prev.y);
        ctx.input.mouse.pos.x = ctx.input.mouse.prev.x;
        ctx.input.mouse.pos.y = ctx.input.mouse.prev.y;
    }

    nk.input.button(ctx, .left, x, y, c.glfwGetMouseButton(win, c.GLFW_MOUSE_BUTTON_LEFT) == c.GLFW_PRESS);
    nk.input.button(ctx, .middle, x, y, c.glfwGetMouseButton(win, c.GLFW_MOUSE_BUTTON_MIDDLE) == c.GLFW_PRESS);
    nk.input.button(ctx, .right, x, y, c.glfwGetMouseButton(win, c.GLFW_MOUSE_BUTTON_RIGHT) == c.GLFW_PRESS);
    nk.input.end(ctx);
}

const GlfwVertex = extern struct {
    position: [2]f32,
    uv: [2]f32,
    col: [4]u8,
};

fn render(program: *Program) void {
    const ctx = &program.ctx;
    const win = program.win;
    const cmds = &program.cmds;
    const ebuf = &program.ebuf;
    const vbuf = &program.vbuf;

    var width: c_int = undefined;
    var height: c_int = undefined;
    var display_width: c_int = undefined;
    var display_height: c_int = undefined;
    c.glfwGetWindowSize(win, &width, &height);
    c.glfwGetFramebufferSize(win, &display_width, &display_height);

    const fb_scale_x = @intToFloat(f32, display_width) / @intToFloat(f32, width);
    const fb_scale_y = @intToFloat(f32, display_height) / @intToFloat(f32, height);

    c.glViewport(0, 0, width, height);
    c.glClear(c.GL_COLOR_BUFFER_BIT);
    c.glClearColor(255, 255, 255, 0);

    c.glPushAttrib(c.GL_ENABLE_BIT | c.GL_COLOR_BUFFER_BIT | c.GL_TRANSFORM_BIT);
    c.glDisable(c.GL_CULL_FACE);
    c.glDisable(c.GL_DEPTH_TEST);
    c.glEnable(c.GL_SCISSOR_TEST);
    c.glEnable(c.GL_BLEND);
    c.glEnable(c.GL_TEXTURE_2D);
    c.glBlendFunc(c.GL_SRC_ALPHA, c.GL_ONE_MINUS_SRC_ALPHA);

    c.glViewport(0, 0, display_width, display_height);
    c.glMatrixMode(c.GL_PROJECTION);
    c.glPushMatrix();
    c.glLoadIdentity();
    c.glOrtho(0.0, @intToFloat(f64, width), @intToFloat(f64, height), 0.0, -1.0, 1.0);
    c.glMatrixMode(c.GL_MODELVIEW);
    c.glPushMatrix();
    c.glLoadIdentity();

    c.glEnableClientState(c.GL_VERTEX_ARRAY);
    c.glEnableClientState(c.GL_TEXTURE_COORD_ARRAY);
    c.glEnableClientState(c.GL_COLOR_ARRAY);
    {
        const vs = @sizeOf(GlfwVertex);
        const vp = @offsetOf(GlfwVertex, "position");
        const vt = @offsetOf(GlfwVertex, "uv");
        const vc = @offsetOf(GlfwVertex, "col");

        const vertex_layout = [_]nk.DrawVertexLayoutElement{
            .{ .attribute = nk.c.NK_VERTEX_POSITION, .format = nk.c.NK_FORMAT_FLOAT, .offset = vp },
            .{ .attribute = nk.c.NK_VERTEX_TEXCOORD, .format = nk.c.NK_FORMAT_FLOAT, .offset = vt },
            .{ .attribute = nk.c.NK_VERTEX_COLOR, .format = nk.c.NK_FORMAT_R8G8B8A8, .offset = vc },
            .{ .attribute = nk.c.NK_VERTEX_ATTRIBUTE_COUNT, .format = nk.c.NK_FORMAT_COUNT, .offset = 0 },
        };

        cmds.clear();
        vbuf.clear();
        ebuf.clear();
        _ = nk.vertex.convert(ctx, cmds, vbuf, ebuf, .{
            .vertex_layout = &vertex_layout,
            .vertex_size = @sizeOf(GlfwVertex),
            .vertex_alignment = @alignOf(GlfwVertex),
            .null_ = program.null_texture,
            .circle_segment_count = 22,
            .curve_segment_count = 22,
            .arc_segment_count = 22,
            .global_alpha = 1.0,
            .shape_AA = nk.c.NK_ANTI_ALIASING_ON,
            .line_AA = nk.c.NK_ANTI_ALIASING_ON,
        });

        const vertices = vbuf.memory();
        c.glVertexPointer(2, c.GL_FLOAT, vs, @ptrCast(*const anyopaque, @ptrCast([*]const u8, vertices) + vp));
        c.glTexCoordPointer(2, c.GL_FLOAT, vs, @ptrCast(*const anyopaque, @ptrCast([*]const u8, vertices) + vt));
        c.glColorPointer(4, c.GL_UNSIGNED_BYTE, vs, @ptrCast(*const anyopaque, @ptrCast([*]const u8, vertices) + vc));

        var offset = @ptrCast(
            [*]const nk.DrawIndex,
            @alignCast(@alignOf(nk.DrawIndex), ebuf.memory()),
        );

        var it = nk.vertex.iterator(ctx, cmds);
        while (it.next()) |cmd| {
            if (cmd.elem_count == 0) continue;

            c.glBindTexture(c.GL_TEXTURE_2D, @intCast(c.GLuint, cmd.texture.id));
            c.glScissor(
                @floatToInt(c.GLint, cmd.clip_rect.x * fb_scale_x),
                @floatToInt(c.GLint, @intToFloat(
                    f32,
                    height - @floatToInt(c.GLint, cmd.clip_rect.y + cmd.clip_rect.h),
                ) * fb_scale_y),
                @floatToInt(c.GLint, cmd.clip_rect.w * fb_scale_x),
                @floatToInt(c.GLint, cmd.clip_rect.h * fb_scale_y),
            );
            c.glDrawElements(c.GL_TRIANGLES, @intCast(c.GLsizei, cmd.elem_count), c.GL_UNSIGNED_SHORT, offset);
            offset += cmd.elem_count;
        }
        nk.clear(ctx);
    }

    c.glDisableClientState(c.GL_VERTEX_ARRAY);
    c.glDisableClientState(c.GL_TEXTURE_COORD_ARRAY);
    c.glDisableClientState(c.GL_COLOR_ARRAY);

    c.glDisable(c.GL_CULL_FACE);
    c.glDisable(c.GL_DEPTH_TEST);
    c.glDisable(c.GL_SCISSOR_TEST);
    c.glDisable(c.GL_BLEND);
    c.glDisable(c.GL_TEXTURE_2D);

    c.glBindTexture(c.GL_TEXTURE_2D, 0);
    c.glMatrixMode(c.GL_MODELVIEW);
    c.glPopMatrix();
    c.glMatrixMode(c.GL_PROJECTION);
    c.glPopMatrix();
    c.glPopAttrib();

    c.glfwSwapBuffers(win);
}

fn uploadAtlas(data: [*]const u8, w: usize, h: usize) c.GLuint {
    var font_tex: c.GLuint = undefined;
    c.glGenTextures(1, &font_tex);
    c.glBindTexture(c.GL_TEXTURE_2D, font_tex);
    c.glTexParameteri(c.GL_TEXTURE_2D, c.GL_TEXTURE_MIN_FILTER, c.GL_LINEAR);
    c.glTexParameteri(c.GL_TEXTURE_2D, c.GL_TEXTURE_MAG_FILTER, c.GL_LINEAR);
    c.glTexImage2D(
        c.GL_TEXTURE_2D,
        0,
        c.GL_RGBA,
        @intCast(c_int, w),
        @intCast(c_int, h),
        0,
        c.GL_RGBA,
        c.GL_UNSIGNED_BYTE,
        data,
    );

    return font_tex;
}

fn scrollCallback(win: ?*c.GLFWwindow, xoffset: f64, yoffset: f64) callconv(.C) void {
    const usrptr = c.glfwGetWindowUserPointer(win);
    const program = @ptrCast(*Program, @alignCast(@alignOf(Program), usrptr));

    var new_scroll = program.ctx.input.mouse.scroll_delta;
    new_scroll.x += @floatCast(f32, xoffset);
    new_scroll.y += @floatCast(f32, yoffset);
    nk.input.scroll(&program.ctx, new_scroll);
}

fn charCallback(win: ?*c.GLFWwindow, codepoint: c_uint) callconv(.C) void {
    const usrptr = c.glfwGetWindowUserPointer(win);
    const program = @ptrCast(*Program, @alignCast(@alignOf(Program), usrptr));
    nk.input.unicode(&program.ctx, @intCast(u21, codepoint));
}
