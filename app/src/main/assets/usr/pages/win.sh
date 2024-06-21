<?xml version="1.0" encoding="utf-8"?>
<!-- START -->
<group>
    <text>
        <slices>
            <slice size="18" color="#FFFF0000">目前实验测试，如果不可用请反馈作者！</slice>
        </slices>
    </text>
    </group>
<!-- END -->
<!-- START -->
<group>
  <action>
        <title>重启到Windows</title>
        <desc></desc>
        <set>dd if="${img:="$img2"}" /dev/block/bootdevice/by-name/boot_$SLOT
        echo 为了防止您的资源没有保存，请手动重启</set>
        <params>
            <param name="img" type="file" suffix="img" editable="true" required="true" title="选择您的Mindows引导镜像（boot）" desc="" />
        
        <param name="SLOT" label="您现在的android槽" type="text" desc="输a或者b，必须小写" />
        </params>
    </action>
   </group>
   <!-- END -->
<!-- START -->
   <group>
    <action>
        <title>挂载共享空间</title>
        <desc>功能实验，如果不可用请联系开发者</desc>
        <set>mkdir /data/mindows
mount -t ntfs /dev/block/bootdevice/by-name/$cd $fq</set>
            <param name="cd" desc="系统盘" label="" type="enum" required="required">
                <option value="mindowswin">C盘</option>
                <option value="mindowsdat">D盘</option>
            </param>
            
            <param name="fq" desc="挂载位置" label="" type="enum" required="required">
                <option value="/data/mindows">/data/mindows</option>
                <option value="/data/media/$ANDROID_UID/">/sdcard</option>
                <option value="/mnt/">/mnt/</option>
            </param>
    </action>
    </group>
<!-- END -->