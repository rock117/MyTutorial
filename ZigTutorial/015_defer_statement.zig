// 015_defer_statement.zig - defer 延迟执行
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Defer Statement Demo ===\n\n", .{});

    // 基本 defer
    {
        defer {
            stdout.print("Deferred execution\n", .{}) catch {};
        }
        try stdout.print("Main code\n", .{});
    }

    try stdout.print("\n", .{});

    // 多个 defer (LIFO顺序)
    {
        defer {
            stdout.print("Third defer\n", .{}) catch {};
        }
        defer {
            stdout.print("Second defer\n", .{}) catch {};
        }
        defer {
            stdout.print("First defer\n", .{}) catch {};
        }
        try stdout.print("Main code\n", .{});
    }
}
