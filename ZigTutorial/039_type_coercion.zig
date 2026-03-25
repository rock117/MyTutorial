// 039_type_coercion.zig - 类型 coercion
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // 数组到切片的 coercion
    const array = [_]i32{ 1, 2, 3 };
    const slice: []const i32 = &array;

    try stdout.print("Array: {any}\n", .{array});
    try stdout.print("Slice: {any}\n", .{slice});

    // 可选值 coercion
    const optional: ?i32 = 42;
    const error_union: anyerror!i32 = optional orelse return error.NotFound;

    try stdout.print("Error union result: {any}\n", .{error_union});
}
