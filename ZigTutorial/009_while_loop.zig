// ============================================================================
// 009_while_loop.zig
// ============================================================================
// 教程主题：while 循环
// 难度等级：⭐ (新手)
// 涵盖知识点：
//   - 基本 while 循环
//   - while with continue 表达式
//   - while 与可选值
//   - while 与错误联合
//   - break 和 continue
// ============================================================================

const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // ========================================================================
    // 1. 基本 while 循环
    // ========================================================================

    var i: i32 = 0;

    try stdout.print("基本 while 循环：\n", .{});
    while (i < 5) {
        try stdout.print("  计数: {d}\n", .{i});
        i += 1;
    }
    try stdout.print("\n", .{});

    // ========================================================================
    // 2. while with continue 表达式
    // ========================================================================
    // continue 表达式在每次循环后执行

    var j: i32 = 0;

    try stdout.print("while with continue：\n", .{});
    while (j < 5) : (j += 1) {
        try stdout.print("  j = {d}\n", .{j});
    }
    try stdout.print("\n", .{});

    // ========================================================================
    // 3. break 和 continue
    // ========================================================================

    var k: i32 = 0;

    try stdout.print("break 示例：\n", .{});
    while (k < 10) : (k += 1) {
        if (k == 5) {
            try stdout.print("  在 k={d} 时跳出循环\n", .{k});
            break;
        }
        try stdout.print("  k = {d}\n", .{k});
    }
    try stdout.print("\n", .{});

    var m: i32 = 0;

    try stdout.print("continue 示例：\n", .{});
    while (m < 5) : (m += 1) {
        if (m == 2) {
            try stdout.print("  跳过 m={d}\n", .{m});
            continue;
        }
        try stdout.print("  m = {d}\n", .{m});
    }
    try stdout.print("\n", .{});

    // ========================================================================
    // 4. while 与可选值
    // ========================================================================
    // 循环直到可选值为 null

    var counter: i32 = 0;

    try stdout.print("while 与可选值：\n", .{});
    while (getNextNumber(&counter)) |value| {
        try stdout.print("  值: {d}\n", .{value});
    }
    try stdout.print("  可选值为 null，循环结束\n", .{});
    try stdout.print("\n", .{});

    // ========================================================================
    // 5. while 与错误联合
    // ========================================================================
    // 循环直到返回错误

    var error_counter: i32 = 0;

    try stdout.print("while 与错误联合：\n", .{});
    while (getNextWithError(&error_counter)) |value| {
        try stdout.print("  值: {d}\n", .{value});
    } else |err| {
        try stdout.print("  捕获错误: {}\n", .{err});
    }
    try stdout.print("\n", .{});

    // ========================================================================
    // 6. 嵌套循环
    // ========================================================================

    try stdout.print("嵌套 while 循环（乘法表）：\n", .{});
    var row: i32 = 1;
    while (row <= 3) : (row += 1) {
        var col: i32 = 1;
        while (col <= 3) : (col += 1) {
            try stdout.print("  {d}x{d}={d}  ", .{row, col, row * col});
        }
        try stdout.print("\n", .{});
    }
    try stdout.print("\n", .{});

    // ========================================================================
    // 7. 标签和 break/continue
    // ========================================================================
    // 使用标签跳出特定循环

    var outer: i32 = 0;

    try stdout.print("标签 break 示例：\n", .{});
    outer_loop: while (outer < 3) : (outer += 1) {
        var inner: i32 = 0;

        try stdout.print("  外层循环 {d}\n", .{outer});

        while (inner < 3) : (inner += 1) {
            if (outer == 1 and inner == 1) {
                try stdout.print("    跳出外层循环\n", .{});
                break :outer_loop;
            }
            try stdout.print("    内层循环 {d}\n", .{inner});
        }
    }
    try stdout.print("  循环结束\n", .{});
}

// 返回可选值的函数
fn getNextNumber(count: *i32) ?i32 {
    if (count.* >= 3) {
        return null;
    }
    const value = count.*;
    count.* += 1;
    return value;
}

// 返回错误联合的函数
fn getNextWithError(count: *i32) !i32 {
    if (count.* >= 3) {
        return error.EndOfSequence;
    }
    const value = count.*;
    count.* += 1;
    return value;
}

// ============================================================================
// 运行方式：
//   zig run 009_while_loop.zig
// ============================================================================

// ============================================================================
// 关键概念解释：
//
// 1. 基本 while 循环：
//    while (condition) {
//        // 循环体
//    }
//
// 2. while with continue：
//    while (condition) : (continue_expression) {
//        // 循环体
//    }
//    continue 表达式在每次循环后执行
//
// 3. break 和 continue：
//    - break：立即退出循环
//    - continue：跳过本次循环剩余代码，继续下一次
//
// 4. while 与可选值：
//    while (optional) |value| {
//        // optional 不为 null 时执行
//    }
//
// 5. while 与错误联合：
//    while (error_union) |value| {
//        // 成功时执行
//    } else |err| {
//        // 错误时执行
//    }
//
// 6. 标签：
//    label: while (condition) {
//        break :label;  // 跳出标签指定的循环
//    }
// ============================================================================

// ============================================================================
// 练习建议：
// 1. 使用 while 循环计算 1 到 100 的和
// 2. 实现一个倒计时程序
// 3. 使用 while 循环实现简单的猜数字游戏
// 4. 使用嵌套 while 循环打印各种图案
// ============================================================================
