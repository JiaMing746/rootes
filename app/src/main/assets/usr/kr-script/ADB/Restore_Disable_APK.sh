#本脚本由　by Han | 情非得已c，编写
#应用于玩机工具箱上


Option=`adb2 -c pm list packages -d | sed 's/.*://g'`
print_apk_list
