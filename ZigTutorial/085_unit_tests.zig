// 085_unit_tests.zig - 单元测试实践
const std = @import("std");

fn factorial(n: u32) u32 {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

test "factorial of 5" {
    try std.testing.expectEqual(@as(u32, 120), factorial(5));
}

test "factorial of 0" {
    try std.testing.expectEqual(@as(u32, 1), factorial(0));
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Run: zig test 085_unit_tests.zig\n", .{});
}
