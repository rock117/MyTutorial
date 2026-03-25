// 065_truncate.zig - @truncate 截断
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const big: i64 = 1234567890;
    const truncated: i32 = @truncate(big);

    try stdout.print("Original: {d}\n", .{big});
    try stdout.print("Truncated: {d}\n", .{truncated});
}
