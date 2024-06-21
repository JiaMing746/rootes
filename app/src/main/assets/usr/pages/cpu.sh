<?xml version="1.0" encoding="UTF-8" ?>
<page>
    <resource dir="file:///android_asset/samples/kt" />

    <group>
        <text>
            <title>注意：</title>
            <slices>
                <slice>部分手机无法使用</slice>
            </slices>
        </text>
    </group>

    <group title="Cluster ①" visible="v.sh 1">
        <picker options-sh="g.sh governors 1" auto-off="true">
            <title>调度器</title>
            <summary sh="g.sh get_governor 1" />
            <get>g.sh get_governor 1</get>
            <set>g.sh set_governor 1 $state</set>
        </picker>
        <picker options-sh="f.sh options 1" auto-off="true">
            <title>最低频率</title>
            <summary sh="f.sh get_min 1" />
            <get>f.sh get_min 1</get>
            <set>f.sh set_min 1 $state</set>
        </picker>
        <picker options-sh="f.sh options 1" auto-off="true">
            <title>最高频率</title>
            <summary sh="f.sh get_max 1" />
            <get>f.sh get_max 1</get>
            <set>f.sh set_max 1 $state</set>
        </picker>
    </group>

    <group title="Cluster ②" visible="v.sh 2">
        <picker options-sh="g.sh governors 2" auto-off="true">
            <title>调度器</title>
            <summary sh="g.sh get_governor 2" />
            <get>g.sh get_governor 2</get>
            <set>g.sh set_governor 2 $state</set>
        </picker>
        <picker options-sh="f.sh options 2" auto-off="true">
            <title>最低频率</title>
            <summary sh="f.sh get_min 2" />
            <get>f.sh get_min 2</get>
            <set>f.sh set_min 2 $state</set>
        </picker>
        <picker options-sh="f.sh options 2" auto-off="true">
            <title>最高频率</title>
            <summary sh="f.sh get_max 2" />
            <get>f.sh get_max 2</get>
            <set>f.sh set_max 2 $state</set>
        </picker>
    </group>

    <group title="Cluster ③" visible="v.sh 3">
        <picker options-sh="g.sh governors 3" auto-off="true">
            <title>调度器</title>
            <summary sh="g.sh get_governor 3" />
            <get>g.sh get_governor 3</get>
            <set>g.sh set_governor 3 $state</set>
        </picker>
        <picker options-sh="f.sh options 3" auto-off="true">
            <title>最低频率</title>
            <summary sh="f.sh get_min 3" />
            <get>f.sh get_min 3</get>
            <set>f.sh set_min 3 $state</set>
        </picker>
        <picker options-sh="f.sh options 3" auto-off="true">
            <title>最高频率</title>
            <summary sh="f.sh get_max 3" />
            <get>f.sh get_max 3</get>
            <set>f.sh set_max 3 $state</set>
        </picker>
    </group>
</page>


    <group>
        <action>
        <title>切换CPU核心</title>
        <param name="cpuAction" label="选择操作" type="select">
            <option value="enable">开启CPU核心</option>
            <option value="disable">关闭CPU核心</option>
        </param>
        <param name="coresToToggle" label="要切换的CPU核心数量" type="text" desc="输入要切换的CPU核心数量" required="required" />
        <set><![CDATA[
            cpuAction="$cpuAction"
            coresToToggle="$coresToToggle"
            cpuCores=$(grep -c ^processor /proc/cpuinfo)

            echo "当前系统有 $cpuCores 个CPU核心。"

            if ! [ "$coresToToggle" -eq "$coresToToggle" ] 2>/dev/null; then
                echo "错误：请输入有效的数字。"
                exit 1
            fi

            if [ "$coresToToggle" -gt "$cpuCores" ]; then
                echo "错误：要切换的核心数不能超过实际核心数。"
                exit 1
            fi

            case "$cpuAction" in
                "enable")
                    for i in $(seq 0 $(expr $coresToToggle - 1)); do
                        echo 1 > "/sys/devices/system/cpu/cpu$i/online"
                        echo "开启CPU核心 $i"
                    done
                    ;;
                "disable")
                    for i in $(seq 0 $(expr $coresToToggle - 1)); do
                        echo 0 > "/sys/devices/system/cpu/cpu$i/online"
                        echo "关闭CPU核心 $i"
                    done
                    ;;
                *)
                    echo "无效的操作选择"
                    exit 1
                    ;;
            esac

            echo "成功执行 CPU 操作。"
        ]]></set>
    </action>    
    </group>