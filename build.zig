const std = @import("std");

const Pkg = std.build.Pkg;

const pkg = Pkg{
    .name = "nuklear",
    .path = "nuklear.zig",
};

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();

    const lib = b.addStaticLibrary("zig-nuklear", null);
    lib.addCSourceFile("src/c/nuklear.c", &.{
        "-ggdb",
    });
    lib.setBuildMode(mode);
    lib.install();

    const test_step = b.step("test", "Run library tests");
    const tests = b.addTest("nuklear.zig");
    tests.addIncludeDir("src/c");
    tests.linkLibrary(lib);
    tests.setBuildMode(mode);
    test_step.dependOn(&tests.step);
}
