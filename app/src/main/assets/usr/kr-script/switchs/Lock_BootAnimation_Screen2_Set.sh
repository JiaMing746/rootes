#本脚本由　by Han | 情非得已c，编写
#应用于玩机工具箱上


Mount_system
if [[ $state = 1 ]]; then
    chattr +i $system/media/bootanimation.zip
else
    chattr -i $system/media/bootanimation.zip
fi
    echo
    Unload