// 026_memory_allocation.zig - 内存分配基础
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // 使用堆分配器
    var allocator = std.heap.page_allocator;

    // 分配内存
    const memory = try allocator.create(i32);
    memory.* = 42;

    try stdout.print("Allocated value: {d}\n", .{memory.*});

    // 释放内存
    allocator.destroy(memory);
    try stdout.print("Memory freed\n", .{});
}
