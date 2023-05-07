#!/bin/bash

# 定义源代码仓库和目标目录
source_repo=https://github.com/ei0ch/Self-use.git
dest_dir="$HOME/.aria2"

# 删除之前的配置文件
rm -rf "$dest_dir"
rm -f "$HOME/Library/LaunchAgents/aria2.plist"

# 克隆代码仓库并复制文件到目标目录
git clone "$source_repo" "$dest_dir"
cp -f "$dest_dir/Self-use software/Aria2/"* "$dest_dir"
rm -rf "$dest_dir/Self-use software"

# 移动 plist 文件到 LaunchAgents 目录
cp -f "$dest_dir/aria2.plist" "$HOME/Library/LaunchAgents"
chmod 644 "$HOME/Library/LaunchAgents/aria2.plist"

# 卸载并重新加载 LaunchAgents 配置
launchctl unload "$HOME/Library/LaunchAgents/aria2.plist" 2>/dev/null
launchctl load "$HOME/Library/LaunchAgents/aria2.plist"

# 添加 tracker.sh 到定时任务
echo "0 14 * * * $dest_dir/tracker.sh" | crontab -

echo "配置完成"
