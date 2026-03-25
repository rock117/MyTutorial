// 048_anonymous_struct.zig - 匿名结构体
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // 匿名结构体字面量
    const point = struct { x: f64, y: f64 }{
        .x = 10.0,
        .y = 20.0,
    };

    try stdout.print("Point: x={d:.1}, y={d:.1}\n", .{point.x, point.y});

    // 匿名结构体类型推断
    const data = .{
        .name = "Test",
        .value = 42,
    };

    try stdout.print("Data: name={s}, value={d}\n", .{data.name, data.value});
}
