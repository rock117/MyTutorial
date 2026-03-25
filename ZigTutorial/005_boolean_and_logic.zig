// ============================================================================
// 005_boolean_and_logic.zig
// ============================================================================
// 教程主题：布尔类型与逻辑运算
// 难度等级：⭐ (新手)
// 涵盖知识点：
//   - 布尔类型
//   - 逻辑运算符（and, or, not）
//   - 短路求值
//   - 比较运算符
// ============================================================================

const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // ========================================================================
    // 1. 布尔类型基础
    // ========================================================================
    // 布尔类型只有两个值：true 和 false

    const is_sunny: bool = true;
    const is_raining: bool = false;
    const is_weekend: bool = true;

    try stdout.print("布尔值示例：\n", .{});
    try stdout.print("  今天是晴天: {}\n", .{is_sunny});
    try stdout.print("  今天下雨: {}\n", .{is_raining});
    try stdout.print("  今天是周末: {}\n", .{is_weekend});
    try stdout.print("\n", .{});

    // ========================================================================
    // 2. 逻辑与运算符 (and)
    // ========================================================================
    // 两个都为 true 时结果为 true

    const a: bool = true;
    const b: bool = false;

    try stdout.print("逻辑与 (and) 运算：\n", .{});
    try stdout.print("  a = {}, b = {}\n", .{a, b});
    try stdout.print("  true and true   = {}\n", .{true and true});
    try stdout.print("  true and false  = {}\n", .{true and false});
    try stdout.print("  false and true  = {}\n", .{false and true});
    try stdout.print("  false and false = {}\n", .{false and false});
    try stdout.print("\n", .{});

    // 实际应用示例
    const can_go_out = is_sunny and !is_raining;
    try stdout.print("  晴天且不下雨可以出门: {}\n", .{can_go_out});
    try stdout.print("\n", .{});

    // ========================================================================
    // 3. 逻辑或运算符 (or)
    // ========================================================================
    // 有一个为 true 时结果为 true

    try stdout.print("逻辑或 (or) 运算：\n", .{});
    try stdout.print("  true or true   = {}\n", .{true or true});
    try stdout.print("  true or false  = {}\n", .{true or false});
    try stdout.print("  false or true  = {}\n", .{false or true});
    try stdout.print("  false or false = {}\n", .{false or false});
    try stdout.print("\n", .{});

    // 实际应用示例
    const can_relax = is_weekend or !is_sunny;
    try stdout.print("  周末或不是晴天可以休息: {}\n", .{can_relax});
    try stdout.print("\n", .{});

    // ========================================================================
    // 4. 逻辑非运算符 (not)
    // ========================================================================
    // 取反：true 变 false，false 变 true

    try stdout.print("逻辑非 (not) 运算：\n", .{});
    try stdout.print("  not true  = {}\n", .{!true});
    try stdout.print("  not false = {}\n", .{!false});
    try stdout.print("\n", .{});

    // 实际应用示例
    const is_weekday = !is_weekend;
    try stdout.print("  今天是工作日: {}\n", .{is_weekday});
    try stdout.print("\n", .{});

    // ========================================================================
    // 5. 短路求值 (Short-circuit Evaluation)
    // ========================================================================
    // and: 第一个为 false，不会计算第二个
    // or: 第一个为 true，不会计算第二个

    var call_count: i32 = 0;

    // and 短路：第一个为 false，不会调用第二个函数
    const result_and = false and increment(&call_count);
    try stdout.print("and 短路求值：\n", .{});
    try stdout.print("  结果: {}, 调用次数: {d}\n", .{result_and, call_count});

    // or 短路：第一个为 true，不会调用第二个函数
    call_count = 0;
    const result_or = true or increment(&call_count);
    try stdout.print("or 短路求值：\n", .{});
    try stdout.print("  结果: {}, 调用次数: {d}\n", .{result_or, call_count});
    try stdout.print("\n", .{});

    // ========================================================================
    // 6. 逻辑运算符优先级和组合
    // ========================================================================
    // not 优先级最高，and 次之，or 最低
    // 不确定时使用括号

    const x: bool = true;
    const y: bool = false;
    const z: bool = true;

    try stdout.print("逻辑运算组合：\n", .{});
    try stdout.print("  (true or false) and true = {}\n", .{(x or y) and z});
    try stdout.print("  true or (false and true) = {}\n", .{x or (y and z)});
    try stdout.print("  not (true or false)      = {}\n", .{!(x or y)});
    try stdout.print("  not true or false        = {}\n", .{(!x) or y});
    try stdout.print("\n", .{});

    // ========================================================================
    // 7. 比较运算符与布尔值
    // ========================================================================

    const num1: i32 = 10;
    const num2: i32 = 20;

    try stdout.print("比较运算返回布尔值：\n", .{});
    try stdout.print("  10 < 20  = {}\n", .{num1 < num2});
    try stdout.print("  10 == 20 = {}\n", .{num1 == num2});
    try stdout.print("  10 != 20 = {}\n", .{num1 != num2});
    try stdout.print("\n", .{});

    // ========================================================================
    // 8. 复杂条件判断
    // ========================================================================
    // 组合多个条件

    const age: i32 = 25;
    const has_license: bool = true;
    const has_car: bool = false;

    // 可以开车：有驾照且有车，或者年龄超过18且有驾照
    const can_drive = (has_license and has_car) or (age > 18 and has_license);
    try stdout.print("条件组合示例（age={d}, license={}, car={}）：\n", .{age, has_license, has_car});
    try stdout.print("  可以开车: {}\n", .{can_drive});
}

// 辅助函数：递增计数器并返回 true
fn increment(count: *i32) bool {
    count.* += 1;
    return true;
}

// ============================================================================
// 运行方式：
//   zig run 005_boolean_and_logic.zig
// ============================================================================

// ============================================================================
// 关键概念解释：
//
// 1. 逻辑运算符：
//    - and：逻辑与，两个都真才真
//    - or：逻辑或，有一个真就真
//    - not：逻辑非，取反
//
// 2. 短路求值：
//    - and：第一个为 false，不计算第二个
//    - or：第一个为 true，不计算第二个
//    - 用于避免不必要的计算
//
// 3. 运算符优先级：
//    not > and > or
//    不确定时使用括号明确优先级
//
// 4. 布尔值用途：
//    - 条件判断
//    - 循环控制
//    - 状态标志
//    - 配置选项
// ============================================================================

// ============================================================================
// 练习建议：
// 1. 编写函数判断一个年份是否是闰年
// 2. 判断一个数是否在某个范围内
// 3. 实现简单的登录验证（用户名和密码）
// 4. 练习短路求值，避免不必要的计算
// ============================================================================
