// 090_json_parsing.zig - JSON 解析
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== JSON Parsing Demo ===\n\n", .{});

    const json_data = "{\"name\":\"Zig\",\"version\":\"0.13.0\"}";

    const parsed = try std.json.parseFromSlice(
        std.json.Value,
        std.heap.page_allocator,
        json_data,
        .{},
    );
    defer parsed.deinit();

    try stdout.print("Parsed JSON: {any}\n", .{parsed.value});
}
