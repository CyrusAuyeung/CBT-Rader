#!/bin/bash

echo "正在启动 Livox 驱动终端..."

gnome-terminal --title="Livox Driver" -- /bin/bash -c " \
    echo 'ROS 节点: 正在启动 Livox 驱动...'; \
    source /home/c/ws_livox/install/setup.bash; \
    ros2 launch livox_ros_driver2 msg_MID360_launch.py; \
    exec bash"

sleep 1 

echo "正在启动 Fast-LIO 终端..."

gnome-terminal --title="Fast-LIO" -- /bin/bash -c " \
    echo 'ROS 节点: 正在启动 Fast-LIO...'; \
    source /home/c/ws_fast_lio/install/setup.bash; \
    ros2 launch fast_lio mapping.launch.py config_file:=mid360.yaml; \
    exec bash"

echo "所有终端已启动。"