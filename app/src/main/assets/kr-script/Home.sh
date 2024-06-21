#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上

QiTa() {
cat <<Han
<group title="其它">
    <action confirm="true" auto-off="true">
        <title>清除应用数据</title>
        <set>pm clear $Package_name</set>
    </action>
</group>
Han
exit 1
}

install_KJ() {
    if [[ $1 = curl ]]; then
        lock=true
    else
        lock=false
    fi
cat <<Han
</group>

<group title="解决方法">
    <page html="https://people11.lanzoui.com/ibScLplfzbc">
        <title>下载curl.zip</title>
        <desc>点击下载curl.zip，下载完成后再在下面安装</desc>
        <lock>if [[ $lock = false ]]; then echo '您的系统未缺少curl，功能暂不可用'; else echo 'unlocked'; fi</lock>
    </page>
    <action interruptible="false">
        <title>把curl安装到搞机助手私有目录</title>
        <desc>已下载完成后请点击此处安装curl</desc>
        <lock>if [[ $lock = false ]]; then echo '您的系统未缺少curl，功能暂不可用'; else echo 'unlocked'; fi</lock>
        <set>. ./Install_Command.sh $Package_name</set>
    </action>
Han
if $Have_ROOT; then
cat <<Han
</group>

<group title="解决方法2">
      <page title="安装MT管理器后打开一次终端" link="http://d.binmt.cc/" />
</group>
Han
else
echo '</group>'
fi

QiTa
}

YiChang() {
if [[ $Status = 0 ]]; then
    return 0
elif [[ $Status = 6 ]]; then
cat <<Han
<text>
    <title>未连接到互联网，无法连接服务器</title>
</text>
Han
QiTa
else
cat <<Han
    <text>
        <slice size="14" color="#FF9900">您的系统`curl -where`命令文件存在异常，无法访问https网址，无法下载云端页面&#x000A;&#x000A;</slice>
    </text>
Han
install_KJ curl
fi
}

Print() {
    . "$Pages/Home.xml"
    exit 0
}

Missing() {
cat <<Han
    <text>
        <slice size="14" color="#FF9900">您的系统缺少命令文件，无法连接服务器</slice>
    </text>
Han
install_KJ $1
}


##
if [[ -f $Pages/Home.xml ]]; then
    unzip --help &>/dev/null && echo '1' | grep 1 | sed -n '/1/p' | md5sum &>/dev/null && Print
fi

rm -rf ~/downloader/path/*
cat <<Han
<?xml version="1.0" encoding="utf-8"?>
<resource dir="file:///android_asset/kr-script" />

<group>
    <text>
        <slice size="14" color="#FF9900">当前版本：$Version_Name（$Version_code）</slice>
    </text>
Han


if [[ -n `curl -where` ]]; then
    curl www.baidu.com &>/dev/null
    Status=$?
    YiChang
    curl 'https://www.baidu.com' &>/dev/null
    Status=$?
    YiChang
else
cat <<Han
    <text>
        <slice size="14" color="#FF9900">您的系统缺少curl命令文件，无法连接服务器</slice>
    </text>
Han
install_KJ curl
fi


    unzip --help &>/dev/null || Missing unzip
    if [[ $? -eq 0 ]]; then
        echo '1' | md5sum &>/dev/null || Missing md5sum
        if [[ $? -eq 0 ]]; then
            echo '1' | sed '/1/p' &>/dev/null || Missing sed
        fi
    fi

cat <<Han
</group>

<group>
    <text>
        <title>读取云端页面异常</title>
        <summary sh=". ./DEBUG.sh" />
    </text>
</group>
Han
QiTa
