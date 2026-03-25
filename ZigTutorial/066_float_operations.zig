// 066_float_operations.zig - 浮点操作
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const a: f64 = 1.5;
    const b: f64 = 2.5;

    try stdout.print("Float operations:\n", .{});
    try stdout.print("  {d} + {d} = {d}\n", .{a, b, a + b});
    try stdout.print("  {d} * {d} = {d}\n", .{a, b, a * b});
    try stdout.print("  sqrt({d}) = {d:.3}\n", .{a, std.math.sqrt(a)});
}
