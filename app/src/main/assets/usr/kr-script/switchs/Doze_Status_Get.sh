#本脚本由　by Han | 情非得已c，编写
#应用于玩机工具箱上


dumpsys deviceidle | grep -q Enabled=true
A=$?
if [[ $A = 0 ]]; then
    echo 1
else
    echo 0
fi
