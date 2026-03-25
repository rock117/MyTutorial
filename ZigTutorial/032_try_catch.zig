// 032_try_catch.zig - try 和 catch
const std = @import("std");

fn mightFail(should_fail: bool) !i32 {
    if (should_fail) {
        return error.Failure;
    }
    return 42;
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // 使用 try
    const result1 = try mightFail(false);
    try stdout.print("Success: {d}\n", .{result1});

    // 使用 catch
    const result2 = mightFail(true) catch |err| blk: {
        try stdout.print("Caught error: {}\n", .{err});
        break :blk 0;
    };
    try stdout.print("Result: {d}\n", .{result2});
}
