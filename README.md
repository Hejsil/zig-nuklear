# zig-nuklear

WIP bindings for [Nuklear](https://github.com/Immediate-Mode-UI/Nuklear).

## Goals

* Provide an API simular to Nuklear, but with improvements thrown in where it makes
  sense.
* Support using Nuklear with or without libc.
  * Provide default implementations for overridable Nuklear function in Zig if libc is
    unwanted.

## Usage

This is an example with no backend. See [`examples/main.zig`](examples/main.zig) for a full example
using `glfw` and `opengl`.

`build.zig`
```zig
const Nuklear = @import("zig-nuklear/build.zig");
const std = @import("std");

const Builder = std.build.Builder;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});

    const nk = Nuklear.init(b, .{});

    const exe = b.addExecutable("main", "main.zig");
    nk.addTo(exe, .{});

    // Link to your backend here!

    exe.setBuildMode(mode);
    exe.setTarget(target);
    exe.install();
}
```

`main.zig`
```zig
const nk = @import("nuklear");
const std = @import("std");

pub fn main() !void {
    const allocator = // Choose your allocator!
    const font = // Initialize your font!
    const ctx = &nk.init(allocator, font);
    defer nk.free(ctx);

    while (
        // Backend is running
    ) {
        nk.input.begin(ctx);

        // Forward events from backend to Nuklear here!

        nk.input.end(ctx);

        if (nk.window.begin(ctx, &nk.id(opaque {}), nk.rect(0, 0, 200, 200), .{
            .title = "hello world",
            .border = true,
            .moveable = true,
            .closable = true,
            .minimizable = true,
            .background = false,
            .scalable = true,
        })) |_| {
            nk.layout.rowDynamic(ctx, 0, 1);
            nk.text.label(ctx, "Hello world!", .mid_right);
            if (nk.button.label(ctx, "Hello world!"))
                std.log.info("Hello world!", .{});
        }
        nk.window.end(ctx);

        // Render gui out to your backend here!

        nk.clear(ctx);
    }
}
```

