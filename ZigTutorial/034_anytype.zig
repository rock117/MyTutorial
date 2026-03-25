// 034_anytype.zig - anytype 泛型
const std = @import("std");

fn printValue(value: anytype) !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Value: {any}\n", .{value});
}

pub fn main() !void {
    try printValue(@as(i32, 42));
    try printValue(@as(f64, 3.14));
    try printValue(@as([]const u8, "Hello"));
}
