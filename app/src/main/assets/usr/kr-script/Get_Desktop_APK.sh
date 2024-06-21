#本脚本由　by Han | 情非得已c，编写
#应用于玩机工具箱上


pm query-activities --brief -a android.intent.action.MAIN -c android.intent.category.HOME | sed -rn 's/ +//g; s#/.*##p' 
