// 055_defer_advanced.zig - defer 高级用法
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Advanced defer Demo ===\n\n", .{});

    // defer 中的错误处理
    {
        defer {
            stdout.print("Cleanup block 1\n", .{}) catch {};
        }
        try stdout.print("Main block 1\n", .{});
    }

    try stdout.print("\n", .{});

    // 嵌套 defer
    {
        defer {
            stdout.print("Outer defer\n", .{}) catch {};
        }
        {
            defer {
                stdout.print("Inner defer\n", .{}) catch {};
            }
            try stdout.print("Main block\n", .{});
        }
    }
}
