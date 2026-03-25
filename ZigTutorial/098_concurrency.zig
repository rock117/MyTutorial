// 098_concurrency.zig - 并发编程基础
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Concurrency Demo ===\n\n", .{});

    try stdout.print("Zig supports threading through std.thread\n", .{});
    try stdout.print("Note: Threading is still maturing in Zig\n", .{});
}
