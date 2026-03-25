# Zig 语言学习指南

## 当前进度：第一个程序 ✅

### main.zig 代码解析

```zig
// 我的第一个 Zig 程序
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hello, World! 你好，世界！\n", .{});
    try stdout.print("欢迎来到 Zig 的世界！\n", .{});
    try stdout.print("这是一个系统级编程语言。\n", .{});
}
```

### 逐行解释：

1. **`// 注释`** - 单行注释，用双斜杠

2. **`const std = @import("std");`** - 导入标准库
   - `@import` 是编译时内置函数
   - `"std"` 是标准库名称
   - `const` 声明常量

3. **`pub fn main() !void`** - 主函数定义
   - `pub` - 公开函数（可被外部访问）
   - `fn` - 函数定义关键字
   - `main` - 函数名（程序入口点）
   - `!void` - 返回类型（可能返回错误）

4. **`const stdout = std.io.getStdOut().writer();`** - 获取标准输出
   - 获取标准输出流的写入器

5. **`try stdout.print("...", .{});`** - 打印输出
   - `try` - 处理可能的错误
   - `print` - 格式化打印函数
   - `.{}` - 空的格式化参数列表

### Zig 基础概念

#### 1. 变量声明
```zig
const constant: i32 = 42;     // 常量，不可变
var variable: i32 = 10;       // 变量，可变
```

#### 2. 基本数据类型
- **整数**：`i8`, `i16`, `i32`, `i64`, `u8`, `u16`, `u32`, `u64`
- **浮点**：`f16`, `f32`, `f64`, `f128`
- **布尔**：`bool` (true/false)
- **字符**：`u8` (ASCII), `u21` (Unicode)

#### 3. 函数定义
```zig
fn add(a: i32, b: i32) i32 {
    return a + b;
}
```

#### 4. 错误处理
```zig
// 可能返回错误的函数
pub fn main() !void {
    // try 会处理错误
    try mightFail();
}
```

### 下一步学习

1. ✅ Hello World 程序
2. ⏳ 变量和数据类型
3. ⏳ 控制流（if, while, for）
4. ⏳ 函数深入
5. ⏳ 数组和切片
6. ⏳ 结构体和枚举

### 常用命令

```bash
# 运行程序
zig run main.zig

# 编译程序
zig build-exe main.zig

# 检查代码
zig fmt main.zig

# 查看帮助
zig --help
```

### 学习资源

- 官方文档：https://ziglang.org/documentation/master/
- Zig 学习指南：https://ziglearn.org/
- 在线编译器：https://zig.guide/

---

**准备开始下一个学习主题！选择以下任一选项：**

- 输入 "变量" - 学习变量和常量
- 输入 "控制流" - 学习 if、while、for
- 输入 "函数" - 深入学习函数
- 输入 "练习" - 创建练习项目
