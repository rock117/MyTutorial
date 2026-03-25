// 093_directory_ops.zig - 目录操作
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Directory Operations ===\n\n", .{});

    // 创建目录
    try std.fs.cwd().makePath("test_dir");
    try stdout.print("Created directory: test_dir\n", .{});

    // 删除目录
    try std.fs.cwd().deleteTree("test_dir");
    try stdout.print("Deleted directory: test_dir\n", .{});
}
