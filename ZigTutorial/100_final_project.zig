// 100_final_project.zig - 综合实战项目
// 一个简单的 TODO 应用

const std = @import("std");

const Todo = struct {
    id: u32,
    title: []const u8,
    completed: bool,
};

const TodoApp = struct {
    todos: std.ArrayList(Todo),
    next_id: u32,

    fn init(allocator: std.mem.Allocator) TodoApp {
        return .{
            .todos = std.ArrayList(Todo).init(allocator),
            .next_id = 1,
        };
    }

    fn deinit(self: *TodoApp) void {
        self.todos.deinit();
    }

    fn add(self: *TodoApp, title: []const u8) !void {
        try self.todos.append(.{
            .id = self.next_id,
            .title = title,
            .completed = false,
        });
        self.next_id += 1;
    }

    fn complete(self: *TodoApp, id: u32) void {
        for (self.todos.items) |*todo| {
            if (todo.id == id) {
                todo.completed = true;
            }
        }
    }

    fn list(self: *const TodoApp) void {
        std.debug.print("\n=== TODO List ===\n", .{});
        for (self.todos.items) |todo| {
            const status = if (todo.completed) "[x]" else "[ ]";
            std.debug.print("  {s} {d}: {s}\n", .{status, todo.id, todo.title});
        }
        std.debug.print("==================\n\n", .{});
    }
};

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== TODO Application ===\n\n", .{});

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var app = TodoApp.init(allocator);
    defer app.deinit();

    try app.add("Learn Zig");
    try app.add("Build projects");
    try app.add("Master systems programming");

    app.list();

    app.complete(1);
    try stdout.print("Completed TODO #1\n", .{});

    app.list();

    try stdout.print("TODO App demo completed!\n", .{});
}
