// 031_error_handling_advanced.zig - 错误处理详解
const std = @import("std");

const ParseError = error{
    InvalidCharacter,
    Overflow,
};

fn parseDigit(char: u8) ParseError!u8 {
    if (char < '0' or char > '9') {
        return ParseError.InvalidCharacter;
    }
    return char - '0';
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const result = parseDigit('5') catch 0;
    try stdout.print("Parsed digit: {d}\n", .{result});
}
