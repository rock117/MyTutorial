// 035_comptime_advanced.zig - comptime 编译时编程
const std = @import("std");

fn createArray(comptime size: comptime_int) [size]i32 {
    var result: [size]i32 = undefined;
    var i: i32 = 0;
    while (i < size) : (i += 1) {
        result[i] = i * 2;
    }
    return result;
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const arr = comptime createArray(5);
    try stdout.print("Comptime array: {any}\n", .{arr});
}
