// 070_coroutines.zig - 协程基础
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Coroutines Demo ===\n", .{});
    try stdout.print("Note: Coroutines are experimental in Zig\n", .{});
}
