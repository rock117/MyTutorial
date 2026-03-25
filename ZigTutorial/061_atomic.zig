// 061_atomic.zig - 原子操作
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const atomic_value: std.atomic.Value(i32) = std.atomic.Value(i32).init(0);
    _ = atomic_value;

    try stdout.print("=== Atomic Operations Demo ===\n", .{});
    try stdout.print("Atomic operations for thread-safe programming\n", .{});
}
