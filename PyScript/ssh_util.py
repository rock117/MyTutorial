import os
import sys
from pathlib import Path
import paramiko
from typing import Optional
import zipfile
from datetime import datetime


def log_print(*args, **kwargs):
    """带时间戳的打印函数"""
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    print(f"[{timestamp}]", *args, **kwargs)

class SSHClient:
    """SSH部署工具类"""
    
    def __init__(self, host: str, port: int = 22, username: str = None, password: str = None, key_file: str = None):
        """
        初始化SSH连接
        
        Args:
            host: 服务器地址
            port: SSH端口，默认22
            username: 用户名
            password: 密码
            key_file: 私钥文件路径
        """
        self.host = host
        self.port = port
        self.username = username
        self.password = password
        self.key_file = key_file
        self.ssh_client = None
        self.sftp_client = None
    
    def connect(self):
        """建立SSH连接"""
        try:
            self.ssh_client = paramiko.SSHClient()
            self.ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            
            if self.key_file:
                private_key = paramiko.RSAKey.from_private_key_file(self.key_file)
                self.ssh_client.connect(
                    hostname=self.host,
                    port=self.port,
                    username=self.username,
                    pkey=private_key
                )
            else:
                self.ssh_client.connect(
                    hostname=self.host,
                    port=self.port,
                    username=self.username,
                    password=self.password
                )
            
            self.sftp_client = self.ssh_client.open_sftp()
            log_print(f"✓ 成功连接到 {self.host}:{self.port}")
        except Exception as e:
            log_print(f"✗ 连接失败: {str(e)}")
        return self   
    
    def upload_file(self, local_path: str, remote_path: str, callback=None):
        """
        上传单个文件
        
        Args:
            local_path: 本地文件路径
            remote_path: 远程文件路径
            callback: 进度回调函数
        """
        try:
            if not os.path.exists(local_path):
                log_print(f"✗ 本地文件不存在: {local_path}")
                return
            
            remote_dir = os.path.dirname(remote_path)
            if remote_dir:
                self._create_remote_dir(remote_dir)
            
            file_size = os.path.getsize(local_path)
            log_print(f"上传文件: {local_path} -> {remote_path} ({self._format_size(file_size)})")
            
            self.sftp_client.put(local_path, remote_path, callback=callback)
            log_print(f"✓ 上传成功: {remote_path}")
        except Exception as e:
            log_print(f"✗ 上传失败: {str(e)}")
    
    def download_file(self, remote_path: str, local_path: str, callback=None):
        """
        下载单个文件
        
        Args:
            remote_path: 远程文件路径
            local_path: 本地文件路径
            callback: 进度回调函数
        """
        try:
            local_dir = os.path.dirname(local_path)
            if local_dir and not os.path.exists(local_dir):
                os.makedirs(local_dir, exist_ok=True)
            
            file_attr = self.sftp_client.stat(remote_path)
            file_size = file_attr.st_size
            log_print(f"下载文件: {remote_path} -> {local_path} ({self._format_size(file_size)})")
            
            self.sftp_client.get(remote_path, local_path, callback=callback)
            log_print(f"✓ 下载成功: {local_path}")
        except Exception as e:
            log_print(f"✗ 下载失败: {str(e)}")
    
    def upload_directory(self, local_dir: str, remote_dir: str):
        """
        上传整个目录
        
        Args:
            local_dir: 本地目录路径
            remote_dir: 远程目录路径
        """
        try:
            if not os.path.exists(local_dir):
                log_print(f"✗ 本地目录不存在: {local_dir}")
                return
            
            log_print(f"上传目录: {local_dir} -> {remote_dir}")
            self._create_remote_dir(remote_dir)
            
            for root, dirs, files in os.walk(local_dir):
                relative_path = os.path.relpath(root, local_dir)
                remote_root = os.path.join(remote_dir, relative_path).replace('\\', '/')
                
                if relative_path != '.':
                    self._create_remote_dir(remote_root)
                
                for file in files:
                    local_file = os.path.join(root, file)
                    remote_file = os.path.join(remote_root, file).replace('\\', '/')
                    self.upload_file(local_file, remote_file)
            
            log_print(f"✓ 目录上传完成: {remote_dir}")
        except Exception as e:
            log_print(f"✗ 目录上传失败: {str(e)}")
    
    def download_directory(self, remote_dir: str, local_dir: str):
        """
        下载整个目录
        
        Args:
            remote_dir: 远程目录路径
            local_dir: 本地目录路径
        """
        try:
            log_print(f"下载目录: {remote_dir} -> {local_dir}")
            os.makedirs(local_dir, exist_ok=True)
            
            self._download_dir_recursive(remote_dir, local_dir)
            
            log_print(f"✓ 目录下载完成: {local_dir}")
        except Exception as e:
            log_print(f"✗ 目录下载失败: {str(e)}")
    
    def _download_dir_recursive(self, remote_dir: str, local_dir: str):
        """递归下载目录"""
        try:
            items = self.sftp_client.listdir_attr(remote_dir)
            for item in items:
                remote_path = os.path.join(remote_dir, item.filename).replace('\\', '/')
                local_path = os.path.join(local_dir, item.filename)
                
                if self._is_directory(item):
                    os.makedirs(local_path, exist_ok=True)
                    self._download_dir_recursive(remote_path, local_path)
                else:
                    self.download_file(remote_path, local_path)
        except Exception as e:
            log_print(f"✗ 递归下载失败: {str(e)}")
    
    def _create_remote_dir(self, remote_dir: str):
        """创建远程目录"""
        try:
            remote_dir = remote_dir.replace('\\', '/')
            dirs = []
            while remote_dir and remote_dir != '/':
                dirs.append(remote_dir)
                remote_dir = os.path.dirname(remote_dir)
            
            for dir_path in reversed(dirs):
                try:
                    self.sftp_client.stat(dir_path)
                except FileNotFoundError:
                    self.sftp_client.mkdir(dir_path)
        except Exception as e:
            pass
    
    def _is_directory(self, file_attr):
        """判断是否为目录"""
        import stat
        return stat.S_ISDIR(file_attr.st_mode)
    
    def _format_size(self, size: int) -> str:
        """格式化文件大小"""
        for unit in ['B', 'KB', 'MB', 'GB', 'TB']:
            if size < 1024.0:
                return f"{size:.2f} {unit}"
            size /= 1024.0
        return f"{size:.2f} PB"
    
    def execute_command(self, command: str):
        """
        执行远程命令
        
        Args:
            command: 要执行的命令
        """
        try:
            log_print(f"执行命令: {command}")
            stdin, stdout, stderr = self.ssh_client.exec_command(command)
            exit_code = stdout.channel.recv_exit_status()
            stdout_text = stdout.read().decode('utf-8')
            stderr_text = stderr.read().decode('utf-8')
            
            if stdout_text:
                log_print(f"输出:\n{stdout_text}")
            if stderr_text:
                log_print(f"错误:\n{stderr_text}")
            log_print(f"退出码: {exit_code}")
        except Exception as e:
            log_print(f"✗ 命令执行失败: {str(e)}")
    
    def execute_commands_batch(self, commands: list):
        """
        批量执行多个命令，合并成一个命令发送，任何一个命令失败则停止执行
        
        Args:
            commands: 要执行的命令列表
        """
        if not commands:
            log_print("✗ 命令列表为空")
            return
        
        # 使用 && 连接命令，确保前一个命令成功才执行下一个
        combined_command = " && ".join(commands)
        
        try:
            log_print(f"批量执行命令 ({len(commands)} 个):")
            for i, cmd in enumerate(commands, 1):
                log_print(f"  {i}. {cmd}")
            log_print(f"合并后的命令: {combined_command}")
            
            stdin, stdout, stderr = self.ssh_client.exec_command(combined_command)
            exit_code = stdout.channel.recv_exit_status()
            stdout_text = stdout.read().decode('utf-8')
            stderr_text = stderr.read().decode('utf-8')
            
            if stdout_text:
                log_print(f"输出:\n{stdout_text}")
            if stderr_text:
                log_print(f"错误:\n{stderr_text}")
            log_print(f"退出码: {exit_code}")
            
            if exit_code == 0:
                log_print("✓ 所有命令执行成功")
            else:
                log_print("✗ 命令执行失败，后续命令已停止")
                
        except Exception as e:
            log_print(f"✗ 批量命令执行失败: {str(e)}")
    
    def close(self):
        """关闭SSH连接"""
        try:
            if self.sftp_client:
                self.sftp_client.close()
            if self.ssh_client:
                self.ssh_client.close()
            log_print("✓ SSH连接已关闭")
        except Exception as e:
            log_print(f"✗ 关闭连接失败: {str(e)}")
