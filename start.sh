#!/bin/bash
cd "$(dirname "$0")"
echo "启动服务: http://0.0.0.0:10081"
echo "按 Ctrl+C 停止服务"
python3 -m http.server 10081 --bind 0.0.0.0
