// 097_compression.zig - 数据压缩
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Data Compression Demo ===\n\n", .{});

    try stdout.print("Zig supports compression through std.compress\n", .{});
    try stdout.print("Implementations include gzip, zlib, etc.\n", .{});
}
