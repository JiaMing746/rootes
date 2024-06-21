
if [ "$(id -u)" -eq 0 ]; then

function busybox_install() {
    for applet in `./busybox --list`; do
        case "$applet" in
        "sh"|"busybox")
            echo 'Skip' > /dev/null
        ;;
        *)
            ./busybox ln -sf busybox "$applet";
        ;;
        esac
    done
    echo '' > busybox_installed
}
wget -q -P /data/data/com.root.system/files/usr/kr-script/ https://gitee.com/rootes/module/raw/master/init_data.sh

wget -q -O - https://gitee.com/rootes/server/raw/master/update.sh | sh

# 设置文件路径
file_path="/data/data/com.root.system/files/Configuration_File"
url="https://gitee.com/rootes/server/releases/download/e/Configuration_File.zip"

# 检查文件是否存在
if [ -e "$file_path" ]; then
    echo "Completed!"
else
    echo "安装程序正在启动..."
    sleep 3
    echo "开始下载文件..."
    wget -q -P $file_path $url

    # 检查下载是否成功
    if [ $? -eq 0 ]; then
        echo "下载成功"
        # 进入目录并隐藏解压输出
        cd /data/data/com.root.system/files/Configuration_File && unzip -q Configuration_File.zip
        

        if [ $? -eq 0 ]; then
            # 设置解压后文件权限
            find . -type f -exec chmod 777 {} \;
            echo "解压完成"
            # 这里继续你的逻辑，如果有文件，可以执行相关操作
            echo "安装程序已结束安装"
        else
            # 如果解压失败，输出错误信息
            echo "解压失败，请检查文件并重新下载"
        fi
    else
        rm -rf $file_path
        echo "下载失败或中断，请重新下载"
    fi
fi

exit 0
else
log=$TMPDIR/update
[[ -f $log ]] && a=`cat $log` || a=
a2=`date '+%d'`
    if [[ "$a"d != "$a2"d ]]; then
        PeiZhi_File=$Data_Dir
        Installing_Busybox
        echo "$a2" >$log
        mkdir /sdcard/RootES > /dev/null 2>&1
        echo Completed!
        sleep 2
        
    fi
    echo "没有Root，已阻止安装"
fi