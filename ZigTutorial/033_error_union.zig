// 033_error_union.zig - error_union 错误联合
const std = @import("std");

const MathError = error{
    DivisionByZero,
};

fn safeDivide(a: f64, b: f64) MathError!f64 {
    if (b == 0) return MathError.DivisionByZero;
    return a / b;
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // 检查错误联合
    const result: MathError!f64 = safeDivide(10.0, 2.0);

    if (result) |value| {
        try stdout.print("Result: {d}\n", .{value});
    } else |err| {
        try stdout.print("Error: {}\n", .{err});
    }
}
