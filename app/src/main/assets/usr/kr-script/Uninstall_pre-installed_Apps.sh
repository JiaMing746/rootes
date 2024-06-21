#本脚本由　by Han | 情非得已c，编写
#应用于玩机工具箱上


for i in $package; do
   echo "- 开始卸载$i"
   pm uninstall $i
   rm -rf $SD_PATH/Android/data/$i
done