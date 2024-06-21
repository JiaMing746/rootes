

if [ "$(id -u)" -eq 0 ]; then
battery_level=$(dumpsys battery | grep "level" | awk -F: '{print $2}' | tr -d '[:space:]')
battery_health=$(dumpsys battery | grep "health" | awk -F: '{print $2}' | tr -d '[:space:]')
battery_temp_raw=$(cat /sys/class/power_supply/battery/uevent | grep "POWER_SUPPLY_TEMP=" | cut -d'=' -f2)
battery_temp=$(echo "$battery_temp_raw / 10" | awk '{printf "%g", $1}')

if [ "$(echo "$battery_temp < 300" | bc)" -eq 1 ]; then
    temp_status="温度低"
elif [ "$(echo "$battery_temp >= 300 && $battery_temp <= 390" | bc)" -eq 1 ]; then
    temp_status="温度正常"
else
    temp_status="温度高"
fi

android_version=$(getprop ro.build.version.release)
ab_slot=$(getprop ro.boot.slot_suffix)
battery_capacity=$(cat /sys/class/power_supply/battery/capacity)
manufacturer=$(getprop ro.product.manufacturer)
processor=$(getprop ro.product.cpu.abi)
cpu_manufacturer=$(cat /proc/cpuinfo | grep -i "hardware" | awk -F: '{print $2}' | tr -d '[:space:]')
pt_update_status=$(getprop ro.build.version.security_patch)
operator_name=$(getprop gsm.operator.alpha)
device_model=$(getprop ro.product.model)
bluetooth_connected=$(dumpsys bluetooth_manager | grep "state: CONNECTED")
selinux_status=$(getenforce)
kernel_version=$(uname -r)
ANDROID_SDK=$(getprop ro.build.version.sdk)
top_power_apps_raw=$(dumpsys batterystats | grep "Uid" | sort -k 4 -n -r | head -n 3)
top_power_apps=""

# 提取应用程序名称和电量使用
while IFS= read -r line; do
    uid=$(echo "$line" | awk '{print $4}')
    app_name=$(dumpsys package $uid | grep "Package [^ ]" | awk '{print $2}')
    power_usage=$(echo "$line" | awk '{print $8}')
    top_power_apps+="应用：$app_name"
done <<< "$top_power_apps_raw"



if [ -e "/system/bin/su" ]; then
    kernelsu_status="SU正在运行"
else
    kernelsu_status="SU未检测"
fi

if [ -e "/data/adb/ksud" ]; then
    kernelsu="正在运行 KernelSU"
else
    kernelsu="正在运行 Magisk"
fi


cat <<EOL
<?xml version="1.0" encoding="UTF-8" ?>
<items>
    <group>
        <text>
            <title>处理器制造商:</title>
            <desc>$cpu_manufacturer</desc>
        </text>
    </group>
    <group>
        <text>
            <title>SElinux状态:</title>
            <desc>$selinux_status</desc>
        </text>
    </group>
    <group>
        <text>
            <title>内核版本:</title>
            <desc>$kernel_version</desc>
        </text>
    </group>
    <group>
        <text>
            <title>电池电量（比如158℃就是15.8℃）:</title>
            <desc>$battery_capacity%</desc>
        </text>
    </group>
    <group>
        <text>
            <title>电池健康:</title>
            <desc>$battery_health</desc>
        </text>
    </group>
    <group>
        <text>
            <title>电池温度:</title>
            <desc>$battery_temp°C</desc>
        </text>
    </group>
    <group>
        <text>
            <title>温度状态:</title>
            <desc>$temp_status</desc>
        </text>
    </group>
    <group>
        <text>
            <title>Android版本:</title>
            <desc>$android_version</desc>
        </text>
    </group>
    <group>
        <text>
            <title>Android SDK:</title>
            <desc>$ANDROID_SDK</desc>
        </text>
    </group>
    <group>
        <text>
            <title>Android安全补丁:</title>
            <desc>$pt_update_status</desc>
        </text>
    </group>
    <group>
        <text>
            <title>A/B槽位:</title>
            <desc>$ab_slot</desc>
        </text>
    </group>
    <group>
        <text>
            <title>手机厂商:</title>
            <desc>$manufacturer</desc>
        </text>
    </group>
    <group>
        <text>
            <title>手机型号:</title>
            <desc>$device_model</desc>
        </text>
    </group>
    <group>
        <text>
            <title>处理器:</title>
            <desc>$processor</desc>
        </text>
    </group>
    <group>
        <text>
            <title>SU状态:</title>
            <desc>$kernelsu_status</desc>
        </text>
    </group>
    <group>
        <text>
            <title>Root管理器:</title>
            <desc>$kernelsu</desc>
        </text>
    </group>
    <group>
        <text>
            <title>运营商:</title>
            <desc>$operator_name</desc>
        </text>
    </group>
      
    <group>
        <page activity="am start-activity com.root.system/com.root.system.AppActivity\$AppActivity">
            <title>进程管理</title>
            <desc></desc>
        </page>
        </group>
    
        <group>
        <text>
            <title>耗电排行榜（最高排行耗电最低）:</title>
            <desc>$top_power_apps</desc>
        </text>
    </group>
   
</items>

EOL

else

cat <<EOL
<?xml version="1.0" encoding="UTF-8" ?>
<items>
    <group>
        <text>
            <title>没有root</title>
            <desc>无法获取设备状态</desc>
        </text>
    </group>
    
EOL
    
fi
