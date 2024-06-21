#本脚本由　by Han | 情非得已c，编写
#应用于玩机工具箱上


case $(getprop ro.miui.ui.version.name) in
    V*|v*) echo "1" ;;
    *) echo "0" ;;
esac
