// 060_bit_operations.zig - 位操作
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const a: u8 = 0b10101010;
    const b: u8 = 0b11001100;

    try stdout.print("Bit operations:\n", .{});
    try stdout.print("  a & b (AND): 0b{b:0>8}\n", .{a & b});
    try stdout.print("  a | b (OR):  0b{b:0>8}\n", .{a | b});
    try stdout.print("  a ^ b (XOR): 0b{b:0>8}\n", .{a ^ b});
    try stdout.print("  ~a (NOT):    0b{b:0>8}\n", .{~a});
}
