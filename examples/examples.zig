const nk = @import("nuklear");
const std = @import("std");

const math = std.math;

pub fn showcase(ctx: *nk.Context) void {
    const Static = struct {
        var progress: u8 = 0;
        var checkbox_label: bool = false;
        var checkbox_flags_label: usize = 0;
        var check_label: bool = false;
        var check_flags_label: usize = 0;
        var color_picker_picked: nk.Colorf = .{ .r = 0, .g = 0, .b = 0, .a = 0, ._pad = 0 };
        var color_pick_picked: nk.Colorf = .{ .r = 0, .g = 0, .b = 0, .a = 0, ._pad = 0 };
    };

    if (nk.window.begin(ctx, &nk.id(opaque {}), nk.rect(100, 100, 500, 500), .{
        .title = "showcase",
        .border = true,
        .moveable = true,
        .closable = true,
        .minimizable = true,
        .background = false,
        .scalable = true,
    })) |_| {
        nk.layout.rowDynamic(ctx, 70, 1);
        if (nk.group.begin(ctx, &nk.id(opaque {}), .{
            .title = "nk.bar",
            .border = true,
            .scrollbar = false,
        })) {
            defer nk.group.end(ctx);

            nk.layout.rowDynamic(ctx, 0, 1);
            Static.progress = @intCast(u8, nk.bar.prog(
                ctx,
                Static.progress,
                math.maxInt(u8),
                true,
            ));
            Static.progress +%= 1;
        }

        nk.layout.rowDynamic(ctx, 360, 2);
        if (nk.group.begin(ctx, &nk.id(opaque {}), .{
            .title = "nk.button",
            .border = true,
            .scrollbar = false,
        })) {
            defer nk.group.end(ctx);

            nk.layout.rowDynamic(ctx, 0, 1);
            if (nk.button.label(ctx, "label"))
                std.log.info("nk.button.label", .{});

            nk.layout.rowDynamic(ctx, 0, 3);
            if (nk.button.color(ctx, nk.rgb(180, 30, 30)))
                std.log.info("nk.button.color: red", .{});
            if (nk.button.color(ctx, nk.rgb(30, 180, 30)))
                std.log.info("nk.button.color: green", .{});
            if (nk.button.color(ctx, nk.rgb(30, 30, 180)))
                std.log.info("nk.button.color: blue", .{});

            if (nk.button.symbol(ctx, .circle_solid))
                std.log.info("nk.button.symbol: circle", .{});
            if (nk.button.symbol(ctx, .rect_solid))
                std.log.info("nk.button.symbol: rect", .{});
            if (nk.button.symbol(ctx, .triangle_up))
                std.log.info("nk.button.symbol: triangle", .{});

            // if (nk.button.image(ctx, undefined))
            //     std.log.info("nk.button.image", .{});

            nk.layout.rowDynamic(ctx, 0, 1);
            if (nk.button.symbolLabel(ctx, .rect_solid, "symbolLabel", .left))
                std.log.info("nk.button.symbolLabel", .{});

            var style = ctx.style.button;
            style.normal.type = .NK_STYLE_ITEM_COLOR;
            style.normal.data.color = nk.rgb(20, 20, 20);
            if (nk.button.symbolStyled(ctx, .rect_solid, style))
                std.log.info("nk.button.symbolStyled", .{});

            // if (nk.button.imageStyled(ctx, undefined, style))
            //     std.log.info("nk.button.imageStyled", .{});
            //

            if (nk.button.symbolLabelStyled(
                ctx,
                .rect_solid,
                "symbolLabelStyled",
                .right,
                style,
            )) {
                std.log.info("nk.button.symbolLabelStyled", .{});
            }

            // if (nk.button.imageLabelStyled(
            //     ctx,
            //     undefined,
            //     "imageLabelStyled",
            //     .right,
            //     style,
            // )) {
            //     std.log.info("nk.button.symbolLabelStyled", .{});
            // }
        }

        if (nk.group.begin(ctx, &nk.id(opaque {}), .{
            .title = "nk.chart",
            .border = true,
            .scrollbar = false,
        })) {
            defer nk.group.end(ctx);

            const points = 10;

            nk.layout.rowDynamic(ctx, 100, 1);
            if (nk.chart.begin(ctx, .lines, points, 0, points - 1)) {
                defer nk.chart.end(ctx);

                var i: u8 = 0;
                while (i < points) : (i += 1) {
                    if (nk.chart.push(ctx, @intToFloat(f32, i)) == .clicked)
                        std.log.info("nk.chart.begin: {}", .{i});
                }
            }

            nk.chart.plot(ctx, .column, &[_]f32{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 });
            nk.chart.function(ctx, .lines, 100, 0, {}, struct {
                fn func(_: void, index: usize) f32 {
                    return math.sqrt(@intToFloat(f32, index));
                }
            }.func);
        }

        nk.layout.rowDynamic(ctx, 130, 2);
        if (nk.group.begin(ctx, &nk.id(opaque {}), .{
            .title = "nk.checkbox",
            .border = true,
            .scrollbar = false,
        })) {
            defer nk.group.end(ctx);

            nk.layout.rowDynamic(ctx, 0, 1);
            if (nk.checkbox.label(ctx, "label", &Static.checkbox_label))
                std.log.info("nk.checkbox.label", .{});

            if (nk.checkbox.flagsLabel(
                ctx,
                "flagsLabel",
                &Static.checkbox_flags_label,
                0b01,
            )) {
                std.log.info("nk.checkbox.flagsLabel", .{});
            }

            if (nk.checkbox.flagsLabel(
                ctx,
                "flagsLabel",
                &Static.checkbox_flags_label,
                0b10,
            )) {
                std.log.info("nk.checkbox.flagsLabel", .{});
            }
        }

        if (nk.group.begin(ctx, &nk.id(opaque {}), .{
            .title = "nk.check",
            .border = true,
            .scrollbar = false,
        })) {
            defer nk.group.end(ctx);

            nk.layout.rowDynamic(ctx, 0, 1);
            Static.check_label = nk.check.label(ctx, "label", Static.check_label);
            Static.check_flags_label = nk.check.flagsLabel(
                ctx,
                "flagsLabel",
                Static.check_flags_label,
                0b01,
            );
            Static.check_flags_label = nk.check.flagsLabel(
                ctx,
                "flagsLabel",
                Static.check_flags_label,
                0b10,
            );
        }

        nk.layout.rowDynamic(ctx, 200, 1);
        if (nk.group.begin(ctx, &nk.id(opaque {}), .{
            .title = "nk.color",
            .border = true,
            .scrollbar = false,
        })) {
            defer nk.group.end(ctx);

            nk.layout.rowDynamic(ctx, 150, 2);
            Static.color_picker_picked = nk.color.picker(ctx, Static.color_picker_picked, .rgb);
            if (nk.color.pick(ctx, &Static.color_pick_picked, .rgba))
                std.log.info("nk.color.pick: r={d:.2} g={d:.2} b={d:.2} a={d:.2}", .{
                    Static.color_pick_picked.r,
                    Static.color_pick_picked.g,
                    Static.color_pick_picked.b,
                    Static.color_pick_picked.a,
                });
        }

        // if (nk.group.begin(ctx, &nk.id(opaque {}), .{
        //     .title = "nk.combo",
        //     .border = true,
        //     .scrollbar = false,
        // })) {
        //     defer nk.group.end(ctx);

        //     nk.layout.rowDynamic(ctx, 0, 2);
        //     _ = nk.combo.items(ctx, &.{
        //         nk.slice("abc"),
        //         nk.slice("def"),
        //     }, 0, 0, nk.vec2(0, 0));
        // }
    }
    nk.window.end(ctx);
}
