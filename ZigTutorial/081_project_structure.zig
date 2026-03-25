// 081_project_structure.zig - 项目结构
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Zig Project Structure ===\n\n", .{});

    try stdout.print("Recommended structure:\n", .{});
    try stdout.print("  project/\n", .{});
    try stdout.print("  ├── build.zig           # Build script\n", .{});
    try stdout.print("  ├── src/\n", .{});
    try stdout.print("  │   └── main.zig       # Main source\n", .{});
    try stdout.print("  └── README.md\n\n", .{});

    try stdout.print("Create with: zig init-exe\n", .{});
}
