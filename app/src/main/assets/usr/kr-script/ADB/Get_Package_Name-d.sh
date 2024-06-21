#本脚本由　by Han | 情非得已c，编写
#应用于玩机工具箱上


for i in `adb2 -s ./Get_Package_Name-d.sh`; do
    grep "$i" $APK_Name_list2 2>/dev/null || echo "$i"
done
