// 082_build_zig.zig - build.zig 构建脚本
const std = @import("std");

// 这是一个 build.zig 示例模板
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "myproject",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(exe);
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("See above for build.zig template\n", .{});
}
