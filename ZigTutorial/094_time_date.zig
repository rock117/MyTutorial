// 094_time_date.zig - 时间与日期
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const timestamp = std.time.timestamp();

    try stdout.print("Current timestamp: {d}\n", .{timestamp});

    // 转换为本地时间（需要实现时区转换）
    try stdout.print("Unix timestamp: {d} seconds since epoch\n", .{timestamp});
}
