#!/bin/bash
cd "$(dirname "$0")"

# 检测是否安装了 python3
if ! command -v python3 &> /dev/null; then
    echo "❌ 未检测到 Python3，请先安装 Python3"
    echo ""

    # 检测操作系统类型
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "📱 macOS 系统安装方式："
        echo "   方式1: brew install python3"
        echo "   方式2: 访问 https://www.python.org/downloads/macos/ 下载安装包"
        echo ""
        echo "是否自动使用 brew 安装？(y/n)"
        read -r answer
        if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
            if command -v brew &> /dev/null; then
                brew install python3
            else
                echo "❌ 未检测到 brew，请先安装 Homebrew: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
                exit 1
            fi
        else
            exit 1
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # 检测 Linux 发行版
        if command -v apt-get &> /dev/null; then
            echo "🐧 Debian/Ubuntu 系统安装方式："
            echo "   sudo apt-get update && sudo apt-get install -y python3"
            echo ""
            echo "是否自动安装？(y/n)"
            read -r answer
            if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
                sudo apt-get update && sudo apt-get install -y python3
            else
                exit 1
            fi
        elif command -v yum &> /dev/null; then
            echo "🐧 CentOS/RHEL 系统安装方式："
            echo "   sudo yum install -y python3"
            echo ""
            echo "是否自动安装？(y/n)"
            read -r answer
            if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
                sudo yum install -y python3
            else
                exit 1
            fi
        elif command -v dnf &> /dev/null; then
            echo "🐧 Fedora 系统安装方式："
            echo "   sudo dnf install -y python3"
            echo ""
            echo "是否自动安装？(y/n)"
            read -r answer
            if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
                sudo dnf install -y python3
            else
                exit 1
            fi
        elif command -v pacman &> /dev/null; then
            echo "🐧 Arch Linux 系统安装方式："
            echo "   sudo pacman -S --noconfirm python"
            echo ""
            echo "是否自动安装？(y/n)"
            read -r answer
            if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
                sudo pacman -S --noconfirm python
            else
                exit 1
            fi
        else
            echo "🐧 Linux 系统，请手动安装 Python3"
            exit 1
        fi
    else
        echo "❓ 未知操作系统，请手动安装 Python3"
        exit 1
    fi
fi

# 再次检测是否安装成功
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 安装失败，请手动安装后重试"
    exit 1
fi

echo "✅ Python3 检测通过"
echo ""
echo "启动服务: http://0.0.0.0:10081"
echo "按 Ctrl+C 停止服务"
python3 -m http.server 10081 --bind 0.0.0.0
