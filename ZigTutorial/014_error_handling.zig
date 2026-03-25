// ============================================================================
// 014_error_handling.zig
// ============================================================================
// 教程主题：错误处理
// 难度等级：⭐⭐ (进阶)
// 涵盖知识点：
//   - 错误集定义
//   - 错误返回类型
//   - try 和 catch
//   - errdefer
// ============================================================================

const std = @import("std");

// ============================================================================
// 1. 定义错误集
// ============================================================================
const MathError = error{
    DivisionByZero,
    NegativeSquareRoot,
    Overflow,
};

// ============================================================================
// 2. 返回错误的函数
// ============================================================================
fn safeDivide(a: f64, b: f64) MathError!f64 {
    if (b == 0) {
        return MathError.DivisionByZero;
    }
    return a / b;
}

fn safeSqrt(x: f64) MathError!f64 {
    if (x < 0) {
        return MathError.NegativeSquareRoot;
    }
    return std.math.sqrt(x);
}

// ============================================================================
// 3. 链式错误处理
// ============================================================================
fn complexMath(a: f64, b: f64) MathError!f64 {
    const result1 = try safeDivide(a, b);
    const result2 = try safeSqrt(result1);
    return result2;
}

// ============================================================================
// 4. anyerror（通用错误类型）
// ============================================================================
fn genericOperation(value: i32) !i32 {
    if (value < 0) {
        return error.NegativeValue;
    }
    if (value > 100) {
        return error.TooLarge;
    }
    return value * 2;
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Error Handling Demo ===\n\n", .{});

    // ========================================================================
    // 1. try - 传递错误
    // ========================================================================
    try stdout.print("1. Using 'try' (propagate error):\n", .{});

    const result1 = safeDivide(10.0, 2.0) catch 0;
    try stdout.print("   10.0 / 2.0 = {d:.2}\n", .{result1});

    const result2 = safeDivide(10.0, 0.0) catch 0;
    try stdout.print("   10.0 / 0.0 = {d:.2} (caught error)\n", .{result2});
    try stdout.print("\n", .{});

    // ========================================================================
    // 2. catch - 捕获错误
    // ========================================================================
    try stdout.print("2. Using 'catch' (handle error):\n", .{});

    const result3 = safeSqrt(16.0) catch |err| {
        try stdout.print("   Error: {}\n", .{err});
        return err;
    };
    try stdout.print("   sqrt(16.0) = {d:.2}\n", .{result3});

    const result4 = safeSqrt(-4.0) catch blk: {
        try stdout.print("   Cannot calculate sqrt of negative number\n", .{});
        break :blk 0.0;
    };
    try stdout.print("   Result after error: {d:.2}\n", .{result4});
    try stdout.print("\n", .{});

    // ========================================================================
    // 3. if else - 模式匹配错误
    // ========================================================================
    try stdout.print("3. Pattern matching with if-else:\n", .{});

    const result5 = safeDivide(20.0, 4.0);
    if (result5) |value| {
        try stdout.print("   Success: {d:.2}\n", .{value});
    } else |err| {
        try stdout.print("   Error: {}\n", .{err});
    }
    try stdout.print("\n", .{});

    // ========================================================================
    // 4. 链式操作
    // ========================================================================
    try stdout.print("4. Chaining operations:\n", .{});

    const chained = complexMath(36.0, 4.0) catch |err| {
        try stdout.print("   Error in chain: {}\n", .{err});
        return err;
    };
    try stdout.print("   sqrt(36.0 / 4.0) = {d:.2}\n", .{chained});
    try stdout.print("\n", .{});

    // ========================================================================
    // 5. 错误联合类型检查
    // ========================================================================
    try stdout.print("5. Error union inspection:\n", .{});

    const maybe_error: MathError!f64 = MathError.NegativeSquareRoot;

    if (maybe_error) |value| {
        try stdout.print("   Value: {d:.2}\n", .{value});
    } else |err| {
        try stdout.print("   Caught error: {}\n", .{err});
    }
}

// ============================================================================
// 运行方式：
//   zig run 014_error_handling.zig
// ============================================================================

// ============================================================================
// 关键概念解释：
//
// 1. 错误集 (Error Set)：
//    const MyError = error{ Error1, Error2 };
//    定义一组可能的错误
//
// 2. 错误联合类型 (!T)：
//    !T 表示可能返回错误或 T 类型的值
//    例如：!i32 表示返回 i32 或错误
//
// 3. try：
//    - 如果表达式成功，提取值
//    - 如果表达式返回错误，立即从当前函数返回该错误
//    - 简化错误传递
//
// 4. catch：
//    value catch |err| { ... }
//    捕获错误并处理
//
// 5. if-else 模式匹配：
//    if (result) |value| { ... } else |err| { ... }
//    同时处理成功和失败情况
//
// 6. errdefer：
//    在返回错误时执行的延迟语句
//    用于清理资源
// ============================================================================

// ============================================================================
// 练习建议：
// 1. 编写函数处理字符串转整数，处理可能的错误
// 2. 实现银行转账函数，处理余额不足错误
// 3. 编写文件读取函数，处理文件不存在和读取错误
// 4. 使用 errdefer 实现资源清理
// ============================================================================
