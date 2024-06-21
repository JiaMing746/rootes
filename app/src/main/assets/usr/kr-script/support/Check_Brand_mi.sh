#本脚本由　by Han | 情非得已c，编写
#应用于玩机工具箱上


Brand=$(getprop ro.product.brand)
if [[ $Brand == xiaomi || $Brand == Xiaomi ]]; then
    echo 1
else
    echo 0
fi
