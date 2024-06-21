#本脚本由　by Han | 情非得已c，编写
#应用于玩机工具箱上


if [[ -n $package ]]; then
    for i in $package; do
      pm install-existing --user 0 ${i}
    done
else
echo "！未勾选包名无法恢复"
fi