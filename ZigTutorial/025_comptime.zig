// 025_comptime.zig - 编译时计算
const std = @import("std");

// 编译时函数
fn factorial(comptime n: i32) i32 {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const result = comptime factorial(5);
    try stdout.print("Factorial of 5 (comptime): {d}\n", .{result});
}
