// 063_ptrcast.zig - @ptrCast 指针转换
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const int_value: i32 = 42;
    const int_ptr: *const i32 = &int_value;

    // 转换为字节指针
    const byte_ptr: *const [4]u8 = @ptrCast(int_ptr);

    try stdout.print("Original: {d}\n", .{int_value});
    try stdout.print("Bytes: {any}\n", .{byte_ptr});
}
