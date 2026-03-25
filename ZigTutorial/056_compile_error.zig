// 056_compile_error.zig - 编译时错误演示
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Compile error examples\n", .{});
    
    // 这里演示如何触发编译错误
    // const x: i32 = "not a number";  // 这会编译失败
}
