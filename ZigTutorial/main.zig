// 我的第一个 Zig 程序
const std = @import("std");

pub fn main() !void {
    // 标准输出流
    const stdout = std.io.getStdOut().writer();

    // 打印 Hello World
    try stdout.print("Hello, World! 你好，世界！\n", .{});

    // 打印一些额外信息
    try stdout.print("欢迎来到 Zig 的世界！\n", .{});
    try stdout.print("这是一个系统级编程语言。\n", .{});
}
