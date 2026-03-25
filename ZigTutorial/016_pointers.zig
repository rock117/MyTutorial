// ============================================================================
// 016_pointers.zig
// ============================================================================
// 教程主题：指针基础
// 难度等级：⭐⭐ (进阶)
// 涵盖知识点：
//   - 指针定义和解引用
//   - 可变指针与不可变指针
//   - 指针运算
//   - 空指针
// ============================================================================

const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Pointers Demo ===\n\n", .{});

    // ========================================================================
    // 1. 指针基础
    // ========================================================================
    try stdout.print("1. Basic pointers:\n", .{});

    var num: i32 = 42;
    const ptr: *i32 = &num;  // 获取 num 的地址

    try stdout.print("   Value: {d}\n", .{num});
    try stdout.print("   Pointer: {*}\n", .{ptr});
    try stdout.print("   Dereferenced: {d}\n", .{ptr.*});
    try stdout.print("\n", .{});

    // ========================================================================
    // 2. 可变与不可变指针
    // ========================================================================
    try stdout.print("2. Mutable vs immutable pointers:\n", .{});

    var mutable_num: i32 = 10;
    const immutable_num: i32 = 20;

    // 可变指针 - 可以修改指向的值
    const mutable_ptr: *i32 = &mutable_num;
    mutable_ptr.* = 15;
    try stdout.print("   Modified via mutable_ptr: {d}\n", .{mutable_num});

    // 不可变指针 - 不能修改指向的值
    const immutable_ptr: *const i32 = &immutable_num;
    try stdout.print("   Read via immutable_ptr: {d}\n", .{immutable_ptr.*});
    try stdout.print("\n", .{});

    // ========================================================================
    // 3. 指针与数组
    // ========================================================================
    try stdout.print("3. Pointers and arrays:\n", .{});

    const array = [_]i32{ 10, 20, 30, 40, 50 };
    const array_ptr: [*]const i32 = &array;

    try stdout.print("   Array: {any}\n", .{array});
    try stdout.print("   First element via pointer: {d}\n", .{array_ptr[0]});
    try stdout.print("   Third element via pointer: {d}\n", .{array_ptr[2]});
    try stdout.print("\n", .{});

    // ========================================================================
    // 4. 指针运算
    // ========================================================================
    try stdout.print("4. Pointer arithmetic:\n", .{});

    const numbers = [_]i32{ 100, 200, 300, 400 };
    const base_ptr: [*]const i32 = &numbers;

    try stdout.print("   Base address points to: {d}\n", .{base_ptr[0]});
    try stdout.print("   Base + 1 points to: {d}\n", .{base_ptr[1]});
    try stdout.print("   Base + 2 points to: {d}\n", .{base_ptr[2]});
    try stdout.print("\n", .{});

    // ========================================================================
    // 5. 多级指针
    // ========================================================================
    try stdout.print("5. Multiple level pointers:\n", .{});

    var value: i32 = 100;
    const ptr1: *i32 = &value;
    const ptr2: *const *i32 = &ptr1;

    try stdout.print("   Value: {d}\n", .{value});
    try stdout.print("   Via ptr1: {d}\n", .{ptr1.*});
    try stdout.print("   Via ptr2: {d}\n", .{ptr2.*.*});
    try stdout.print("\n", .{});

    // ========================================================================
    // 6. 可选指针
    // ========================================================================
    try stdout.print("6. Optional pointers:\n", .{});

    var maybe_ptr: ?*i32 = null;
    try stdout.print("   Null pointer: {*}\n", .{maybe_ptr});

    var real_value: i32 = 42;
    maybe_ptr = &real_value;
    if (maybe_ptr) |valid_ptr| {
        try stdout.print("   Valid pointer points to: {d}\n", .{valid_ptr.*});
    }
    try stdout.print("\n", .{});

    // ========================================================================
    // 7. 指针与切片
    // ========================================================================
    try stdout.print("7. Pointers and slices:\n", .{});

    const data = [_]i32{ 1, 2, 3, 4, 5 };
    const slice: []const i32 = &data;

    try stdout.print("   Slice: {any}\n", .{slice});
    try stdout.print("   First element: {d}\n", .{slice[0]});
    try stdout.print("   Slice length: {d}\n", .{slice.len});
}

// ============================================================================
// 运行方式：
//   zig run 016_pointers.zig
// ============================================================================

// ============================================================================
// 关键概念解释：
//
// 1. 指针类型：
//    - *T：指向 T 的指针
//    - *const T：指向 T 的不可变指针
//    - [*]T：单元素指针（类似 C 的 T*）
//
// 2. 获取地址：
//    &variable - 获取变量的地址
//
// 3. 解引用：
//    ptr.* - 访问指针指向的值
//
// 4. 指针修饰符：
//    - *T：可变指针（可以修改指向的值）
//    - *const T：不可变指针（不能修改指向的值）
//    - const *T：指针本身不可变（不能指向别处）
//
// 5. 可选指针：
//    ?*T - 可以为 null 的指针
//
// 6. 指针安全性：
//    Zig 指针有严格的边界检查
//    不允许野指针和悬空指针
// ============================================================================

// ============================================================================
// 练习建议：
// 1. 编写函数交换两个变量的值（使用指针）
// 2. 创建函数修改数组元素的值
// 3. 使用指针实现数组反转
// 4. 编写函数通过指针返回多个值
// ============================================================================
