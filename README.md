# CBT-Rader
## 基本步骤
关于配置Livox SDK2, ROS 2与Fast-LIO等前置依赖的步骤，详见[前置步骤](https://ecnmh7533t3z.feishu.cn/wiki/YWXewBB0piWYG9kSJs0cFNNtnKg)

1.打开Rader文件夹（地址为`/home/rader`），在Rader文件夹中打开新终端，并在终端中输入`bash rader.bash`

2.执行该指令后应弹出2个终端窗口（窗口名分别为Livox Driver与Fast-LIO）以及Rviz窗口。在Rviz窗口中应可看到清晰的点云图。

## 注意事项 
1.注意雷达功率为6.5W，工作电压为9~27V，**不允许接超过27V的电源**。供电线接充电宝**OUT1输出口**（即蓝色Type-C口）。

2.激光雷达的半球为光学表面，请务必保证其表面洁净。**不要**用手直接触摸，更**不要**用擦镜纸，纳米布以外的布料去清洁光学表面。如果发现表面落灰，请用**气吹**进行清洁。

脚本内容如下：
```#!/bin/bash

# --- 使用说明 ---
# 1. 这个脚本用于在 Ubuntu 系统中启动两个 ROS2 节点：Livox 驱动和 Fast-LIO。
# 2. 脚本依赖 'gnome-terminal'。
# 3. 在运行此脚本之前，请务必根据您电脑上的实际路径，修改下方标记为 “用户需要修改的部分” 的 ROS 工作空间路径。

echo "正在启动 Livox 驱动终端..."

# 启动一个新的终端来运行 Livox 驱动节点
gnome-terminal --title="Livox Driver" -- /bin/bash -c " \
    echo 'ROS 节点: 正在启动 Livox 驱动...'; \
    
    # --- 需要修改的部分 ---
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
    
    # --- 需要修改的部分 ---
    # 请将下面的路径 '/home/c/ws_Fast_LIO' 更改为您自己电脑上 Fast-LIO 工作空间的绝对路径。
    # 例如: source /home/YOUR_USERNAME/YOUR_FAST_LIO_WORKSPACE/install/setup.bash
    source /home/c/ws_Fast_LIO/install/setup.bash; \
    
    # 启动 Fast-LIO 建图，并指定MID360的配置文件
    # 请确保 'mid360.yaml' 文件位于 fast_lio 包的正确配置路径下。
    ros2 launch fast_lio mapping.launch.py config_file:=mid360.yaml; \
    
    # 保持终端打开
    exec bash"

echo "所有终端已启动。"```

