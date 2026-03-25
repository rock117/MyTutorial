// 028_hashmap.zig - HashMap 哈希表
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const allocator = std.heap.page_allocator;

    // 创建 HashMap
    var map = std.StringHashMap(i32).init(allocator);
    defer map.deinit();

    // 插入键值对
    try map.put("one", 1);
    try map.put("two", 2);
    try map.put("three", 3);

    try stdout.print("HashMap entries:\n", .{});
    var iter = map.iterator();
    while (iter.next()) |entry| {
        try stdout.print("  {s} -> {d}\n", .{entry.key_ptr.*, entry.value_ptr.*});
    }
}
