// 086_integration_tests.zig - 集成测试
const std = @import("std");

test "integration test example" {
    const allocator = std.heap.page_allocator;

    const list = try std.ArrayList(i32).initCapacity(allocator, 10);
    defer list.deinit();

    try list.append(1);
    try list.append(2);
    try list.append(3);

    try std.testing.expectEqual(@as(usize, 3), list.items.len);
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Integration test example\n", .{});
}
