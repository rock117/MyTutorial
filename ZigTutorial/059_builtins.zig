// 059_builtins.zig - 内置函数介绍
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // 常用内置函数
    try stdout.print("=== Built-in Functions Demo ===\n", .{});

    const value: i32 = 42;
    try stdout.print("@typeName: {s}\n", .{@typeName(@TypeOf(value))});
    try stdout.print("@sizeOf: {d}\n", .{@sizeOf(i32)});
    try stdout.print("@alignOf: {d}\n", .{@alignOf(i32)});
}
