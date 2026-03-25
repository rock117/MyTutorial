// 038_type_conversion.zig - 类型转换
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // 显式类型转换
    const float_num: f64 = 3.14;
    const int_num: i32 = @intFromFloat(float_num);

    try stdout.print("Float: {d}, Int: {d}\n", .{float_num, int_num});

    // 整数到浮点
    const int_val: i32 = 42;
    const float_val: f64 = @floatFromInt(int_val);

    try stdout.print("Int: {d}, Float: {d}\n", .{int_val, float_val});
}
