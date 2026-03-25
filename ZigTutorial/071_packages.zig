// 071_packages.zig - 包管理基础
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Package Management Demo ===\n", .{});
    try stdout.print("Packages in Zig are managed through build.zig\n", .{});
}
