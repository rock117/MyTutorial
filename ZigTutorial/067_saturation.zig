// 067_saturation.zig - 饱和运算
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const max_u8: u8 = 255;
    const overflow: u8 = max_u8 +| 1;  // 饱和加法

    try stdout.print("Max u8: {d}\n", .{max_u8});
    try stdout.print("Saturated overflow: {d}\n", .{overflow});
}
