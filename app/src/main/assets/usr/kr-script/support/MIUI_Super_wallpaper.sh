#本脚本由　by Han | 情非得已c，编写
#应用于玩机工具箱上


pm query-activities --brief com.miui.miwallpaper/com.miui.miwallpaper.activity.SuperWallpaperListActivity | grep 'No activities found'
if [[ $? -eq 0 ]]; then
    echo 0
else
    echo 1
fi
