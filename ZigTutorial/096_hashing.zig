// 096_hashing.zig - 哈希函数
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const data = "Hello, Zig!";

    // 使用 std.hash朋
    const hash = std.hash.Wyhash.hash(0, data);

    try stdout.print("Data: {s}\n", .{data});
    try stdout.print("Hash: 0x{X}\n", .{hash});
}
