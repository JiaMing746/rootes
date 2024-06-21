Configuration=2021072100
Magisk_Warehouse_version=2021072100
App_Store_version=2021072100
Show_Compatibility_Mode=1
MIUI=0


case "$1" in

#应用
com.topjohnwu.magisk)
apk='com.topjohnwu.magisk'
name='Magisk'
version='27.0'
versionCode='27000'
author='John Wu'
description='Magisk Manager'
time='2021年5月12号'
    [[ $Choice = 1 ]] && Download_File=$PeiZhi_File/$1.apk
;;

org.lsposed.manager)
apk='org.lsposed.manager'
name='LSPosed 模块管理器'
version='v1.4.7'
versionCode='5803'
author='LSPosed Developers'
description='LSPosed Xposed框架模块管理器'
apkfile="$PeiZhi_File/$apk-$versionCode.apk"
time='2021年7月2号'
    if [[ $Choice = 1 ]]; then
        [[ $SDK -lt 27 ]] && abort "！$name-$version（$versionCode）不支持安卓8.1.0以下系统"
        if [[ ! -s "$apkfile" ]]; then
            rm -rf "~/Resources_Dir/App_Store/$apk-"*.apk
            . "$Load" riru_lsposed
            unzip -p "$Download_File" 'manager.apk' >"$apkfile"
        fi
    fi
    Download_File="$apkfile"
;;

org.meowcat.edxposed.manager)
apk='org.meowcat.edxposed.manager'
name='EdXposed Manager'
version='4.6.2'
versionCode='46200'
author='MlgmXyysd'
description='EDXposed框架模块管理器'
time='2021年2月7号'
    [[ $Choice = 1 ]] && Download_File=$PeiZhi_File/$1.apk
;;

top.canyie.dreamland.manager)
apk='top.canyie.dreamland.manager'
name='梦境'
version='0.0.7'
versionCode=7
author=canyie
description='梦境框架管理器'
time='2021年7月1号'
    [[ $Choice = 1 ]] && Download_File=$PeiZhi_File/$1.apk
;;

me.weishu.exp)
apk='me.weishu.exp'
name='太极'
version='含光·8.0.3.06211300'
versionCode=803
author='weishu'
description='太极是一个能够运行 Xposed 模块的框架，模块能通过它改变系统和应用的行为。太极既能以传统的 Root/刷机方式运作，也能免 Root/ 免刷机运行；并且它支持 Android 5.0 ~ 11。

简单来说，太极就是一个 类 Xposed框架，它能够加载 Xposed 模块、修改系统和 APP、拦截方法，执行 hook 逻辑等。'
time='2021年7月12号'
    [[ $Choice = 1 ]] && Download_File=$PeiZhi_File/$1.apk
;;

rikka.riru)
apk='rikka.riru'
name='Riru'
version='25.4.2'
versionCode=415
author='Rikka  酷安@蓝莓味绿茶 '
description='显示Riru状态'
apkfile="$PeiZhi_File/$apk-$versionCode.apk"
time='2021年4月18号'
    if [[ $Choice = 1 ]]; then
        if [[ ! -s "$apkfile" ]]; then
            rm -rf "~/Resources_Dir/App_Store/$apk-"*.apk
            Riru_version=1
            . "$Load" riru-core
            unzip -p "$Download_File" 'app.apk' >$apkfile
        fi
    fi
    Download_File="$apkfile"
;;

Automatic_brick_rescue)
id='Automatic_brick_rescue'
name='自动神仙救砖'
version='v2021041500'
versionCode=35
author='by：Han | 情非得已c'
description='用途：当刷入某模块后导致无法正常开机，自动触发已设置好的救砖操作'
time='2021年4月15号'
;;

riru-core)
List="：
riru-core-v21.3(36).zip
"
id='riru-core'
name='Riru (Riru - Core)'
version='v25.4.4.r426.05efc94'
versionCode=426
author='Rikka  酷安@蓝莓味绿茶 '
description='提供一种将代码注入zygote进程的方法，所有以Riru开头的模块必刷模块'
time='2021年5月8号'
if [[ $Riru_version -eq 1 ]]; then
    [[ $Choice = 1 ]] && Download_File=$PeiZhi_File/$1.zip
fi
;;

