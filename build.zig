const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});

    const lib = b.addStaticLibrary("zig-nuklear", null);
    lib.addCSourceFile("src/c/nuklear.c", &.{
        "-ggdb",
    });
    lib.setBuildMode(mode);
    lib.setTarget(target);
    lib.install();

    const test_step = b.step("test", "Run library tests");
    const tests = b.addTest("nuklear.zig");
    tests.addIncludeDir("src/c");
    tests.linkLibrary(lib);
    tests.setBuildMode(mode);
    tests.setTarget(target);
    test_step.dependOn(&tests.step);
}
