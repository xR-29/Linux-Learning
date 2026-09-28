#!/bin/bash
menu() {
echo "
    ====================
    Linux 系统管理工具
    ====================
    1.查看系统信息
    2.查看系统资源
    3.文件备份
    0.退出程序"
}

show_system_info() {
echo "====================
     系统信息
===================="
echo "主机名： $(hostname)"
echo 
a=$(cat /etc/os-release | grep PRETTY_NAME | cut -d "=" -f 2 | tr -d '"')
echo "操作系统： $a"
echo
echo "内核版本： $(uname -r)"
echo
echo "系统运行时间： $(uptime)"
echo
}

show_cpu(){
    cpu_model=$(lscpu | grep "型号名称" | awk -F"：" '{print $2}')
    cpu_num=$(lscpu | grep "^CPU:"| awk -F":" '{print $2}')
    arch=$(lscpu | grep "架构"| awk -F"：" '{print $2}')
    echo "====================
     CPU信息
===================="
    echo "CPU型号:$cpu_model"
    echo "CPU数量:$cpu_num"
    echo "架构:$arch"
}

show_memory(){
    mem_total=$(free -h | grep "内存" | awk '{print $2}')
    mem_used=$(free -h | grep "内存" | awk '{print $3}')
    mem_available=$(free -h | grep "内存" | awk '{print $7}')
    mem_swap=$(free -h | grep "交换" | awk '{print $2}')

    echo "====================
     内存信息
===================="
    echo "总内存: $mem_total"
    echo "已用内存: $mem_used"
    echo "可用内存: $mem_available"
    echo "交换空间: $mem_swap"
}

show_disk(){
    disk_total=$(df -h | grep "/$" | awk '{print $2}')
    disk_used=$(df -h | grep "/$" | awk '{print $3}')
    disk_available=$(df -h | grep "/$" | awk '{print $4}')
    disk_usage=$(df -h | grep "/$" | awk '{print $5}')

    echo "====================
     磁盘信息
===================="
    echo "总磁盘空间: $disk_total"
    echo "已用磁盘空间: $disk_used"
    echo "可用磁盘空间: $disk_available"
    echo "磁盘使用率: $disk_usage"
}

show_resources() {
    show_cpu
    show_memory
    show_disk
}


show_backup() {
    echo "====================
     文件备份
===================="
    read -p "请输入要备份的文件路径：" source
    mkdir -p backup
    time=$(date +"%Y%m%d_%H%M%S")
    backup_file="backup/backup_$time.tar.gz"
    tar -czvf $backup_file $source
    echo "备份完成，备份文件为：$backup_file"
}


while true
do
    menu
    read -p "请输入你的选择：" num
    case $num in
    1)
        echo "您选择了查看系统信息。"
        show_system_info
        ;;
    2)
        echo "您选择了查看系统资源。"
        show_resources
        ;;
    3)
        echo "您选择了文件备份。"
        show_backup
        ;;
    0)
        echo "退出程序。"
        exit 0
        ;;
    *)
        echo "无效的选择。"
        ;;
    esac
    read -p "按住任意键继续..." -n 1
done