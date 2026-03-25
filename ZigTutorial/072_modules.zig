// 072_modules.zig - 模块化编程
const std = @import("std");

// 模块示例
const math = struct {
    pub fn add(a: i32, b: i32) i32 {
        return a + b;
    }
};

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const result = math.add(10, 20);
    try stdout.print("Result: {d}\n", .{result});
}
