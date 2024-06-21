<?xml version="1.0" encoding="UTF-8" ?>
<items>
    <group title="ADB操作">
    <action title="ADB无法使用解决">
        <script><![CDATA[
adb start-server
            echo "Okay"

        ]]></script>
    </action>
    
        <action>
        <title>ADB网络连接</title>
        <param name="deviceIp" label="设备IP地址" type="text" desc="输入设备的IP地址" />
        <param name="devicePort" label="设备端口" type="text" desc="输入设备的端口号 (默认为5555)" />
        <set><![CDATA[
            if [ -n "$deviceIp" ]; then
                if [ -z "$devicePort" ]; then
                    devicePort=5555
                fi

                adb connect "$deviceIp:$devicePort"

                # 等待用户输入配对码

                echo "已通过ADB连接到设备：$deviceIp:$devicePort"
            else
                echo "未输入设备IP地址"
            fi
        ]]></set>
    </action>
        <page config-sh="cat /data/user/$ANDROID_UID/$Package_name/files/usr/pages/WearOS/BM.xml" title="屏幕操作" />
        <page config-sh="cat /data/user/$ANDROID_UID/$Package_name/files/usr/pages/WearOS/dc.xml" title="电池工具" />
        <page config-sh="cat /data/user/$ANDROID_UID/$Package_name/files/usr/pages/WearOS/app.xml" title="软件工具" />
        <page config-sh="cat /data/user/$ANDROID_UID/$Package_name/files/usr/pages/WearOS/files.xml" title="文件管理" />
        <page config-sh="cat /data/user/$ANDROID_UID/$Package_name/files/usr/pages/WearOS/mp3.xml" title="声音管理" />
        <page config-sh="cat /data/user/$ANDROID_UID/$Package_name/files/usr/pages/WearOS/jh.xml" title="电话操作" />
        
        <action>
        <title>终端</title>
            <param name="sh" label="命令" type="text" desc="命令输入" />
            <set>$sh</set>
            
        </action>
    </group>
    
    
    <group title="Fastboot操作（支持所有）">
    <action>
        <title>Fastboot刷入镜像</title>
        <param name="imagePath" label="镜像文件路径" type="text" desc="输入要刷入的镜像文件的绝对路径" />
        <param name="partitionName" label="分区名称" type="text" desc="输入要刷入的分区名称" />
        <set><![CDATA[
            if [ -n "$imagePath" ] && [ -n "$partitionName" ]; then
                fastboot flash $partitionName "$imagePath"
                echo "已使用Fastboot刷入镜像：$imagePath 到分区：$partitionName"
            else
                echo "未输入镜像文件路径或分区名称"
            fi
        ]]></set>
    </action>


            <action>
            <title>切换分区AB</title>
            <desc></desc>
            <param name="test"> value="X">
                <option value="a">A分区</option>
                <option value="b">B分区</option>
            </param>
            <set>fastboot set_active $test</set>
        </action>

    <action>
            <title>小米线刷</title>
            <desc>
