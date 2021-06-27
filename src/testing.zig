const nk = @import("../nuklear.zig");
const std = @import("std");

const heap = std.heap;
const testing = std.testing;

var test_default_atlas_buf: [1024 * 1024]u8 = undefined;
var test_default_atlas: nk.FontAtlas = undefined;
var test_default_font: ?*nk.UserFont = null;
fn testDefaultFont() !*nk.UserFont {
    if (test_default_font) |res|
        return res;

    var fba = heap.FixedBufferAllocator.init(&test_default_atlas_buf);
    test_default_atlas = nk.atlas.init(&fba.allocator);
    test_default_font = &(try nk.atlas.addDefault(&test_default_atlas, 13, null)).handle;
    _ = try nk.atlas.bake(&test_default_atlas, .NK_FONT_ATLAS_RGBA32);
    nk.atlas.end(&test_default_atlas, .{ .id = 0 }, null);
    return test_default_font.?;
}

pub fn init() !nk.Context {
    const font = try testDefaultFont();
    return nk.init(testing.allocator, font);
}
