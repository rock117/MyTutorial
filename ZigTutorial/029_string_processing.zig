// 029_string_processing.zig - 字符串处理
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const text = "Hello, World!";

    // 字符串长度
    try stdout.print("Length: {d}\n", .{text.len});

    // 包含判断
    try stdout.print("Contains 'World': {}\n", .{std.mem.indexOf(u8, text, "World") != null});

    // 转大写
    const allocator = std.heap.page_allocator;
    const upper = try std.ascii.allocUpperString(allocator, text);
    defer allocator.free(upper);

    try stdout.print("Uppercase: {s}\n", .{upper});
}
