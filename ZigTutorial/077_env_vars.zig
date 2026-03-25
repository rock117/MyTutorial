// 077_env_vars.zig - 环境变量
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const path = std.process.getEnvVarOwned(std.heap.page_allocator, "PATH") catch "PATH not set";
    defer std.heap.page_allocator.free(path);

    try stdout.print("PATH: {s}\n", .{path});
}
