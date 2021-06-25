const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();

    const lib = b.addStaticLibrary("zig-nuklear", null);
    lib.addCSourceFile("src/c/nuklear.c", &.{
        "-ggdb",
    });
    lib.setBuildMode(mode);
    lib.install();

    var tests = b.addTest("src/nuklear.zig");
    tests.addIncludeDir("src/c");
    tests.linkLibrary(lib);
    tests.setBuildMode(mode);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&tests.step);
}
