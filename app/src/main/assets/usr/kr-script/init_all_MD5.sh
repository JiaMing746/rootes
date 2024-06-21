# a() { md5sum < `pm path $Package_name | sed 's/.*://g'`; }
# 
# Canary=2021050802
# if [[ $Version_code -eq $Canary ]]; then
    # if [[ `a` != 779dd22b55d0fbec37462bfe64582b6a* ]]; then
        # echo "！盗版软件，已触发自动卸载"
        # pm uninstall $Package_name
        # exit 1
    # fi
# fi
    init_data_ID=init_data.sh
    init_data_MD5=55f69445fc51f53689e4ccbc8e0521e9
    Util_Functions_ID=Util_Functions.sh
    Util_Functions_MD5=8a8d450fc896e42553d1df40cb7c7c66
    Cloud_ID=Cloud_Page.zip
    Cloud_Version=2021050815
