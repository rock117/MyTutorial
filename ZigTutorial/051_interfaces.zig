// 051_interfaces.zig - 接口与 duck typing
const std = @import("std");

// 定义接口（通过结构体实现）
const Writer = struct {
    write_fn: *const fn (*const Writer, []const u8) anyerror!void,
    context: *const void,

    fn write(self: *const Writer, data: []const u8) !void {
        try self.write_fn(self, data);
    }
};

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Duck Typing Demo ===\n", .{});
    try stdout.print("Zig uses duck typing for interfaces\n", .{});
    try stdout.print("If it walks like a duck and quacks like a duck...\n", .{});
}
