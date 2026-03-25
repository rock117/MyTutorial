// 080_build_system.zig - 构建系统基础
const std = @import("std");

// 这是一个 build.zig 模板，不是可运行程序
// 实际使用时需要创建 build.zig 文件

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Build System Demo ===\n", .{});
    try stdout.print("Use 'zig build-exe' or create build.zig for complex projects\n", .{});
}
