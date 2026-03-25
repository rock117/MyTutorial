// 049_tuples.zig - 元组 (Tuple)
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // 元组（实际上是匿名结构体）
    const tuple = .{ 42, "hello", true };

    try stdout.print("Tuple: {any}\n", .{tuple});
    try stdout.print("Field 0: {d}\n", .{tuple[0]});
    try stdout.print("Field 1: {s}\n", .{tuple[1]});
    try stdout.print("Field 2: {}\n", .{tuple[2]});

    // 迭代元组
    inline for (tuple) |field| {
        try stdout.print("Field: {any}\n", .{field});
    }
}
