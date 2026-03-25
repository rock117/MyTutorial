// 044_c_interop.zig - C语言互操作
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== C Interop Demo ===\n\n", .{});
    try stdout.print("C interop in Zig:\n", .{});
    try stdout.print("Use 'extern' to declare C functions\n", .{});
    try stdout.print("Use @cImport to include C headers\n", .{});
    try stdout.print("\nNote: Full C interop requires linking libc\n", .{});
}
