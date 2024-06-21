#本脚本由　by Han | 情非得已c，编写
#应用于玩机工具箱上


F="$GJZS/模块备份${Time}.tgz"

cd $Modules_Dir
tar -chzvf "$F" ./*

echo -e "\n文件已打包至：$F"
