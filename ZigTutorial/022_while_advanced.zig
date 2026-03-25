// 022_while_advanced.zig - while 循环进阶
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // while with else
    try stdout.print("while-else example:\n", .{});
    var i: i32 = 0;
    while (i < 5) : (i += 1) {
        try stdout.print("  i = {d}\n", .{i});
    } else {
        try stdout.print("  Loop completed normally\n", .{});
    }
}
