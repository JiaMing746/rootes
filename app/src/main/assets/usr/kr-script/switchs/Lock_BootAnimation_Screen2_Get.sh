#本脚本由　by Han | 情非得已c，编写
#应用于玩机工具箱上


ZT=`lsattr /system/media/bootanimation.zip | sed 's# .*##' | grep i 2>/dev/null`

if [[ -n $ZT ]]; then
    echo 1
elif [[ -z $ZT ]]; then
    echo 0
fi