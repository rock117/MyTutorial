// 020_unions.zig - 联合类型
const std = @import("std");

const Value = union {
    int: i32,
    float: f64,
};

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Unions Demo ===\n\n", .{});

    var val1: Value = .{ .int = 42 };
    try stdout.print("Int value: {}\n", .{val1.int});

    val1 = .{ .float = 3.14 };
    try stdout.print("Float value: {}\n", .{val1.float});
}
