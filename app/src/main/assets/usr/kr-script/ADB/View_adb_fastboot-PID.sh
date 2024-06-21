#本脚本由　by Han | 情非得已c，编写
#应用于玩机工具箱上


for i in `pgrep -f adb fastboot`; do
    pstree -p "$i"
    echo
done