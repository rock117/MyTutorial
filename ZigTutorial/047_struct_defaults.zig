// 047_struct_defaults.zig - 结构体默认值
const std = @import("std");

const Config = struct {
    port: u16 = 8080,
    host: []const u8 = "localhost",
    debug: bool = false,
};

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // 使用默认值
    const default_config: Config = .{};
    try stdout.print("Default config: port={d}, host={s}\n", .{
        default_config.port,
        default_config.host,
    });

    // 部分覆盖
    const custom_config: Config = .{ .port = 3000 };
    try stdout.print("Custom config: port={d}, host={s}\n", .{
        custom_config.port,
        custom_config.host,
    });
}
