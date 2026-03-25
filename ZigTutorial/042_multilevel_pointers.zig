// 042_multilevel_pointers.zig - 多级指针
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    var value: i32 = 42;
    var ptr1: *i32 = &value;
    var ptr2: **i32 = &ptr1;
    const ptr3: ***i32 = &ptr2;

    try stdout.print("Value via ptr1: {d}\n", .{ptr1.*});
    try stdout.print("Value via ptr2: {d}\n", .{ptr2.*.*});
    try stdout.print("Value via ptr3: {d}\n", .{ptr3.*.*.*});
}
