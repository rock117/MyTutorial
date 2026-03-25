#!/bin/bash
# 自动修复常见 Zig 编译错误

echo "Auto-fixing common Zig compilation errors..."
echo ""

# 列出所有需要修复的文件
FAILED_FILES=(
"002_variables_and_constants.zig"
"003_basic_data_types.zig"
"004_numeric_operations.zig"
"005_boolean_and_logic.zig"
"006_characters_and_strings.zig"
"013_function_advanced.zig"
"014_error_handling.zig"
"015_defer_statement.zig"
"016_pointers.zig"
"017_optionals.zig"
"019_enums.zig"
"020_unions.zig"
"021_slices.zig"
"027_arraylist.zig"
"028_hashmap.zig"
"034_anytype.zig"
"039_type_coercion.zig"
"042_multilevel_pointers.zig"
"044_c_interop.zig"
"045_extern_functions.zig"
"049_tuples.zig"
"053_errdefer.zig"
"055_defer_advanced.zig"
"056_compile_error.zig"
"057_compile_log.zig"
"061_atomic.zig"
"062_bitcast.zig"
"063_ptrcast.zig"
"064_intcast.zig"
"065_truncate.zig"
"078_filesystem.zig"
"079_paths.zig"
"083_dependency_management.zig"
"087_performance_testing.zig"
"090_json_parsing.zig"
)

echo "Files to fix: ${#FAILED_FILES[@]}"
echo "Starting automatic fixes..."
echo ""

# 这里我们逐个检查每个文件的具体错误
for file in "${FAILED_FILES[@]}"; do
    echo "Checking $file..."
    /c/rock/dev-tool/zig/zig.exe build-exe "$file" -femit-bin=/dev/null 2>&1 | head -3
    echo ""
done
