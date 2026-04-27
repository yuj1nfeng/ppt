#!/bin/bash
# 在线教育系统PPT启动脚本
# 使用方法: ./start.sh [端口号]

PORT=${1:-10080}
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "========================================"
echo "  在线教育系统PPT演示"
echo "========================================"
echo ""

# 先停止旧进程
$SCRIPT_DIR/stop.sh $PORT
echo ""

echo "启动HTTP服务器..."
echo "访问地址: http://localhost:$PORT"
echo ""
echo "按 Ctrl+C 停止服务器"
echo "========================================"
echo ""

cd "$SCRIPT_DIR"
python3 -m http.server $PORT --bind 0.0.0.0
