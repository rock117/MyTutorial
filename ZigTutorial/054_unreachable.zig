// 054_unreachable.zig - unreachable 断言
const std = @import("std");

fn getNumber(index: i32) i32 {
    return switch (index) {
        0 => 10,
        1 => 20,
        2 => 30,
        else => unreachable,
    };
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const result = getNumber(1);
    try stdout.print("Result: {d}\n", .{result});
}
