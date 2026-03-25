// 079_paths.zig - 路径处理
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const path = "/home/user/documents/file.txt";

    try stdout.print("Path operations:\n", .{});
    try stdout.print("  Basename: {s}\n", .{std.fs.path.basename(path)});
    if (std.fs.path.dirname(path)) |dir| {
        try stdout.print("  Dirname: {s}\n", .{dir});
    } else {
        try stdout.print("  Dirname: (none)\n", .{});
    }
}
