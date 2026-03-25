// 087_performance_testing.zig - 性能测试
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Performance Testing ===\n\n", .{});

    var timer = try std.time.Timer.start();

    var sum: i32 = 0;
    timer.reset();
    var i: i32 = 0;
    while (i < 1000000) : (i += 1) {
        sum += i;
    }
    const elapsed = timer.read();

    try stdout.print("Loop took: {d} ns\n", .{elapsed});
    try stdout.print("Result: {d}\n", .{sum});
}
