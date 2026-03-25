#!/usr/bin/env python3
"""
目录比较工具
比较两个目录，列出：
1. 文件内容不同的文件
2. 两个目录彼此没有的文件
"""

import difflib
import filecmp
import os
import sys
from pathlib import Path
from typing import Dict, List, Set, Tuple


class DirectoryComparer:
    """目录比较器"""

    def __init__(
        self,
        dir1: str,
        dir2: str,
        extensions: List[str] = None,
        exclude_dirs: List[str] = None,
        ignore_case: bool = True,
        show_diff_details: bool = False,
    ):
        """
        初始化比较器

        Args:
            dir1: 第一个目录路径
            dir2: 第二个目录路径
            extensions: 要比较的文件扩展名列表，如 ['.cs', '.xaml']，None 表示所有文件
            exclude_dirs: 要排除的目录名列表，如 ['obj', 'bin', 'debug']，None 表示不排除
            ignore_case: 是否忽略大小写，默认为True
            show_diff_details: 是否显示文件内容差异详情，默认为False
        """
        self.dir1 = Path(dir1).resolve()
        self.dir2 = Path(dir2).resolve()
        self.extensions = extensions
        self.exclude_dirs = exclude_dirs
        self.ignore_case = ignore_case
        self.show_diff_details = show_diff_details

        if not self.dir1.exists():
            raise FileNotFoundError(f"目录不存在: {self.dir1}")
        if not self.dir2.exists():
            raise FileNotFoundError(f"目录不存在: {self.dir2}")
        if not self.dir1.is_dir():
            raise NotADirectoryError(f"不是目录: {self.dir1}")
        if not self.dir2.is_dir():
            raise NotADirectoryError(f"不是目录: {self.dir2}")

    def compare(self) -> Dict[str, List[str]]:
        """
        比较两个目录

        Returns:
            包含比较结果的字典:
            - 'different': 文件内容不同的文件
            - 'only_in_dir1': 只在目录1中的文件
            - 'only_in_dir2': 只在目录2中的文件
            - 'common': 相同的文件
        """
        result = {"different": [], "only_in_dir1": [], "only_in_dir2": [], "common": []}

        # 获取两个目录的所有文件（相对路径）
        files_dir1 = self._get_all_files(self.dir1)
        files_dir2 = self._get_all_files(self.dir2)

        # 找出独有文件和共同文件
        only_dir1 = files_dir1 - files_dir2
        only_dir2 = files_dir2 - files_dir1
        common = files_dir1 & files_dir2

        result["only_in_dir1"] = sorted(only_dir1)
        result["only_in_dir2"] = sorted(only_dir2)

        # 比较共同文件的内容
        for rel_path in common:
            file1 = self.dir1 / rel_path
            file2 = self.dir2 / rel_path

            try:
                if not filecmp.cmp(file1, file2, shallow=False):
                    result["different"].append(rel_path)
                else:
                    result["common"].append(rel_path)
            except (OSError, PermissionError) as e:
                print(f"⚠️  无法比较文件 {rel_path}: {e}")
                result["different"].append(rel_path)  # 将无法比较的文件标记为不同

        result["different"].sort()
        result["common"].sort()

        return result

    def _get_all_files(self, directory: Path) -> Set[str]:
        """
        获取目录下所有文件的相对路径

        Args:
            directory: 目录路径

        Returns:
            文件相对路径的集合
        """
        files = set()
        for root, dirs, filenames in os.walk(directory):
            root_path = Path(root)
            # 排除指定目录（修改 dirs 列表，使 os.walk 不再遍历这些目录）
            if self.exclude_dirs:
                if self.ignore_case:
                    exclude_dirs_lower = [x.lower() for x in self.exclude_dirs]
                    dirs[:] = [d for d in dirs if d.lower() not in exclude_dirs_lower]
                else:
                    dirs[:] = [d for d in dirs if d not in self.exclude_dirs]

            for filename in filenames:
                file_path = root_path / filename
                # 如果指定了扩展名，只收集匹配的文件
                if self.extensions is None or (
                    file_path.suffix.lower() in [x.lower() for x in self.extensions]
                    if self.ignore_case
                    else file_path.suffix in self.extensions
                ):
                    try:
                        rel_path = file_path.relative_to(directory)
                        files.add(str(rel_path))
                    except ValueError:
                        # 处理符号链接或其他特殊情况
                        continue
        return files

    def _print_file_diff(self, rel_path: str, context_lines: int = 3):
        """
        打印两个文件的详细差异

        Args:
            rel_path: 文件的相对路径
            context_lines: 显示的上下文行数
        """
        file1 = self.dir1 / rel_path
        file2 = self.dir2 / rel_path

        try:
            # 尝试以文本模式读取
            with open(file1, "r", encoding="utf-8", errors="replace") as f:
                lines1 = f.readlines()
            with open(file2, "r", encoding="utf-8", errors="replace") as f:
                lines2 = f.readlines()
        except UnicodeDecodeError:
            # 如果是二进制文件，进行二进制比较
            try:
                with open(file1, "rb") as f1, open(file2, "rb") as f2:
                    if f1.read() != f2.read():
                        print(f"   📄 二进制文件内容不同")
                    else:
                        print(f"   📄 二进制文件内容相同")
                return
            except Exception as e:
                print(f"   ⚠️  无法读取二进制文件: {e}")
                return
        except Exception as e:
            print(f"   ⚠️  无法读取文件: {e}")
            return

        # 使用 unified_diff 显示差异
        diff = difflib.unified_diff(
            lines1,
            lines2,
            fromfile=str(self.dir1 / rel_path),
            tofile=str(self.dir2 / rel_path),
            lineterm="",
            n=context_lines,
        )

        diff_lines = list(diff)

        if not diff_lines:
            print(f"   ℹ️  文件可能仅有编码差异或二进制差异")
            return

        # 显示差异（限制输出行数，避免过长）
        max_lines = 50
        for i, line in enumerate(diff_lines):
            if i >= max_lines:
                print(f"   ... (差异过长，已省略部分内容)")
                break
            # 为差异行添加颜色标识
            if line.startswith("---") or line.startswith("+++"):
                print(f"   \033[90m{line}\033[0m")  # 灰色
            elif line.startswith("@@"):
                print(f"   \033[36m{line}\033[0m")  # 青色
            elif line.startswith("-"):
                print(f"   \033[31m{line}\033[0m")  # 红色 - 删除的行
            elif line.startswith("+"):
                print(f"   \033[32m{line}\033[0m")  # 绿色 - 添加的行
            else:
                print(f"   {line}")

    def print_report(self):
        """打印比较报告"""
        print(f"\n{'=' * 60}")
        print(f"目录比较报告")
        print(f"{'=' * 60}")
        print(f"目录 1: {self.dir1}")
        print(f"目录 2: {self.dir2}")
        if self.extensions:
            print(f"文件类型: {', '.join(self.extensions)}")
        else:
            print(f"文件类型: 所有文件")
        if self.exclude_dirs:
            print(f"排除目录: {', '.join(self.exclude_dirs)}")
        print(f"大小写敏感: {'否' if self.ignore_case else '是'}")
        print(f"显示差异详情: {'是' if self.show_diff_details else '否'}")
        print(f"{'=' * 60}\n")

        result = self.compare()

        # 内容不同的文件（简要列表）
        # 略过，在后面合并显示

        print(f"{'=' * 60}")
        print(f"统计汇总:")
        print(f"  - 只在目录1中: {len(result['only_in_dir1'])} 个文件")
        print(f"  - 只在目录2中: {len(result['only_in_dir2'])} 个文件")
        print(f"  - 内容不同:   {len(result['different'])} 个文件")
        print(f"  - 内容相同:   {len(result['common'])} 个文件")
        print(f"{'=' * 60}\n")

        # 详细列表：只在目录1中的文件
        if result["only_in_dir1"]:
            print(f"{'=' * 60}")
            print(f"只在目录 1 中的文件列表:")
            print(f"{'=' * 60}")
            for file in result["only_in_dir1"]:
                print(f"   - {file}")
            print()

        # 详细列表：只在目录2中的文件
        if result["only_in_dir2"]:
            print(f"{'=' * 60}")
            print(f"只在目录 2 中的文件列表:")
            print(f"{'=' * 60}")
            for file in result["only_in_dir2"]:
                print(f"   - {file}")
            print()

        # 详细差异显示（包含文件列表）
        if result["different"]:
            print(f"{'=' * 60}")
            print(f"内容不同的文件 ({len(result['different'])} 个):")
            print(f"{'=' * 60}")
            # 上半部分：文件列表
            for file in result["different"]:
                print(f"   - {file}")
            print()
            # 下半部分：详细差异（可选）
            if self.show_diff_details:
                for idx, file in enumerate(result["different"], 1):
                    width = len(str(len(result["different"])))
                    print(f"\n📄 {idx:0{width}d} - {file}")
                    print(f"{'─' * 56}")
                    self._print_file_diff(file)
                print(f"{'=' * 60}\n")


dir1 = r"C:\rock\coding\code\GxUniversity\zhong-yan\中烟源码\voc\2024-05-28\experiment - 气\experiment"
dir2 = r"C:\rock\coding\code\GxUniversity\zhong-yan\GxTbMixedDataSystemV3\VOCLab"

# 只比较 .cs 和 .xaml 文件，排除 obj, bin, debug 目录
comparer = DirectoryComparer(
    dir1, dir2, extensions=[".cs", ".xaml"], exclude_dirs=["obj", "bin", "debug"], ignore_case=False, show_diff_details=False
)
comparer.print_report()
