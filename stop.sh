#!/bin/bash
# 停止PPT演示服务器脚本
# 使用方法: ./stop.sh [端口号]

PORT=${1:-10080}

echo "正在停止PPT演示服务器..."

# 查找并终止占用指定端口的进程
if command -v lsof &> /dev/null; then
    PIDS=$(lsof -ti:$PORT 2>/dev/null)
    if [ -n "$PIDS" ]; then
        echo "发现端口 $PORT 上的进程，正在停止..."
        kill -9 $PIDS 2>/dev/null
        echo "已停止端口 $PORT 上的服务"
    else
        echo "端口 $PORT 未被占用"
    fi
else
    # 使用 ps 查找 python http.server 进程
    PIDS=$(ps aux | grep "python3 -m http.server" | grep -v grep | awk '{print $2}')
    if [ -n "$PIDS" ]; then
        echo "发现HTTP服务器进程，正在停止..."
        kill -9 $PIDS 2>/dev/null
        echo "已停止服务"
    else
        echo "未发现运行中的服务"
    fi
fi

echo "完成!"
