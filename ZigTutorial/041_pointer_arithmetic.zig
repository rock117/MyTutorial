// 041_pointer_arithmetic.zig - 指针运算
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const array = [_]i32{ 10, 20, 30, 40, 50 };
    const ptr: [*]const i32 = &array;

    try stdout.print("Pointer arithmetic:\n", .{});
    try stdout.print("  ptr[0]: {d}\n", .{ptr[0]});
    try stdout.print("  ptr[1]: {d}\n", .{ptr[1]});
    try stdout.print("  ptr+2 points to: {d}\n", .{ptr[2]});
}
