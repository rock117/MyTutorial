// 088_arg_parsing.zig - 命令行参数解析
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const args = try std.process.argsAlloc(std.heap.page_allocator);
    defer std.process.argsFree(std.heap.page_allocator, args);

    try stdout.print("Program: {s}\n", .{args[0]});

    if (args.len > 1) {
        try stdout.print("Arguments:\n", .{});
        for (args[1..]) |arg| {
            try stdout.print("  {s}\n", .{arg});
        }
    }
}
