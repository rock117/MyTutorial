// 075_benchmarking.zig - 性能测试
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Benchmarking Demo ===\n", .{});
    try stdout.print("Use std.time to measure performance\n", .{});
}
