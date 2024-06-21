#本脚本由　by Han | 情非得已c，编写
#应用于玩机工具箱上


package=com.android.settings
BM=`pm query-activities --brief -a android.intent.action.MAIN -c android.intent.category.HOME | sed -rn 's/ +//p' | grep "$package"`
pm set-home-activity "$BM"; input keyevent 3