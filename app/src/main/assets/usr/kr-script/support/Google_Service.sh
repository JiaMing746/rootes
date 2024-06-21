#本脚本由　by Han | 情非得已c，编写
#应用于玩机工具箱上

Check() {
    Service=`pm list packages com.google.android.gms`
    if [[ -n $Service ]]; then
        return 1
    fi
        Service=`pm list packages -d com.google.android.gms`
        if [[ -n $Service ]]; then
            return 1
        fi
}
Check
echo $?
