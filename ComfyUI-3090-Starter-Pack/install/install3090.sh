#!/bin/bash

# 自动安装 ComfyUI 及其依赖 for Ubuntu + NVIDIA 3090
# tested on Ubuntu 20.04 / 22.04 with Python 3.10+

echo "🔧 开始安装 ComfyUI 运行环境..."

# 安装依赖
sudo apt update
sudo apt install -y git python3 python3-venv python3-pip wget unzip ffmpeg libgl1

# 克隆 ComfyUI 主程序
git clone https://github.com/comfyanonymous/ComfyUI.git
cd ComfyUI

# 创建虚拟环境
python3 -m venv venv
source venv/bin/activate

# 升级 pip 并安装依赖
pip install --upgrade pip
pip install -r requirements.txt

# 安装显存优化插件（xformers）
pip install xformers==0.0.22.post7

# 启用 FP16 支持
export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:64

echo "✅ ComfyUI 基础环境已安装完毕。"

echo "📦 请将模型文件放入以下目录（需手动创建）:"
echo " - models/checkpoints/         （主模型）"
echo " - models/animatediff/         （AnimateDiff 模块）"
echo " - models/vae/                 （可选 VAE）"

echo "💡 运行方式（必须激活虚拟环境）:"
echo "cd ComfyUI && source venv/bin/activate && python3 main.py"
