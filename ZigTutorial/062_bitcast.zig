// 062_bitcast.zig - @bitCast 位转换
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const float_val: f32 = 3.14;
    const int_val: u32 = @bitCast(float_val);

    try stdout.print("Float: {d}, as bits: 0x{X:0>8}\n", .{float_val, int_val});
}
