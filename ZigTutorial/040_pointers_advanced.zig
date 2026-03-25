// 040_pointers_advanced.zig - 指针详解
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // 单项指针
    const array = [_]i32{ 10, 20, 30 };
    const single_ptr: [*]const i32 = &array;

    try stdout.print("Single element pointer:\n", .{});
    try stdout.print("  [0]: {d}\n", .{single_ptr[0]});
    try stdout.print("  [1]: {d}\n", .{single_ptr[1]});

    // 切片指针
    const slice_ptr: []const i32 = &array;
    try stdout.print("  Slice length: {d}\n", .{slice_ptr.len});
}
