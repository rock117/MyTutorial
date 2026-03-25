// 078_filesystem.zig - 文件系统操作
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Filesystem Demo ===\n", .{});

    // 列出当前目录文件
    var iter = std.fs.cwd().iterate();

    try stdout.print("Files in current directory:\n", .{});
    while (try iter.next()) |entry| {
        try stdout.print("  {s}\n", .{entry.name});
    }
}
