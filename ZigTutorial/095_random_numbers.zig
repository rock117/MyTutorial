// 095_random_numbers.zig - 随机数生成
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    var prng = std.rand.DefaultPrng.init(42);
    const rand = prng.random();

    try stdout.print("Random numbers:\n", .{});
    var i: i32 = 0;
    while (i < 5) : (i += 1) {
        const num = rand.intRangeAtMost(i32, 1, 100);
        try stdout.print("  {d}\n", .{num});
    }
}
