// 050_usingnamespace.zig - usingnamespace 类型别名
const std = @import("std");

const Color = struct {
    r: u8,
    g: u8,
    b: u8,
};

fn rgb(r: u8, g: u8, b: u8) Color {
    return .{ .r = r, .g = g, .b = b };
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // 使用 usingnamespace 导入符号
    const Colors = struct {
        usingnamespace struct {
            pub const RED = Color{ .r = 255, .g = 0, .b = 0 };
            pub const GREEN = Color{ .r = 0, .g = 255, .b = 0 };
        };
    };

    try stdout.print("RED: r={d}, g={d}, b={d}\n", .{
        Colors.RED.r,
        Colors.RED.g,
        Colors.RED.b,
    });
}
