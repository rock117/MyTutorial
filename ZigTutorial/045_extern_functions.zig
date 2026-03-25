// 045_extern_functions.zig - 外部函数声明
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Extern Functions Demo ===\n\n", .{});
    try stdout.print("External function declarations in Zig:\n", .{});
    try stdout.print("extern fn functionName(param: type) returnType;\n\n", .{});
    try stdout.print("Note: Calling external C functions requires linking libc\n", .{});
}
