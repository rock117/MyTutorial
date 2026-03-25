// 057_compile_log.zig - 编译日志演示
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Compile log examples\n", .{});
    
    // 注意：@compileLog 在运行时不会输出，仅在编译时
    // @compileLog("This is a compile log message");
}
