// 019_enums.zig - 枚举类型
const std = @import("std");

const Day = enum(u8) {
    Sunday = 0,
    Monday = 1,
    Tuesday = 2,
    Wednesday = 3,
    Thursday = 4,
    Friday = 5,
    Saturday = 6,
};

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Enums Demo ===\n\n", .{});

    const today = Day.Wednesday;
    try stdout.print("Today: {}\n", .{@intFromEnum(today)});

    const is_weekend = switch (today) {
        Day.Sunday, Day.Saturday => true,
        else => false,
    };

    try stdout.print("Is weekend: {}\n", .{is_weekend});
}
