#!/bin/bash

# aria2 设置文件路径
CONF=${HOME}/.aria2/aria2.conf

# 设置选择的 trackerlist（可选 all_aria2.txt、best_aria2.txt、http_aria2.txt）
trackerfile=${1:-all_aria2.txt}

# 下载 tracker 列表
downloadfile=https://trackerslist.com/${trackerfile}
list=$(curl -fsSL ${downloadfile})

# 获取现有的 tracker 列表
old_list=$(grep "^bt-tracker=" "${CONF}" | cut -d= -f2-)

if [ "${old_list}" != "${list}" ]; then
    # Tracker 列表已更新，记录更新日期时间
    date_time=$(date +%Y-%m-%d\ %H:%M:%S)

    # 检查 tracker 列表中更新时间记录的数量
    time_count=$(grep -c "# Updated at" "${CONF}")

    if [ ${time_count} -eq 0 ]; then
        # 如果之前没有更新时间记录，则增加两条记录
        sed -i '' "1s/^/# Updated at ${date_time}\n# \n/" "${CONF}"
    elif [ ${time_count} -eq 1 ]; then
        # 如果之前只有一条更新时间记录，则将新记录增加到第二行
        sed -i '' "1s/^/# Updated at ${date_time}\n/" "${CONF}"
        sed -i '' "2s/^/# \n/" "${CONF}"
    else
        # 如果之前已经有两条更新时间记录，则用新记录覆盖第一条记录，原第一条记录变为第二条
        old_time=$(grep "^# Updated at" "${CONF}" | sed -n '1p')
        sed -i '' "1s/^.*$/# Updated at ${date_time}/" "${CONF}"
        sed -i '' "2s/^.*$/$old_time/" "${CONF}"
    fi
fi

# 更新 tracker 列表
if ! grep -q "^bt-tracker=" "${CONF}" ; then
    echo -e "\033[34m==> 添加 bt-tracker 服务器信息......\033[0m"
    echo -e "\nbt-tracker=${list}" >> "${CONF}"
else
    echo -e "\033[34m==> 更新 bt-tracker 服务器信息.....\033[0m"
    sed -i '' "s@^bt-tracker=.*@bt-tracker=${list}@g" "${CONF}"
fi

# 输出最近的两条更新时间记录
echo -e "\n最近两次更新时间为："
grep "^# Updated at" "${CONF}" | sed -n '1,2p'

# 重启 aria2 服务
if pgrep aria2 >/dev/null; then
    echo -e "\033[34m==> 停止 aria2 服务......\033[0m"
    launchctl stop aria2
    echo -e "\033[34m==> 启动 aria2 服务......\033[0m"
    launchctl start aria2
else
    echo -e "\033[34m==> 启动 aria2 服务......\033[0m"
    launchctl start aria2
fi
