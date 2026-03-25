// ============================================================================
// 018_structs.zig
// ============================================================================
// 教程主题：结构体基础
// 难度等级：⭐⭐ (进阶)
// 涨含知识点：
//   - 结构体定义
//   - 结构体实例化
//   - 结构体方法
//   - 结构体字段
// ============================================================================

const std = @import("std");

// ============================================================================
// 1. 基本结构体定义
// ============================================================================
const Point = struct {
    x: f64,
    y: f64,
};

// ============================================================================
// 2. 带方法的结构体
// ============================================================================
const Rectangle = struct {
    width: f64,
    height: f64,

    // 方法：计算面积
    fn area(self: *const Rectangle) f64 {
        return self.width * self.height;
    }

    // 方法：设置尺寸
    fn setSize(self: *Rectangle, w: f64, h: f64) void {
        self.width = w;
        self.height = h;
    }
};

// ============================================================================
// 3. 带默认值的结构体
// ============================================================================
const Person = struct {
    name: []const u8 = "Unknown",
    age: u32 = 0,
    city: []const u8 = "",
};

// ============================================================================
// 4. 结构体中的结构体（嵌套）
// ============================================================================
const Address = struct {
    street: []const u8,
    city: []const u8,
    country: []const u8,
};

const Employee = struct {
    name: []const u8,
    id: u32,
    address: Address,
};

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Structs Demo ===\n\n", .{});

    // ========================================================================
    // 1. 基本结构体使用
    // ========================================================================
    try stdout.print("1. Basic structs:\n", .{});

    const p1 = Point{ .x = 3.0, .y = 4.0 };
    try stdout.print("   Point: x={d:.1}, y={d:.1}\n", .{p1.x, p1.y});

    // 也可以省略字段名（按顺序）
    const p2 = Point{ .x = 1.0, .y = 2.0 };
    try stdout.print("   Point: x={d:.1}, y={d:.1}\n", .{p2.x, p2.y});
    try stdout.print("\n", .{});

    // ========================================================================
    // 2. 可变结构体
    // ========================================================================
    try stdout.print("2. Mutable structs:\n", .{});

    var mutable_point = Point{ .x = 10.0, .y = 20.0 };
    try stdout.print("   Before: x={d:.1}, y={d:.1}\n", .{mutable_point.x, mutable_point.y});

    mutable_point.x = 15.0;
    mutable_point.y = 25.0;
    try stdout.print("   After: x={d:.1}, y={d:.1}\n", .{mutable_point.x, mutable_point.y});
    try stdout.print("\n", .{});

    // ========================================================================
    // 3. 结构体方法
    // ========================================================================
    try stdout.print("3. Struct methods:\n", .{});

    var rect = Rectangle{ .width = 5.0, .height = 3.0 };
    try stdout.print("   Rectangle: {d:.1} x {d:.1}\n", .{rect.width, rect.height});
    try stdout.print("   Area: {d:.1}\n", .{rect.area()});

    rect.setSize(10.0, 6.0);
    try stdout.print("   After resize: {d:.1} x {d:.1}\n", .{rect.width, rect.height});
    try stdout.print("   New area: {d:.1}\n", .{rect.area()});
    try stdout.print("\n", .{});

    // ========================================================================
    // 4. 默认值结构体
    // ========================================================================
    try stdout.print("4. Structs with default values:\n", .{});

    const default_person: Person = .{};
    try stdout.print("   Default: {s}, age {d}\n", .{default_person.name, default_person.age});

    const custom_person: Person = .{
        .name = "Alice",
        .age = 30,
    };
    try stdout.print("   Custom: {s}, age {d}\n", .{custom_person.name, custom_person.age});
    try stdout.print("\n", .{});

    // ========================================================================
    // 5. 嵌套结构体
    // ========================================================================
    try stdout.print("5. Nested structs:\n", .{});

    const emp = Employee{
        .name = "Bob",
        .id = 1001,
        .address = Address{
            .street = "123 Main St",
            .city = "New York",
            .country = "USA",
        },
    };

    try stdout.print("   Employee: {s} (ID: {d})\n", .{emp.name, emp.id});
    try stdout.print("   Address: {s}, {s}, {s}\n", .{
        emp.address.street,
        emp.address.city,
        emp.address.country,
    });
    try stdout.print("\n", .{});

    // ========================================================================
    // 6. 结构体指针
    // ========================================================================
    try stdout.print("6. Struct pointers:\n", .{});

    var point_var = Point{ .x = 7.0, .y = 8.0 };
    const point_ptr: *const Point = &point_var;

    try stdout.print("   Via pointer: x={d:.1}, y={d:.1}\n", .{point_ptr.x, point_ptr.y});

    var mutable_ptr: *Point = &point_var;
    mutable_ptr.x = 77.0;
    try stdout.print("   After modification: x={d:.1}\n", .{point_var.x});
}

// ============================================================================
// 运行方式：
//   zig run 018_structs.zig
// ============================================================================

// ============================================================================
// 关键概念解释：
//
// 1. 结构体定义：
//    const Name = struct {
//        field1: type1,
//        field2: type2,
//    };
//
// 2. 结构体实例化：
//    const instance = StructName{
//        .field1 = value1,
//        .field2 = value2,
//    };
//
// 3. 字段访问：
//    instance.field_name
//
// 4. 结构体方法：
//    fn methodName(self: *const Struct) ReturnType {
//        // 方法体
//    }
//
// 5. 默认值：
//    field: type = default_value
//
// 6. 可变性：
//    - const 实例：字段不可变
//    - var 实例：字段可变
//    - *const self：方法中不能修改字段
//    - *self：方法中可以修改字段
// ============================================================================

// ============================================================================
// 练习建议：
// 1. 创建 Book 结构体，包含标题、作者、年份
// 2. 为 Book 添加方法判断是否是经典著作（50年前）
// 3. 创建 Circle 结构体，添加计算面积和周长的方法
// 4. 创建嵌套结构体表示学生和课程信息
// ============================================================================
