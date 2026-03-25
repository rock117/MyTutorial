// ============================================================================
// 021_slices.zig
// ============================================================================
// 教程主题：切片 (Slices)
// 难度等级：⭐⭐ (中级)
// 涵盖知识点：
//   - 切片定义
//   - 切片与数组
//   - 切片操作
//   - 切片边界
// ============================================================================

const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Slices Demo ===\n\n", .{});

    // ========================================================================
    // 1. 从数组创建切片
    // ========================================================================
    try stdout.print("1. Creating slices from arrays:\n", .{});

    const array = [_]i32{ 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 };

    // 完整数组切片
    const full_slice: []const i32 = &array;
    try stdout.print("   Full slice: {any}\n", .{full_slice});
    try stdout.print("   Length: {d}\n", .{full_slice.len});

    // 部分切片 [start..end]
    const partial_slice: []const i32 = array[1..5];  // [20, 30, 40, 50]
    try stdout.print("   Partial [1..5]: {any}\n", .{partial_slice});
    try stdout.print("\n", .{});

    // ========================================================================
    // 2. 切片操作
    // ========================================================================
    try stdout.print("2. Slice operations:\n", .{});

    var mutable_array = [_]i32{ 1, 2, 3, 4, 5 };
    var mutable_slice: []i32 = &mutable_array;

    try stdout.print("   Original: {any}\n", .{mutable_slice});

    // 修改切片元素
    mutable_slice[0] = 10;
    mutable_slice[4] = 50;
    try stdout.print("   Modified: {any}\n", .{mutable_slice});
    try stdout.print("\n", .{});

    // ========================================================================
    // 3. 切片语法
    // ========================================================================
    try stdout.print("3. Slice syntax variations:\n", .{});

    const data = [_]i32{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };

    // [start..end] - 从 start 到 end（不包含）
    try stdout.print("   [2..6]: {any}\n", .{data[2..6]});

    // [start..] - 从 start 到末尾
    try stdout.print("   [5..]: {any}\n", .{data[5..]});

    // [..end] - 从开始到 end（不包含）
    const slice_end: []const i32 = data[0..3];
    try stdout.print("   [..3]: {any}\n", .{slice_end});

    // [...] - 完整数组
    const full_data_slice: []const i32 = &data;
    try stdout.print("   [...]: {any}\n", .{full_data_slice});
    try stdout.print("\n", .{});

    // ========================================================================
    // 4. 切片与指针
    // ========================================================================
    try stdout.print("4. Slices and pointers:\n", .{});

    const numbers = [_]i32{ 100, 200, 300 };
    const slice: []const i32 = &numbers;

    try stdout.print("   Slice pointer: {*}\n", .{slice.ptr});
    try stdout.print("   First element: {d}\n", .{slice.ptr[0]});
    try stdout.print("   Slice length: {d}\n", .{slice.len});
    try stdout.print("\n", .{});

    // ========================================================================
    // 5. 遍历切片
    // ========================================================================
    try stdout.print("5. Iterating over slices:\n", .{});

    const values = [_]i32{ 10, 20, 30, 40, 50 };
    const value_slice = values[1..4];  // [20, 30, 40]

    for (value_slice, 0..) |val, index| {
        try stdout.print("   [{d}] = {d}\n", .{index, val});
    }
    try stdout.print("\n", .{});

    // ========================================================================
    // 6. 切片作为函数参数
    // ========================================================================
    try stdout.print("6. Slices as function parameters:\n", .{});

    const arr = [_]i32{ 5, 10, 15, 20, 25 };
    try stdout.print("   Array sum: {d}\n", .{sumSlice(&arr)});
    try stdout.print("   Partial sum [1..4]: {d}\n", .{sumSlice(arr[1..4])});
}

// ========================================================================
// 辅助函数：计算切片元素总和
// ========================================================================
fn sumSlice(slice: []const i32) i32 {
    var total: i32 = 0;
    for (slice) |value| {
        total += value;
    }
    return total;
}

// ============================================================================
// 运行方式：
//   zig run 021_slices.zig
// ============================================================================

// ============================================================================
// 关键概念解释：
//
// 1. 切片类型 []T：
//    - 切片是对数组或其它切片的视图
//    - 包含指针和长度
//    - 不拥有数据，只是引用
//
// 2. 切片语法：
//    - [start..end]：从 start 到 end（不包含）
//    - [start..]：从 start 到末尾
//    - [..end]：从开始到 end
//    - [...]：完整范围
//
// 3. 切片与数组：
//    - 数组：[N]T，固定长度
//    - 切片：[]T，动态长度
//    - 切片可以从数组创建
//
// 4. 切片操作：
//    - 访问元素：slice[index]
//    - 获取长度：slice.len
//    - 获取指针：slice.ptr
//
// 5. 切片边界：
//    - 运行时不检查边界（在 Release 模式）
//    - 越界访问是未定义行为
// ============================================================================

// ============================================================================
// 练习建议：
// 1. 编写函数在切片中查找最大值
// 2. 实现切片反转函数
// 3. 创建函数合并两个切片
// 4. 实现切片过滤功能（保留满足条件的元素）
// ============================================================================
