#!/bin/bash

LOG_DIR=/var/log
ROOT_UID=0  # $UID 为 0 的是管理员用户

# 1. 判断是否是 ROOT 用户
if [ $(id -u) -ne "$ROOT_UID" ]; then
    echo "Must be root to run this script."
    exit 1
fi

# 2. 切换到指定目录
cd $LOG_DIR || {
    echo "Cannet change to necessary directory."
    exit 2
}

# 3. 清空当前目录下的 message 日志文件
cat /dev/null > message && {
    echo "Logs cleaned up."
    exit 0
}

# 4. 处理未知错误
echo "Logs cleaned up fail"
exit 3
