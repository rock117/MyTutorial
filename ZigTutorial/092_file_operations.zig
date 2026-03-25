// 092_file_operations.zig - 文件操作进阶
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const filename = "demo.txt";

    // 写入文件
    {
        const file = try std.fs.cwd().createFile(filename, .{});
        defer file.close();

        try file.writeAll("Line 1\n");
        try file.writeAll("Line 2\n");
        try file.writeAll("Line 3\n");
    }

    // 读取所有行
    {
        const file = try std.fs.cwd().openFile(filename, .{});
        defer file.close();

        const content = try file.readToEndAlloc(std.heap.page_allocator, 1024);
        defer std.heap.page_allocator.free(content);

        try stdout.print("Content:\n{s}\n", .{content});
    }
}
