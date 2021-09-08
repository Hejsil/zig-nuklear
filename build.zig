const std = @import("std");

const Builder = std.build.Builder;
const CrossTarget = std.build.CrossTarget;
const LibExeObjStep = std.build.LibExeObjStep;
const Pkg = std.build.Pkg;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});

    const nk = Nuklear.init(b);

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

lib: *LibExeObjStep,

pub fn init(b: *Builder) Nuklear {
    const lib = b.addStaticLibrary("zig-nuklear", null);
    lib.addCSourceFile(dir() ++ "/src/c/nuklear.c", &.{});
    return .{ .lib = lib };
}

pub const AddToOptions = struct {
    package_name: []const u8 = "nuklear",
};

pub fn addTo(nk: Nuklear, lib: *LibExeObjStep, opt: AddToOptions) void {
    lib.addIncludeDir(include_dir);
    lib.addPackagePath(opt.package_name, pkg_path);
    lib.linkLibrary(nk.lib);
    lib.step.dependOn(&nk.lib.step);
}

pub const pkg_path = dir() ++ "/nuklear.zig";

pub const include_dir = dir() ++ "/src/c";

fn dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}
