// 024_functions_more.zig - 函数更多特性
const std = @import("std");

// 内联函数
inline fn square(x: i32) i32 {
    return x * x;
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("Inline function:\n", .{});
    try stdout.print("  square(5) = {d}\n", .{square(5)});
}
