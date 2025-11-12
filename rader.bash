#!/bin/bash

# --- 使用说明 ---
# 1. 这个脚本用于在 Ubuntu 系统中启动两个 ROS2 节点：Livox 驱动和 Fast-LIO。
# 2. 脚本依赖 'gnome-terminal'。
# 3. 在运行此脚本之前，请务必根据您电脑上的实际路径，修改下方标记为 “用户需要修改的部分” 的 ROS 工作空间路径。

echo "正在启动 Livox 驱动终端..."

# 启动一个新的终端来运行 Livox 驱动节点
gnome-terminal --title="Livox Driver" -- /bin/bash -c " \
    echo 'ROS 节点: 正在启动 Livox 驱动...'; \
    
    # --- 用户需要修改的部分 ---
    # 请将下面的路径 '/home/c/ws_livox' 更改为您自己电脑上 Livox 工作空间的绝对路径。
    # 例如: source /home/YOUR_USERNAME/YOUR_LIVOX_WORKSPACE/install/setup.bash
    source /home/c/ws_livox/install/setup.bash; \
    
    # 启动 Livox 驱动
    ros2 launch livox_ros_driver2 msg_MID360_launch.py; \
    
    # 保持终端打开，以便查看日志和输出
    exec bash"

# 短暂等待，确保上一个终端已成功启动
sleep 1 

echo "正在启动 Fast-LIO 终端..."

# 启动一个新的终端来运行 Fast-LIO 节点
gnome-terminal --title="Fast-LIO" -- /bin/bash -c " \
    echo 'ROS 节点: 正在启动 Fast-LIO...'; \
    
    # --- 用户需要修改的部分 ---
    # 请将下面的路径 '/home/c/ws_Fast_LIO' 更改为您自己电脑上 Fast-LIO 工作空间的绝对路径。
    # 例如: source /home/YOUR_USERNAME/YOUR_FAST_LIO_WORKSPACE/install/setup.bash
    source /home/c/ws_Fast_LIO/install/setup.bash; \
    
    # 启动 Fast-LIO 建图，并指定MID360的配置文件
    # 请确保 'mid360.yaml' 文件位于 fast_lio 包的正确配置路径下。
    ros2 launch fast_lio mapping.launch.py config_file:=mid360.yaml; \
    
    # 保持终端打开
    exec bash"

echo "所有终端已启动。"
