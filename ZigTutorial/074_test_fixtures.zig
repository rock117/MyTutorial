// 074_test_fixtures.zig - 测试 fixtures
const std = @import("std");

const Counter = struct {
    count: i32,

    fn init() Counter {
        return .{ .count = 0 };
    }

    fn increment(self: *Counter) void {
        self.count += 1;
    }
};

test "Counter increment" {
    var counter = Counter.init();
    counter.increment();
    try std.testing.expectEqual(@as(i32, 1), counter.count);
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("Test fixtures example\n", .{});
}
