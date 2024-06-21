bootpath="${img:="$img2"}"

key="$CMD"

if [ "$(id -u)" != "0" ]; then
  echo "- 请用root权限执行脚本"
  exit 1
fi

#脚本所在目录的绝对路径
FILE=$(dirname $(realpath "$0"))
[[ "$key" = "" ]] && { echo "- 请编辑本脚本设置超级密钥"; exit 1; }
[[ -e $bootpath ]] || { echo "- boot.img文件路径错误，请编辑脚本重新设置!"; exit 1; }

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
exit 1
fi
}

patch_boot() {
sleep 1
echo ""
echo "- Find boot image"
cp -rf "$FILE/bin" "$TMP"
boot_patch=$TMP/bin/boot_patch.sh
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
SLOT=$(getprop ro.boot.slot_suffix | tr -d '\r')
echo "- 当前超级密钥：$key"  
blockdev --setrw /dev/block/by-name/boot$SLOT
}


install_apatch() {
    echo "请解压使用"
    echo "APatch更新版本工具"
    echo "本工具也可用于首次刷入APatch"
    echo "如果从面具转为APatch，请提前删除所有模块"
    echo "如果更新APatch导致部分系统无法正常工作"
    echo "请联系APatch开发者解决"
    echo "如果您不清楚这是干什么的请取消安装！"
    echo "单击音量上键确认安装"
    echo "单击音量下键取消安装"
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
            patch_boot
            flash_boot
        ;;
        *)
            echo "- 已为您取消安装"
    esac
}

install_apatch