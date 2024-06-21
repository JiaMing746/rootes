[ -z $(getprop ro.miui.ui.version.name) ] && echo "非MIUI！" && exit 
[ "$(id -u)" != "0" ] && echo "请您先授予root 权限" && exit

update="
com.android.updater/com.android.updater.receiver.DailyCheckReceiver
com.android.updater/com.android.updater.receiver.BootCompletedReceiver
com.android.updater/com.android.updater.receiver.AccountChangedReceiver
com.android.updater/com.android.updater.DailyCheckJobService
com.android.updater/com.android.updater.server.UploadInfoJobService
com.android.updater/com.android.updater.UpdateService
"


for i in $update; do 
pm enable $i >/dev/null
done


sate=`grep -w 'pm disable \$i \>\/dev\/null' $(echo $(dirname $0)/$(basename $0))  |wc -l`
if [ $sate == 0 ];then
sed -i "s/^pm enable \$i >\/dev\/null/pm disable \$i >\/dev\/null/" $(echo $(dirname $0)/$(basename $0))
echo "已经启用系统更新"
elif [ $sate == 1 ];then
sed -i "s/^pm disable \$i >\/dev\/null/pm enable \$i >\/dev\/null/" $(echo $(dirname $0)/$(basename $0))
echo "已经禁用系统更新"
fi