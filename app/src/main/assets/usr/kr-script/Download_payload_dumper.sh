#本脚本由　by Han | 情非得已c，编写
#应用于玩机工具箱上


Choice=1
. $Load payload_dumper-win64
File="$GJZS/payload_dumper-Windows.zip"
cp -f $Download_File "$File"
echo "- 查看使用说明"
unzip -p "$File" 'payload_dumper-win64/README.txt' | head -n 10
echo
echo
echo "- 文件已下载到：$File"