// 036_inline_loop.zig - inline 循环展开
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // inline for 在编译时展开
    const values = [_]i32{ 1, 2, 3 };

    inline for (values) |v| {
        const squared = v * v;
        try stdout.print("Square of {d} = {d}\n", .{v, squared});
    }
}
