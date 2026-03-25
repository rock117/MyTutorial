#!/bin/bash
# 批量测试所有 Zig 教程文件

ZIG="/c/rock/dev-tool/zig/zig.exe"
TOTAL=0
PASSED=0
FAILED=0
FAILED_FILES=()

echo "========================================="
echo "Testing All Zig Tutorials (001-100)"
echo "========================================="
echo ""

# 测试所有 .zig 文件
for file in *.zig; do
    # 只测试带数字前缀的教程文件
    if [[ $file =~ ^[0-9]{3}_.+\.zig$ ]]; then
        TOTAL=$((TOTAL + 1))
        echo -n "[$TOTAL] Testing $file ... "

        # 尝试编译（不运行，只检查语法）
        if $ZIG build-exe $file -femit-bin=/dev/null 2>/dev/null; then
            echo "✓ PASSED"
            PASSED=$((PASSED + 1))
        else
            echo "✗ FAILED"
            FAILED=$((FAILED + 1))
            FAILED_FILES+=("$file")
        fi
    fi
done

echo ""
echo "========================================="
echo "Test Summary"
echo "========================================="
echo "Total:  $TOTAL"
echo "Passed: $PASSED"
echo "Failed: $FAILED"

if [ $FAILED -gt 0 ]; then
    echo ""
    echo "Failed files:"
    for file in "${FAILED_FILES[@]}"; do
        echo "  - $file"
    done
fi

echo "========================================="

exit $FAILED
