#本脚本由　by Han | 情非得已c，编写
#应用于玩机工具箱上


pm resolve-activity --brief -c android.intent.category.HOME -a android.intent.action.MAIN | sed -n 's#/.*##p' 
