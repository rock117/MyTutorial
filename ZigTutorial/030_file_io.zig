// 030_file_io.zig - 文件读写基础
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const file_path = "test_output.txt";

    // 写入文件
    {
        const file = try std.fs.cwd().createFile(file_path, .{});
        defer file.close();

        try file.writeAll("Hello from Zig!\n");
        try file.writeAll("This is a test file.\n");
    }

    try stdout.print("File written: {s}\n", .{file_path});

    // 读取文件
    {
        const file = try std.fs.cwd().openFile(file_path, .{});
        defer file.close();

        const content = try file.readToEndAlloc(std.heap.page_allocator, 1024);
        defer std.heap.page_allocator.free(content);

        try stdout.print("File content:\n{s}\n", .{content});
    }
}
