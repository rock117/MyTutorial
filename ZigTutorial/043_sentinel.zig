// 043_sentinel.zig - Sentinel 终止符
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // 以 null 结尾的数组
    const null_terminated: [*:0]const u8 = "Hello";

    try stdout.print("Sentinel-terminated pointer:\n", .{});
    var i: usize = 0;
    while (null_terminated[i] != 0) : (i += 1) {
        try stdout.print("  [{d}] = {c}\n", .{i, null_terminated[i]});
    }
}
