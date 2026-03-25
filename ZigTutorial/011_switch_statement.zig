// 011_switch_statement.zig - switch 语句教程
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    
    // 基本 switch
    const grade: u8 = 'B';
    try stdout.print("switch 示例 (grade={c}):\n", .{grade});
    
    const description = switch (grade) {
        'A' => "优秀",
        'B' => "良好",
        'C' => "中等",
        'D' => "及格",
        'F' => "不及格",
        else => "无效",
    };
    
    try stdout.print("  评价: {s}\n\n", .{description});
    
    // switch with range
    const score: i32 = 85;
    try stdout.print("switch 范围示例 (score={d}):\n", .{score});
    
    const level = switch (score) {
        90...100 => "A",
        80...89 => "B",
        70...79 => "C",
        60...69 => "D",
        else => "F",
    };
    
    try stdout.print("  等级: {s}\n", .{level});
}