riru_lsposed)
id='riru_lsposed'
showapk='v1.4.7 (5803)'
name='Riru - LSPosed'
version='v1.4.7 (5803)'
versionCode='5803'
author='LSPosed Developers'
description='一款基于Riru API开发的Xposed框架，支持运行在安卓8.1.0 ~ 12系统上。需要安装Riru v25.0.1或更高版本，Telegram: @LSPosed'
time='2021年7月2号'
    [[ $Choice = 1 ]] && Download_File=$PeiZhi_File/$1.zip
;;

riru_edxposed)
showapk='4.6.2-pre (46200)'
id='riru_edxposed'
name='Riru - EdXposed'
version='v0.5.2.2_4683-master'
versionCode='4683'
author='solohsu, MlgmXyysd'
description='一款基于Riru API开发的Xposed框架，支持运行在安卓8 ~ 11系统上。需要安装Riru v23或更高版本，Telegram: @EdXposed'
time='2021年2月18号'
    [[ $Choice = 1 ]] && Download_File=$PeiZhi_File/$1.zip
;;

riru_dreamland)
showapk='0.0.7(7)'
id='riru_dreamland'
name='Riru - Dreamland（梦境框架）'
author='canyie'
version='2.0_2005'
versionCode='2005'
description='一款基于Riru API开发的Xposed框架，支持运行在安卓 7.0 ~ 11，需要安装Riru，Telegram：@DreamlandFramework, QQ群：949888394'
    [[ $Choice = 1 ]] && Download_File=$PeiZhi_File/$1.zip
;;

taichi)
id='taichi'
name='Taichi'
version='v7.0.5'
versionCode='705'
author='weishu'
description='Use Xposed modules with Taichi in Magisk.（切换到太极 · 阳）'
expversion='含光·8.0.3.06211300'
time='2021年7月12号'
    [[ $Choice = 1 ]] && Download_File=$PeiZhi_File/$1.zip
;;

GJZS_Theme_Color)
MIUI=1
id='GJZS_Theme_Color'
version='v1'
versionCode='1'
name='自定义「玩机工具箱」主题配色'
author='by：Han | 情非得已c'
description="$name"
time='2020年6月15号'
;;

Game_BianShengQi)
MIUI=1
Show_Compatibility_Mode=0
id='Game_BianShengQi'
name='MIUI开发版游戏加速变声器'
version='v1'
versionCode='1'
author='淡淡的影寒'
description='工作原理：在prop内增加ro.vendor.audio.voice.change.support=true，打开游戏加速变声器功能'
time='2020年6月15号'
    [[ $Choice = 1 ]] && . ./Magisk_Module/$1.sh
;;

Xiaomi_Full_frame_rate)
MIUI=1
Show_Compatibility_Mode=0
id='Xiaomi_Full_frame_rate'
name='小米系列全局高刷'
version='v1.3'
versionCode='3'
author='by：Han | 情非得已c'
description='使用模块方式冻结电量和性能，让支持小米高刷新率的设备，全局使用高刷，需要把在设置里 -->显示 -->屏幕刷新率设置为最高刷新率'
time='2020年6月25号'
    [[ $Choice = 1 ]] && . ./Magisk_Module/$1.sh
;;

Magisk_Abnormal_Repair)
id='Magisk_Abnormal_Repair'
name='Magisk异常修复'
version='v1.2'
versionCode='3'
author='by：Han | 情非得已c'
description='修复进入Magisk时提示：Magisk 不支持安装为系统应用，请还原为用户应用。'
description2='修复进入Magisk时提示Running this app as a system app is not supported. Please revert the app to a user app.翻译：不支持将Magisk作为系统应用程序运行，请将该应用还原为用户应用'
time='2021年2月25号'
;;

Hide_system_ROOT)
Show_Compatibility_Mode=0
id='Hide_system_ROOT'
name='隐藏系统ROOT'
version='v1.6'
versionCode=6
author='by：Han | 情非得已c'
description='隐藏除Magisk以外的系统ROOT，只保留magisk su，因为系统ROOT的存在会让Magisk Hide失效，导致部分应用仍然会检测到ROOT，且部分机型会存在Magisk掉ROOT的情况，同时也还可以修复进入Magisk时提示
检测到不属于 Magisk 的 su 文件，请删除其他超级用户程序。其实说白了就是存在系统ROOT导致的'
time='2021年3月7号'
    [[ $Choice = 1 ]] && . ./Magisk_Module/$1.sh
;;

