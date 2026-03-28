#!/usr/bin/env python3
"""
Directory Comparison Tool
Compares two directories and lists:
1. Files with different content
2. Files that exist in only one of the two directories
"""

import difflib
import filecmp
import os
import sys
from pathlib import Path
from typing import Dict, List, Set, Tuple


class DirectoryComparer:
    """Directory Comparator"""

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
        Initialize the comparator

        Args:
            dir1: Path to the first directory
            dir2: Path to the second directory
            extensions: List of file extensions to compare, e.g. ['.cs', '.xaml'], None means all files
            exclude_dirs: List of directory names to exclude, e.g. ['obj', 'bin', 'debug'], None means don't exclude
            ignore_case: Whether to ignore case, default is True
            show_diff_details: Whether to show file content difference details, default is False
        """
        self.dir1 = Path(dir1).resolve()
        self.dir2 = Path(dir2).resolve()
        self.extensions = extensions
        self.exclude_dirs = exclude_dirs
        self.ignore_case = ignore_case
        self.show_diff_details = show_diff_details

        if not self.dir1.exists():
            raise FileNotFoundError(f"Directory does not exist: {self.dir1}")
        if not self.dir2.exists():
            raise FileNotFoundError(f"Directory does not exist: {self.dir2}")
        if not self.dir1.is_dir():
            raise NotADirectoryError(f"Not a directory: {self.dir1}")
        if not self.dir2.is_dir():
            raise NotADirectoryError(f"Not a directory: {self.dir2}")

    def compare(self) -> Dict[str, List[str]]:
        """
        Compare two directories

        Returns:
            Dictionary containing comparison results:
            - 'different': Files with different content
            - 'only_in_dir1': Files only in directory 1
            - 'only_in_dir2': Files only in directory 2
            - 'common': Same files
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
                print(f"⚠️  Cannot compare file {rel_path}: {e}")
                result["different"].append(rel_path)  # Mark files that cannot be compared as different

        result["different"].sort()
        result["common"].sort()

        return result

    def _get_all_files(self, directory: Path) -> Set[str]:
        """
        Get relative paths of all files in a directory

        Args:
            directory: Directory path

        Returns:
            Set of file relative paths
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
        Print detailed differences between two files

        Args:
            rel_path: Relative path of the file
            context_lines: Number of context lines to display
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
                        print(f"   📄 Binary file content differs")
                    else:
                        print(f"   📄 Binary file content is the same")
                return
            except Exception as e:
                print(f"   ⚠️  Cannot read binary file: {e}")
                return
        except Exception as e:
            print(f"   ⚠️  Cannot read file: {e}")
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
            print(f"   ℹ️  Files may only have encoding or binary differences")
            return

        # 显示差异（限制输出行数，避免过长）
        max_lines = 50
        for i, line in enumerate(diff_lines):
            if i >= max_lines:
                print(f"   ... (diff too long, some content omitted)")
                break
            # Add color indicators to diff lines
            if line.startswith("---") or line.startswith("+++"):
                print(f"   \033[90m{line}\033[0m")  # Gray
            elif line.startswith("@@"):
                print(f"   \033[36m{line}\033[0m")  # Cyan
            elif line.startswith("-"):
                print(f"   \033[31m{line}\033[0m")  # Red - deleted lines
            elif line.startswith("+"):
                print(f"   \033[32m{line}\033[0m")  # Green - added lines
            else:
                print(f"   {line}")

    def print_report(self):
        """Print comparison report"""
        print(f"\n{'=' * 60}")
        print(f"Directory Comparison Report")
        print(f"{'=' * 60}")
        print(f"Directory 1: {self.dir1}")
        print(f"Directory 2: {self.dir2}")
        if self.extensions:
            print(f"File types: {', '.join(self.extensions)}")
        else:
            print(f"File types: All files")
        if self.exclude_dirs:
            print(f"Excluded directories: {', '.join(self.exclude_dirs)}")
        print(f"Case sensitive: {'No' if self.ignore_case else 'Yes'}")
        print(f"Show diff details: {'Yes' if self.show_diff_details else 'No'}")
        print(f"{'=' * 60}\n")

        result = self.compare()

        # 内容不同的文件（简要列表）
        # 略过，在后面合并显示

        print(f"{'=' * 60}")
        print(f"Summary:")
        print(f"  - Only in directory 1: {len(result['only_in_dir1'])} files")
        print(f"  - Only in directory 2: {len(result['only_in_dir2'])} files")
        print(f"  - Different content:   {len(result['different'])} files")
        print(f"  - Same content:        {len(result['common'])} files")
        print(f"{'=' * 60}\n")

        # Detailed list: files only in directory 1
        if result["only_in_dir1"]:
            print(f"{'=' * 60}")
            print(f"Files only in directory 1:")
            print(f"{'=' * 60}")
            for file in result["only_in_dir1"]:
                print(f"   - {file}")
            print()

        # Detailed list: files only in directory 2
        if result["only_in_dir2"]:
            print(f"{'=' * 60}")
            print(f"Files only in directory 2:")
            print(f"{'=' * 60}")
            for file in result["only_in_dir2"]:
                print(f"   - {file}")
            print()

        # Detailed difference display (including file list)
        if result["different"]:
            print(f"{'=' * 60}")
            print(f"Files with different content ({len(result['different'])} files):")
            print(f"{'=' * 60}")
            # First part: file list
            for file in result["different"]:
                print(f"   - {file}")
            print()
            # Second part: detailed differences (optional)
            if self.show_diff_details:
                for idx, file in enumerate(result["different"], 1):
                    width = len(str(len(result["different"])))
                    print(f"\n📄 {idx:0{width}d} - {file}")
                    print(f"{'─' * 56}")
                    self._print_file_diff(file)
                print(f"{'=' * 60}\n")


dir1 = r"C:\rock\code\CnTobaco\GxTbMixedDataSystemV3\experiment"
dir2 = r"C:\rock\code\CnTobaco\GxTbMixedDataSystemV3\VOCLab"

# Only compare .cs and .xaml files, exclude obj, bin, debug directories
comparer = DirectoryComparer(
    dir1, dir2, extensions=[".cs", ".xaml"], exclude_dirs=["obj", "bin", "debug"], ignore_case=False, show_diff_details=False
)
comparer.print_report()
