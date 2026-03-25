// 023_for_advanced.zig - for 循环进阶
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // for with else
    try stdout.print("for-else example:\n", .{});
    for (0..5) |i| {
        try stdout.print("  {d}\n", .{i});
    } else {
        try stdout.print("  Loop completed\n", .{});
    }
}
