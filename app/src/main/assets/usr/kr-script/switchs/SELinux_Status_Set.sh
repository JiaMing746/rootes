#本脚本由　by Han | 情非得已c，编写
#应用于玩机工具箱上


if [[ $state = 1 ]]; then
    echo "已开启SELinux（有可能需要重启生效）"
    setenforce 1
else
    echo "已关闭SELinux（有可能需要重启生效）"
    setenforce 0
fi