// 046_struct_methods.zig - 结构体方法
const std = @import("std");

const Counter = struct {
    count: i32,

    fn init() Counter {
        return .{ .count = 0 };
    }

    fn increment(self: *Counter) void {
        self.count += 1;
    }

    fn get(self: *const Counter) i32 {
        return self.count;
    }
};

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    var counter = Counter.init();
    counter.increment();
    counter.increment();

    try stdout.print("Counter value: {d}\n", .{counter.get()});
}
