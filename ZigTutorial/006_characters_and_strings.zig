// ============================================================================
// 006_characters_and_strings.zig
// ============================================================================
// 教程主题：字符与字符串
// 难度等级：⭐ (新手)
// 涵盖知识点：
//   - 字符类型（ASCII 和 Unicode）
//   - 字符串字面量
//   - 字符串切片
//   - 常用转义字符
// ============================================================================

const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // ========================================================================
    // 1. ASCII 字符
    // ========================================================================
    // ASCII 字符使用 u8 类型（0-127）

    const letter_a: u8 = 'A';           // 大写字母
    const letter_b: u8 = 'b';           // 小写字母
    const digit_zero: u8 = '0';         // 数字
    const space: u8 = ' ';              // 空格
    const at_sign: u8 = '@';            // 特殊字符

    try stdout.print("ASCII 字符示例：\n", .{});
    try stdout.print("  'A' = {c} (数值: {d})\n", .{letter_a, letter_a});
    try stdout.print("  'b' = {c} (数值: {d})\n", .{letter_b, letter_b});
    try stdout.print("  '0' = {c} (数值: {d})\n", .{digit_zero, digit_zero});
    try stdout.print("  ' ' = 空格 (数值: {d})\n", .{space});
    try stdout.print("  '@' = {c} (数值: {d})\n", .{at_sign, at_sign});
    try stdout.print("\n", .{});

    // ========================================================================
    // 2. Unicode 字符
    // ========================================================================
    // Unicode 字符使用 u21 类型（可以表示所有 Unicode 码点）

    const chinese_char: u21 = '中';     // 中文字符
    const emoji: u21 = '😊';             // Emoji
    const greek: u21 = 'α';              // 希腊字母
    const math_symbol: u21 = '√';       // 数学符号

    try stdout.print("Unicode 字符示例：\n", .{});
    try stdout.print("  '中' = U+{X:0>4}\n", .{chinese_char});
    try stdout.print("  '😊' = U+{X:0>4}\n", .{emoji});
    try stdout.print("  'α' = U+{X:0>4}\n", .{greek});
    try stdout.print("  '√' = U+{X:0>4}\n", .{math_symbol});
    try stdout.print("\n", .{});

    // ========================================================================
    // 3. 字符串字面量
    // ========================================================================
    // Zig 中的字符串实际上是字节数组（[]const u8）

    const greeting: []const u8 = "Hello, World!";
    const chinese: []const u8 = "你好，世界！";
    const multiline: []const u8 =
        \\这是一行
        \\这是第二行
        \\这是第三行
    ;

    try stdout.print("字符串字面量示例：\n", .{});
    try stdout.print("  英文: {s}\n", .{greeting});
    try stdout.print("  中文: {s}\n", .{chinese});
    try stdout.print("  多行:\n{s}\n", .{multiline});
    try stdout.print("\n", .{});

    // ========================================================================
    // 4. 字符串长度
    // ========================================================================

    const short_str: []const u8 = "Hello";
    const long_str: []const u8 = "你好世界";

    try stdout.print("字符串长度示例：\n", .{});
    try stdout.print("  \"Hello\" 字节数: {d}\n", .{short_str.len});
    try stdout.print("  \"你好世界\" 字节数: {d}\n", .{long_str.len});
    try stdout.print("  (注意：中文字符占多个字节)\n", .{});
    try stdout.print("\n", .{});

    // ========================================================================
    // 5. 转义字符 (Escape Sequences)
    // ========================================================================

    const with_newline: []const u8 = "第一行\n第二行";
    const with_tab: []const u8 = "列1\t列2\t列3";
    const with_quote: []const u8 = "他说：\"你好！\"";
    const with_backslash: []const u8 = "路径: C:\\Users\\Name";
    const with_carriage_return: []const u8 = "回车符\r\n";
    const unicode_escape: []const u8 = "Unicode: \u{4E2D}\u{6587}";  // 中文

    try stdout.print("转义字符示例：\n", .{});
    try stdout.print("  换行符:\n{s}\n", .{with_newline});
    try stdout.print("  制表符: {s}\n", .{with_tab});
    try stdout.print("  引号: {s}\n", .{with_quote});
    try stdout.print("  反斜杠: {s}\n", .{with_backslash});
    try stdout.print("  回车符: {s}\n", .{with_carriage_return});
    try stdout.print("  Unicode 转义: {s}\n", .{unicode_escape});
    try stdout.print("\n", .{});

    // ========================================================================
    // 6. 字符串切片
    // ========================================================================
    // 切片获取字符串的一部分 [start..end]

    const text: []const u8 = "Hello, Zig!";

    try stdout.print("字符串切片示例（原字符串: \"{s}\"）：\n", .{text});
    try stdout.print("  [0..5]   = \"{s}\"\n", .{text[0..5]});     // "Hello"
    try stdout.print("  [7..11]  = \"{s}\"\n", .{text[7..11]});    // "Zig"
    try stdout.print("  [0..0]   = \"{s}\"\n", .{text[0..0]});     // ""
    try stdout.print("  [0..1]   = \"{s}\"\n", .{text[0..1]});     // "H"
    try stdout.print("\n", .{});

    // ========================================================================
    // 7. 字符数组 vs 字符串切片
    // ========================================================================

    // 字符数组：编译时已知长度
    const array: [5]u8 = [_]u8{ 'H', 'e', 'l', 'l', 'o' };

    // 字符串切片：运行时长度
    const slice: []const u8 = "Hello";

    try stdout.print("字符数组 vs 切片：\n", .{});
    try stdout.print("  数组类型: [5]u8, 长度固定\n", .{});
    try stdout.print("  切片类型: []const u8, 长度可变\n", .{});
    try stdout.print("  数组内容: {s}\n", .{array});
    try stdout.print("  切片内容: {s}\n", .{slice});
    try stdout.print("\n", .{});

    // ========================================================================
    // 8. 字符遍历
    // ========================================================================

    const iterate_str: []const u8 = "ABC";

    try stdout.print("字符串遍历（\"{s}\"）：\n", .{iterate_str});
    for (iterate_str, 0..) |char, index| {
        try stdout.print("  索引 {d}: {c} (数值: {d})\n", .{index, char, char});
    }
}

