// 052_anyerror.zig - anyerror 错误集
const std = @import("std");

fn mightError() anyerror!i32 {
    return 42;
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const result = try mightError();
    try stdout.print("Result: {d}\n", .{result});
}
