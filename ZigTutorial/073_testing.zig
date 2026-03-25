// 073_testing.zig - 单元测试基础
const std = @import("std");

fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "add function test" {
    try std.testing.expectEqual(@as(i32, 5), add(2, 3));
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("Run tests with: zig test 073_testing.zig\n", .{});
}