// ============================================================================
// 运行方式：
//   zig run 006_characters_and_strings.zig
// ============================================================================

// ============================================================================
// 关键概念解释：
//
// 1. 字符类型：
//    - u8：表示 ASCII 字符（0-255）
//    - u21：表示 Unicode 字符（0-0x10FFFF）
//    - 字符实际上是整数，只是打印时显示为字符
//
// 2. 字符串类型：
//    - Zig 中字符串是 []const u8（字节切片）
//    - UTF-8 编码，中文等多字节字符占用多个字节
//    - .len 返回字节数，不是字符数
//
// 3. 转义字符：
//    - \n：换行
//    - \t：制表符
//    - \r：回车
//    - \\：反斜杠
//    - \"：双引号
//    - \'：单引号
//    - \xHH：十六进制字符
//    - \u{XXXX}：Unicode 字符
//
// 4. 切片语法：
//    - [start..end]：从 start 到 end（不包含 end）
//    - [start..]：从 start 到末尾
//    - 不会检查边界，超出会导致未定义行为
// ============================================================================

// ============================================================================
// 常见问题：
//
// Q: 如何获取字符串的字符数而不是字节数？
// A: 需要 UTF-8 解码。使用 std.unicode 或 std.mem.splitWithScalar
//
// Q: 如何修改字符串中的字符？
// A: 不能直接修改。字符串是 []const u8（const 表示只读）。
//    需要创建新的可变字节数组。
//
// Q: 如何拼接字符串？
// A: 使用 std.fmt.allocPrint 或 std.ArrayList(u8)
// ============================================================================
// ============================================================================
// 练习建议：
// 1. 创建包含各种 Unicode 字符的字符串
// 2. 练习使用切片提取字符串的不同部分
// 3. 编写函数统计字符串中特定字符的出现次数
// 4. 使用转义字符创建格式化输出
// ============================================================================
