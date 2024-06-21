#设置超级密钥
key="$CMD"







#获取Root权限
if [ "$(id -u)" != "0" ]; then
  echo "- 请用root权限执行脚本"
  exit 1
fi

#脚本所在目录的绝对路径
FILE=$(dirname $(realpath "$0"))
#获取当前活动分区
[[ "$key" = "" ]] && { echo "- 请编辑本脚本设置超级密钥"; exit 1; }

update_apatch() {
#设置临时目录
TMP=/data/local/tmp
[ ! -d "$TMP" ] && mkdir -p "$TMP"
unzip -o $FILE/APatch*.apk -d $TMP/APatch >/dev/null 2>&1 || { echo "- 请把APatch安装包放在本目录下!"; exit 1; }
sleep 1

if [ -e "$TMP/APatch/assets/kpimg" ]; then
    echo ""
    echo "- Find kpimg image"
    echo "- Updating APatch"
    unzip -o "$TMP/APatch.zip" -d "$TMP" >/dev/null 2>&1
    chmod -R 755 "$TMP"
    cp -f "$TMP/APatch/lib/arm64-v8a/libkptools.so" "$FILE/bin/kptools" && echo "- Updata：kptools"
    cp -f "$TMP/APatch/assets/kpimg" "$FILE/bin/kpimg" && echo "- Updata：kpimg"
else
    echo ""
    echo "- APatch安装包文件错误，请重新下载！"
    rm -rf "$TMP/APatch" >/dev/null 2>&1
    exit
fi
}



get_SLOT() {
sleep 1
echo ""
SLOT=$(getprop ro.boot.slot_suffix | tr -d '\r')
echo "- 当前系统槽位：$SLOT"
    case $SLOT in
    _a)
    newSLOT=_b
    ;;
        
    _b) 
    newSLOT=_a
    ;;
    
    *) 
    echo "不支持" && exit 1
    esac
    
echo "- 正在提取非活动分区boot文件：boot$newSLOT.img"
dd if=/dev/block/by-name/boot$newSLOT of=$FILE/boot$newSLOT.img && echo "- 提取成功：boot$newSLOT.img"
}

patch_boot() {
sleep 1
echo ""
cp -rf "$FILE/bin" "$TMP"
boot_patch=$TMP/bin/boot_patch.sh
bootpath=$FILE/boot$newSLOT.img
chmod -R 755 $TMP
#修补boot
$boot_patch $key $bootpath

if [ -e "$TMP/bin/new-boot.img" ]; then
    echo "- Patch success"
    mv "$TMP/bin/new-boot.img" "$FILE/boot-apatch.img"
else
    echo "- Patch error"
    rm -rf "$TMP" >/dev/null 2>&1
    exit 1
fi
}




flash_boot() {
sleep 1
echo ""
echo "- 非活动分区系统槽位：$newSLOT"
echo "- 当前超级密钥：$key"
echo "- 正在刷入，请稍等..."
blockdev --setrw /dev/block/by-name/boot$newSLOT
dd if=$FILE/boot-apatch.img of=/dev/block/by-name/boot$newSLOT && echo "- 刷入成功"
}




install_apatch() {
    echo "❗   请解压使用   ❗"
    echo "❗❗❗❗❗❗❗❗❗❗"
    echo "❗警告：务必等待系统更新界面处于【立即重启】状态"
    echo "❗警告：务必等待系统更新界面处于【立即重启】状态"
    echo "❗警告：务必等待系统更新界面处于【立即重启】状态"
    echo "❗❗❗❗❗❗❗❗❗❗"
    
    
    echo "❗ 即将为您安装：APatch-系统更新保留Root"
    echo "❗ 此工具可能导致部分系统无法正常工作，系统更新导致的不兼容"
    echo "❗ 如果您不清楚这是干什么的或者不知道其风险请取消安装！"
    echo "❗❗❗❗❗❗❗❗❗❗"
    echo "❗ 单击音量上键确认安装"
    echo "❗ 单击音量下键取消安装"
    echo "❗❗❗❗❗❗❗❗❗❗"
    key_click=""
    while [ "$key_click" = "" ]; do
        key_click="$(getevent -qlc 1 | awk '{ print $3 }' | grep 'KEY_')"
        sleep 0.2
    done
    case "$key_click" in
        "KEY_VOLUMEUP")
            echo "❗您已确认安装，请稍候"
            echo "❗正在为您安装"
            update_apatch
            get_SLOT
            patch_boot
            flash_boot
            echo ""
            echo "- 现在去系统更新点【立即重启】"
            ;;
            
        *)
            echo "- 已为您取消安装"
    esac
}

install_apatch