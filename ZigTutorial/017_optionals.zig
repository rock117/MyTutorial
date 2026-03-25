// ============================================================================
// 017_optionals.zig
// ============================================================================
// 教程主题：可选值 (Optionals)
// 难度等级：⭐⭐ (进阶)
// 涵盖知识点：
//   - 可选类型定义
//   - null 和非 null 值
//   - if 模式匹配
//   - orelse 和 orelseReturn
// ============================================================================

const std = @import("std");

fn getDefault() i32 {
    const stdout = std.io.getStdOut().writer();
    stdout.print("   Getting default value...\n", .{}) catch {};
    return 99;
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Optional Values Demo ===\n\n", .{});

    // ========================================================================
    // 1. 可选值基础
    // ========================================================================
    try stdout.print("1. Basic optionals:\n", .{});

    var maybe_number: ?i32 = null;
    try stdout.print("   Initial null value: {?}\n", .{maybe_number});

    maybe_number = 42;
    try stdout.print("   Assigned value: {?}\n", .{maybe_number});
    try stdout.print("\n", .{});

    // ========================================================================
    // 2. if 模式匹配
    // ========================================================================
    try stdout.print("2. Pattern matching with if:\n", .{});

    const optional_value: ?i32 = 100;

    if (optional_value) |value| {
        try stdout.print("   Value exists: {d}\n", .{value});
    } else {
        try stdout.print("   Value is null\n", .{});
    }

    const null_value: ?i32 = null;

    if (null_value) |value| {
        try stdout.print("   Value exists: {d}\n", .{value});
    } else {
        try stdout.print("   Value is null\n", .{});
    }
    try stdout.print("\n", .{});

    // ========================================================================
    // 3. orelse - 提供默认值
    // ========================================================================
    try stdout.print("3. Using 'orelse' (default value):\n", .{});

    const maybe_num1: ?i32 = 42;
    const result1 = maybe_num1 orelse 0;
    try stdout.print("   42 orelse 0 = {d}\n", .{result1});

    const maybe_num2: ?i32 = null;
    const result2 = maybe_num2 orelse 0;
    try stdout.print("   null orelse 0 = {d}\n", .{result2});
    try stdout.print("\n", .{});

    // ========================================================================
    // 4. orelse 与函数调用
    // ========================================================================
    try stdout.print("4. orelse with function call:\n", .{});

    const maybe_num3: ?i32 = null;
    const result3 = maybe_num3 orelse getDefault();
    try stdout.print("   Result: {d}\n", .{result3});
    try stdout.print("\n", .{});

    // ========================================================================
    // 5. .? - 强制解包（panic on null）
    // ========================================================================
    try stdout.print("5. Forced unwrap with '.?':\n", .{});

    const definitely_value: ?i32 = 123;
    const unwrapped = definitely_value.?;  // 如果为 null 会 panic
    try stdout.print("   Unwrapped value: {d}\n", .{unwrapped});

    // const will_panic: ?i32 = null;
    // const panic_value = will_panic.?;  // 这会导致 panic
    try stdout.print("\n", .{});

    // ========================================================================
    // 6. 可选指针
    // ========================================================================
    try stdout.print("6. Optional pointers:\n", .{});

    var number: i32 = 456;
    var optional_ptr: ?*i32 = &number;

    if (optional_ptr) |ptr| {
        try stdout.print("   Pointer points to: {d}\n", .{ptr.*});
    }

    optional_ptr = null;
    try stdout.print("   Pointer set to null: {*}\n", .{optional_ptr});
    try stdout.print("\n", .{});

    // ========================================================================
    // 7. catch 处理 null
    // ========================================================================
    try stdout.print("7. Using 'catch' with optionals:\n", .{});

    const optional_num: ?i32 = null;
    const catch_result = optional_num orelse blk: {
        try stdout.print("   Caught null\n", .{});
        break :blk 0;
    };

    try stdout.print("   Result: {d}\n", .{catch_result});
}

// ============================================================================
// 辅助函数：查找数组中的元素
// ============================================================================
fn findValue(arr: []const i32, target: i32) ?usize {
    for (arr, 0..) |value, index| {
        if (value == target) {
            return index;
        }
    }
    return null;
}

// ============================================================================
// 运行方式：
//   zig run 017_optionals.zig
// ============================================================================

// ============================================================================
// 关键概念解释：
//
// 1. 可选类型 (?T)：
//    - ?T 表示类型 T 或 null
//    - 用于表示可能不存在的值
//    - 例如：?i32 可以是 i32 或 null
//
// 2. null 值：
//    - 表示"没有值"
//    - 只能用于可选类型
//    - 不是指针，是特殊的值
//
// 3. if 模式匹配：
//    if (optional) |value| { ... } else { ... }
//    如果有值，解包到 value；否则执行 else
//
// 4. orelse：
//    optional orelse default_value
//    如果 optional 为 null，返回 default_value
//    否则返回 optional 中的值
//
// 5. .? 强制解包：
//    optional.?
//    如果为 null，触发 panic
//    如果有值，返回该值
//
// 6. 可选指针：
//    ?*T - 可以是 null 的指针
//    用于表示可能无效的指针
// ============================================================================

// ============================================================================
// 练习建议：
// 1. 编写函数在数组中查找元素，返回索引或 null
// 2. 实现配置解析，某些配置项可选
// 3. 使用可选值表示可能失败的操作
// 4. 编写安全的除法函数，处理除零情况
// ============================================================================
