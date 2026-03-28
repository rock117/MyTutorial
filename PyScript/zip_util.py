import os
import zipfile
from pathlib import Path

def zip_dir_7z(source_dir, output_zip):
    if os.path.exists(output_zip):
        os.remove(output_zip)
    cmd = f'7z a -tzip "{output_zip}" "{source_dir}" '
    return os.system(cmd)

def zip_dir(source_dir, output_zip):
    """
    Compress a directory into a ZIP file using Python's built-in zipfile module

    Args:
        source_dir: Source directory path to compress
        output_zip: Output ZIP file path

    Returns:
        True if successful, False otherwise
    """
    source_path = Path(source_dir).resolve()

    if not source_path.exists():
        raise FileNotFoundError(f"Source directory does not exist: {source_dir}")

    if not source_path.is_dir():
        raise NotADirectoryError(f"Source is not a directory: {source_dir}")

    # Remove existing zip file if it exists
    if os.path.exists(output_zip):
        os.remove(output_zip)

    try:
        with zipfile.ZipFile(output_zip, 'w', zipfile.ZIP_DEFLATED) as zipf:
            for root, dirs, files in os.walk(source_path):
                for file in files:
                    file_path = Path(root) / file
                    arcname = file_path.relative_to(source_path.parent)
                    zipf.write(file_path, arcname)
        return True
    except Exception as e:
        print(f"Error creating ZIP file: {e}")
        return False