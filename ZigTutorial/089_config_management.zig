// 089_config_management.zig - 配置管理
const std = @import("std");

const Config = struct {
    port: u16 = 8080,
    debug: bool = false,
    log_level: []const u8 = "info",
};

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const config: Config = .{ .port = 3000 };

    try stdout.print("Config:\n", .{});
    try stdout.print("  Port: {d}\n", .{config.port});
    try stdout.print("  Debug: {}\n", .{config.debug});
    try stdout.print("  Log Level: {s}\n", .{config.log_level});
}
