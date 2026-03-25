// 053_errdefer.zig - errdefer 错误延迟执行
const std = @import("std");

fn processData(should_fail: bool) !void {
    const stdout = std.io.getStdOut().writer();
    errdefer {
        stdout.print("Error cleanup\n", .{}) catch {};
    }

    if (should_fail) {
        return error.ProcessFailed;
    }

    try stdout.print("Success\n", .{});
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("=== errdefer Demo ===\n\n", .{});

    _ = processData(false) catch |err| {
        try stdout.print("Error: {}\n", .{err});
    };

    _ = processData(true) catch |err| {
        try stdout.print("Error: {}\n", .{err});
    };
}
