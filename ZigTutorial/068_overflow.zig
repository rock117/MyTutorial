// 068_overflow.zig - 溢出操作
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const a: u8 = 200;
    const b: u8 = 100;

    // 溢出加法（带回绕）
    const result = a +% b;

    try stdout.print("Overflow addition:\n", .{});
    try stdout.print("  {d} + {d} = {d}\n", .{a, b, result});
}
