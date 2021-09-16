const std = @import("std");

const Builder = std.build.Builder;
const CrossTarget = std.build.CrossTarget;
const LibExeObjStep = std.build.LibExeObjStep;
const Pkg = std.build.Pkg;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});

    const nk = Nuklear.init(b, .{
        .include_default_font = true,
        .include_font_backing = true,
        .include_vertex_buffer_output = true,
        .zero_command_memory = true,
        .keystate_based_input = true,
    });

    const test_step = b.step("test", "Run library tests");
    const tests = b.addTest("nuklear.zig");
    test_step.dependOn(&tests.step);
    nk.addTo(tests, .{});

    const examples_step = b.step("examples", "");
    const examples = b.addExecutable("examples", "examples/main.zig");
    examples_step.dependOn(&examples.step);
    nk.addTo(examples, .{});

    examples.linkSystemLibrary("c");
    examples.linkSystemLibrary("GL");
    examples.linkSystemLibrary("glfw");
    examples.linkSystemLibrary("GLU");
    examples.install();

    for ([_]*LibExeObjStep{ tests, examples, nk.lib }) |obj| {
        obj.setBuildMode(mode);
        obj.setTarget(target);
    }
}

const Nuklear = @This();

options: Options,
lib: *LibExeObjStep,

pub const Options = struct {
    include_fixed_types: bool = false,
    include_default_allocator: bool = false,
    include_stdio: bool = false,
    include_std_varargs: bool = false,
    include_vertex_buffer_output: bool = false,
    include_font_backing: bool = false,
    include_default_font: bool = false,
    include_command_userdata: bool = false,
    button_trigger_on_release: bool = false,
    zero_command_memory: bool = false,
    uint_draw_index: bool = false,
    keystate_based_input: bool = false,
    buffer_default_initial_size: ?usize = null,
    max_number_buffer: ?usize = null,
    input_max: ?usize = null,

    fn defineMacros(opts: Options, lib: *LibExeObjStep) void {
        const b = lib.builder;
        if (opts.include_fixed_types)
            lib.defineCMacro("NK_INCLUDE_FIXED_TYPES");
        if (opts.include_default_allocator)
            lib.defineCMacro("NK_INCLUDE_DEFAULT_ALLOCATOR");
        if (opts.include_stdio)
            lib.defineCMacro("NK_INCLUDE_STANDARD_IO");
        if (opts.include_std_varargs)
            lib.defineCMacro("NK_INCLUDE_STANDARD_VARARGS");
        if (opts.include_vertex_buffer_output)
            lib.defineCMacro("NK_INCLUDE_VERTEX_BUFFER_OUTPUT");
        if (opts.include_font_backing)
            lib.defineCMacro("NK_INCLUDE_FONT_BAKING");
        if (opts.include_default_font)
            lib.defineCMacro("NK_INCLUDE_DEFAULT_FONT");
        if (opts.include_command_userdata)
            lib.defineCMacro("NK_INCLUDE_COMMAND_USERDATA");
        if (opts.button_trigger_on_release)
            lib.defineCMacro("NK_BUTTON_TRIGGER_ON_RELEASE");
        if (opts.zero_command_memory)
            lib.defineCMacro("NK_ZERO_COMMAND_MEMORY");
        if (opts.uint_draw_index)
            lib.defineCMacro("NK_UINT_DRAW_INDEX");
        if (opts.keystate_based_input)
            lib.defineCMacro("NK_KEYSTATE_BASED_INPUT");
        if (opts.buffer_default_initial_size) |size|
            lib.defineCMacro(b.fmt("NK_BUFFER_DEFAULT_INITIAL_SIZE={}", .{size}));
        if (opts.max_number_buffer) |number|
            lib.defineCMacro(b.fmt("NK_MAX_NUMBER_BUFFER={}", .{number}));
        if (opts.input_max) |number|
            lib.defineCMacro(b.fmt("NK_INPUT_MAX={}", .{number}));
    }
};

pub fn init(b: *Builder, opts: Options) Nuklear {
    const lib = b.addStaticLibrary("zig-nuklear", null);
    lib.addCSourceFile(dir() ++ "/src/c/nuklear.c", &.{});
    opts.defineMacros(lib);
    return .{ .lib = lib, .options = opts };
}

pub const AddToOptions = struct {
    package_name: []const u8 = "nuklear",
};

pub fn addTo(nk: Nuklear, lib: *LibExeObjStep, opt: AddToOptions) void {
    lib.addIncludeDir(include_dir);
    lib.addPackagePath(opt.package_name, pkg_path);
    lib.linkLibrary(nk.lib);
    nk.options.defineMacros(lib);
    lib.step.dependOn(&nk.lib.step);
}

pub const pkg_path = dir() ++ "/nuklear.zig";

pub const include_dir = dir() ++ "/src/c";

fn dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}