flash_all是清数据
flash_except_storage是保数据
flash_lock全部删除并上锁bl
            </desc>
            <set>sh "${sh:="$sh2"}"</set>
            <params>
            <param name="sh" type="file" suffix="sh" editable="true" required="true" title="可输入sh文件绝对路径，也可以使用文件选择器选择文件" desc="" />
        </params>
    </action>
    
    
        <action confirm="true" interruptible="false">
        <title>解锁Bootloader</title>
        <desc>软件只提ticwatch和其他解锁方式，其他手机理论课也可以</desc>
        <set>
        fastboot oem unlock
        sleep 3
        echo 切换方案
        fastboot flashing unlock
        sleep 3
        echo 切换方案
        fastboot vivo_bsp unlock_vivo
        echo 完成
        exit</set>
    </action>
    
        <action>
        <title>刷入分区</title>
        <desc>刷入分区</desc>
        <param name="test"> value="X">
                <option value="system">system</option>
                <option value="system_a">system_a</option>
                <option value="system_b">system_b</option>
                <option value="vender">vender</option>
                <option value="vender_a">vende_a</option>
                <option value="vender_b">vender_b</option>
                <option value="recovery">recovery</option>
                <option value="recovery_b">recovery_b</option>
                <option value="recovery_a">recovery_a</option>
                <option value="boot">boot</option>
                <option value="boot_a">boot_a</option>
                <option value="boot_b">boot_b</option>
            </param>
        <set>fastboot flash $test "${img:="$img2"}"</set>
        <params>
            <param name="img" type="file" suffix="img" editable="true" required="true" title="可输入IMG文件绝对路径，也可以使用文件选择器选择文件" desc="" />
        </params>
    </action>
    


    <action>
        <title>刷入镜像</title>
        <param name="imagePath" label="镜像文件路径" type="text" desc="输入要刷入的镜像文件的绝对路径" />
        <param name="partitionName" label="分区名称" type="text" desc="输入要刷入的分区名称" />
        <set><![CDATA[
            if [ -n "$imagePath" ] && [ -n "$partitionName" ]; then
                fastboot flash $partitionName "$imagePath"
                echo "已使用Fastboot刷入镜像：$imagePath 到分区：$partitionName"
            else
                echo "未输入镜像文件路径或分区名称"
            fi
        ]]></set>
    </action>

    <action>
        <title>分区格式化</title>
        <param name="formatPartitionName" label="要格式化的分区名称" type="text" desc="输入要格式化的分区名称" />
        <set><![CDATA[
            if [ -n "$formatPartitionName" ]; then
                fastboot format $formatPartitionName
                echo "已使用Fastboot格式化分区：$formatPartitionName"
            else
                echo "未输入要格式化的分区名称"
            fi
        ]]></set>
    </action>
    </group>
    
    
    <group title="Recovery支持所有">    
    <action>
        <title>TWRP线刷 ROM</title>
        <param name="romZipPath" label="ROM ZIP 文件路径" type="text" desc="输入要刷入的 ROM ZIP 文件的绝对路径" />
        <set><![CDATA[
            if [ -n "$romZipPath" ]; then
                adb push "$romZipPath" /sdcard/
                adb shell twrp install /sdcard/$(basename "$romZipPath")
                echo "已使用 TWRP 刷入 ROM：$romZipPath"
            else
                echo "未输入 ROM ZIP 文件路径"
            fi
        ]]></set>
    </action>

    <action>
        <title>TWRP刷入镜像</title>
        <param name="twrpImageToFlashPath" label="要刷入的镜像文件路径" type="text" desc="输入要刷入的镜像文件的绝对路径" />
        <param name="twrpPartitionToFlash" label="分区名称" type="text" desc="输入要刷入的分区名称" />
        <set><![CDATA[
            if [ -n "$twrpImageToFlashPath" ] && [ -n "$twrpPartitionToFlash" ]; then
                adb push "$twrpImageToFlashPath" /sdcard/
                adb shell twrp install /sdcard/$(basename "$twrpImageToFlashPath")
                echo "已使用 TWRP 刷入镜像：$twrpImageToFlashPath 到分区：$twrpPartitionToFlash"
            else
                echo "未输入镜像文件路径或分区名称"
            fi
        ]]></set>
    </action>

    <action>
        <title>TWRP分区格式化</title>
        <param name="twrpFormatPartitionName" label="要格式化的分区名称" type="text" desc="输入要格式化的分区名称" />
        <set><![CDATA[
            if [ -n "$twrpFormatPartitionName" ]; then
                adb shell twrp wipe "$twrpFormatPartitionName"
                echo "已使用 TWRP 格式化分区：$twrpFormatPartitionName"
            else
                echo "未输入要格式化的分区名称"
            fi
        ]]></set>
    </action>

    </group>
</items>
