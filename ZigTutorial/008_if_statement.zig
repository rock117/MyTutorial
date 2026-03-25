// ============================================================================
// 008_if_statement.zig
// ============================================================================
// 教程主题：if 条件语句
// 难度等级：⭐ (新手)
// 涵盖知识点：
//   - if 语句
//   - if-else 语句
//   - if-else if-else 链
//   - if 作为表达式
// ============================================================================

const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // ========================================================================
    // 1. 基本 if 语句
    // ========================================================================

    const age: i32 = 18;

    try stdout.print("基本 if 语句示例：\n", .{});
    try stdout.print("  年龄: {d}\n", .{age});

    if (age >= 18) {
        try stdout.print("  已成年\n", .{});
    }
    try stdout.print("\n", .{});

    // ========================================================================
    // 2. if-else 语句
    // ========================================================================

    const score: i32 = 85;

    try stdout.print("if-else 示例：\n", .{});
    try stdout.print("  分数: {d}\n", .{score});

    if (score >= 60) {
        try stdout.print("  结果: 及格\n", .{});
    } else {
        try stdout.print("  结果: 不及格\n", .{});
    }
    try stdout.print("\n", .{});

    // ========================================================================
    // 3. if-else if-else 链
    // ========================================================================

    const grade: i32 = 75;

    try stdout.print("if-else if-else 链示例：\n", .{});
    try stdout.print("  分数: {d}\n", .{grade});

    if (grade >= 90) {
        try stdout.print("  等级: A\n", .{});
    } else if (grade >= 80) {
        try stdout.print("  等级: B\n", .{});
    } else if (grade >= 70) {
        try stdout.print("  等级: C\n", .{});
    } else if (grade >= 60) {
        try stdout.print("  等级: D\n", .{});
    } else {
        try stdout.print("  等级: F\n", .{});
    }
    try stdout.print("\n", .{});

    // ========================================================================
    // 4. if 作为表达式
    // ========================================================================
    // Zig 的 if 可以作为表达式，返回值

    const x: i32 = 10;
    const y: i32 = 20;

    const max: i32 = if (x > y) x else y;

    try stdout.print("if 表达式示例：\n", .{});
    try stdout.print("  x = {d}, y = {d}\n", .{x, y});
    try stdout.print("  max = {d}\n", .{max});
    try stdout.print("\n", .{});

    // ========================================================================
    // 5. 复杂条件
    // ========================================================================

    const temperature: i32 = 25;
    const is_sunny: bool = true;

    try stdout.print("复杂条件示例：\n", .{});
    try stdout.print("  温度: {d}°C, 晴天: {}\n", .{temperature, is_sunny});

    if (temperature > 20 and temperature < 30 and is_sunny) {
        try stdout.print("  建议: 适合户外活动\n", .{});
    } else if (temperature <= 20) {
        try stdout.print("  建议: 天气有点凉\n", .{});
    } else {
        try stdout.print("  建议: 天气太热或不是晴天\n", .{});
    }
    try stdout.print("\n", .{});

    // ========================================================================
    // 6. 嵌套 if
    // ========================================================================

    const num: i32 = 15;

    try stdout.print("嵌套 if 示例：\n", .{});
    try stdout.print("  数字: {d}\n", .{num});

    if (num > 0) {
        if (num % 2 == 0) {
            try stdout.print("  结果: 正偶数\n", .{});
        } else {
            try stdout.print("  结果: 正奇数\n", .{});
        }
    } else if (num < 0) {
        try stdout.print("  结果: 负数\n", .{});
    } else {
        try stdout.print("  结果: 零\n", .{});
    }
    try stdout.print("\n", .{});

    // ========================================================================
    // 7. if 与可选值
    // ========================================================================

    const optional_num: ?i32 = 42;

    try stdout.print("if 与可选值示例：\n", .{});

    if (optional_num) |value| {
        try stdout.print("  值存在: {d}\n", .{value});
    } else {
        try stdout.print("  值不存在\n", .{});
    }

    const null_optional: ?i32 = null;

    if (null_optional) |value| {
        try stdout.print("  值存在: {d}\n", .{value});
    } else {
        try stdout.print("  值不存在 (null)\n", .{});
    }
    try stdout.print("\n", .{});

    // ========================================================================
    // 8. if 与错误联合
    // ========================================================================

    const result = maybeError(false);

    if (result) |value| {
        try stdout.print("if 与错误联合示例:\n", .{});
        try stdout.print("  成功: {d}\n", .{value});
    } else |err| {
        try stdout.print("if 与错误联合示例:\n", .{});
        try stdout.print("  错误: {}\n", .{err});
    }
}

// 返回可能错误的函数
fn maybeError(should_error: bool) !i32 {
    if (should_error) {
        return error.SomeError;
    }
    return 42;
}

// ============================================================================
// 运行方式：
//   zig run 008_if_statement.zig
// ============================================================================

// ============================================================================
// 关键概念解释：
//
// 1. if 语句结构：
//    if (condition) {
//        // 条件为真时执行
//    }
//
// 2. if-else 结构：
//    if (condition) {
//        // 条件为真时执行
//    } else {
//        // 条件为假时执行
//    }
//
// 3. if 表达式：
//    const x = if (condition) value1 else value2;
//    两个分支必须返回相同类型
//
// 4. if 与可选值：
//    if (optional) |value| {
//        // optional 不为 null 时执行，value 是解包后的值
//    } else {
//        // optional 为 null 时执行
//    }
//
// 5. if 与错误联合：
//    if (error_union) |value| {
//        // 成功时执行
//    } else |err| {
//        // 失败时执行
//    }
// ============================================================================

// ============================================================================
// 练习建议：
// 1. 判断一个数是正数、负数还是零
// 2. 根据年龄判断人生阶段（儿童、青少年、成年人、老年人）
// 3. 实现一个简单的计算器，根据运算符执行不同操作
// 4. 判断年份是否是闰年
// ============================================================================