Volume_Adjustment)
id='Volume_Adjustment'
name='媒体音量级别调节'
version='v1.3'
versionCode='3'
author='by：Han | 情非得已c'
description='将默认的按下音量键15次后放大至最大音量，更改为自己喜欢的数值，我只在小米上测试OK，其它机型自己测试'
time='2020年12月12号'
;;

lanzou-hosts)
Show_Compatibility_Mode=0
id='lanzou-hosts'
name='解决蓝奏云网址打不开'
version='v1.6'
versionCode=6
author='by：Han | 情非得已c'
description='解决蓝奏云网址打不开，如果失效请再次安装本模块即可'
time='2021年4月30号'
    [[ $Choice = 1 ]] && . ./Magisk_Module/$1.sh
;;

github-hosts)
Show_Compatibility_Mode=0
id='github-hosts'
name='解决Github网址打不开'
version='v1.5'
versionCode=5
author='by：Han | 情非得已c'
description='解决Github网址打不开，如果失效请再次安装本模块即可'
time='2021年4月30号'
    [[ $Choice = 1 ]] && . ./Magisk_Module/$1.sh

;;

Freezing_system_app)
id='Freezing_system_app'
name='使用Magisk模块方式冻结系统应用'
version='v1'
versionCode='1'
author='by：Han | 情非得已c'
description="$name"
time='2020年8月9号'
;;

Convert_to_system_app)
id='Convert_to_system_app'
name='三方应用转系统应用'
version='v1.2'
versionCode='2'
author='by：Han | 情非得已c'
description='自定义方式使用模块方式将三方应用转为系统应用'
time='2020年8月20号'
;;

Remove_Temperature_Control)
id='Remove_Temperature_Control'
name='移除温控'
version='v2021021300'
versionCode=9
author='by：Han | 情非得已c'
description='用途：Magisk模块方式移除温控文件'
time='2021年2月13号'
;;

Clone_Configuration)
id=Clone_Configuration
name=克隆主用户EDXposed模块配置
version='v2021021402'
versionCode=2
author='by：Han | 情非得已c'
description='免双开EDXposed Manager和Xposed模块，使双开应用同步主用户Xposed模块配置'
time='2021年2月14号'
;;

wifi-bonding)
Show_Compatibility_Mode=0
id='wifi-bonding'
name='Wifi Bonding - 让Wi-Fi带宽提速（高通）'
version='1.14'
versionCode='15'
author='simonsmh'
description='Doubles your wi-fi bandwith by modifying WCNSS_qcom_cfg.ini（通过修改WCNSS_qcom_cfg.ini，让Wi-Fi带宽提速至最大）'
time='2020年12月13号'
    [[ $Choice = 1 ]] && . ./Magisk_Module/$1.sh
;;

Model_Camouflage)
id='Model_Camouflage'
name='机型伪装'
version='v1'
versionCode='1'
author='by：Han | 情非得已c'
description='原理：通过Magisk修改prop达到机型伪装。'
time='2020年6月15号'
;;

SELinux_OFF)
Show_Compatibility_Mode=0
id='SELinux_OFF'
name='关闭SELinux'
version='v1.3'
versionCode='3'
author='by：Han | 情非得已c'
description='在每次重启/开机时，自动关闭SELinux/宽容模式/Permissive，针对部分模块需要关闭SELinux才能正常开机，以及部分Xposed模块需要关闭才生效，除非你很清楚关闭SELinux后果，否则不推荐使用本模块'
time='2021年2月7号'
    [[ $Choice = 1 ]] && . ./Magisk_Module/$1.sh
;;

SELinux_ON)
Show_Compatibility_Mode=0
id='SELinux_ON'
name='开启SELinux'
version='v1.3'
versionCode='3'
author='by：Han | 情非得已c'
description='在每次重启/开机时，自动开启SELinux/严格模式/强制模式/Enforcing，针对部分官改ROM系统默认关闭SELinux'
time='2021年2月7号'
    [[ $Choice = 1 ]] && . ./Magisk_Module/$1.sh
;;

exit_sideload)
    Download_File="$PeiZhi_File/$1.zip"
;;

Card_Brush_Bag)
    Download_File="$PeiZhi_File/Card_Brush_Bag/$3.zip"
;;

Install_Applet)
    name=Applet
    versionCode=73
    Download_File=$Other/$name.zip
    Install_Applet2
;;

*)
    abort "！未找到$1服务"
;;
esac
true
