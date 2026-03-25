// 084_modular_code.zig - 模块化代码
const std = @import("std");

// 模块化示例
const math = struct {
    pub const pi = 3.14159;

    pub fn circleArea(radius: f64) f64 {
        return pi * radius * radius;
    }
};

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const area = math.circleArea(5.0);
    try stdout.print("Circle area (r=5): {d:.2}\n", .{area});
}
