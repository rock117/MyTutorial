// 037_type_info.zig - 类型信息与反射
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // 获取类型信息
    const T = i32;
    try stdout.print("Type: {s}\n", .{@typeName(T)});
    try stdout.print("Size: {d} bytes\n", .{@sizeOf(T)});
    try stdout.print("Alignment: {d} bytes\n", .{@alignOf(T)});
}
