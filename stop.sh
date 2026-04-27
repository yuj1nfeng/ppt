#!/bin/bash
PID=$(lsof -ti:10081 2>/dev/null)
if [ -n "$PID" ]; then
    kill $PID 2>/dev/null
    echo "服务已停止 (PID: $PID)"
else
    echo "未找到运行中的服务"
fi
