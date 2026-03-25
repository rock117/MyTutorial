// 064_intcast.zig - @intCast 整数转换
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const big: i64 = 1000;
    const small: i32 = @intCast(big);

    try stdout.print("i64: {d}, i32: {d}\n", .{big, small});
}
