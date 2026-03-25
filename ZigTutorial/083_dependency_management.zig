// 083_dependency_management.zig - 依赖管理
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Dependency Management ===\n\n", .{});

    try stdout.print("In build.zig:\n", .{});
    try stdout.print("  const dep = b.dependency(\"package-name\", .{{...}})\n", .{});
    try stdout.print("  const module = dep.module(\"package\");\n\n", .{});

    try stdout.print("Use zig build --fetch for fetching dependencies\n", .{});
}
