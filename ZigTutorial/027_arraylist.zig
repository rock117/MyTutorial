// 027_arraylist.zig - ArrayList 动态数组
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const allocator = std.heap.page_allocator;

    // 创建 ArrayList
    var list = std.ArrayList(i32).init(allocator);
    defer list.deinit();

    // 添加元素
    try list.append(10);
    try list.append(20);
    try list.append(30);

    try stdout.print("ArrayList: {any}\n", .{list.items});
    try stdout.print("Length: {d}\n", .{list.items.len});
}
