<?xml version="1.0" encoding="utf-8"?>
<resource dir="file:///android_asset/Configuration_File/" />
<group>
    <!-- START -->
    
    <text>不一定非要使用软件的调度模块，可以使用你自己的模块</text>
    <action>
            <title>动态</title>
            <desc>自动选择模式</desc>
            <set>sh /data/powercfg.sh auto
            echo 出现No such file or directory就去安调度</set>
        </action>
        
        
    <action>
            <title>省电</title>
            <desc>老年人直呼</desc>
            <set>sh /data/powercfg.sh powersave
            echo 出现No such file or directory就去安调度</set>
        </action>
        
       
    <action>
            <title>均衡</title>
            <desc>平衡处理器，自动选择</desc>
            <set>sh /data/powercfg.sh balance
            echo 出现No such file or directory就去安调度</set>
        </action>
        
    <action>
            <title>性能</title>
            <desc>上分模式</desc>
            <set>sh /data/powercfg.sh performance
            echo 出现No such file or directory就去安调度</set>
        </action>
        
    <action>
            <title>极速</title>
            <desc>让手机起飞吧</desc>
            <set>sh /data/powercfg.sh fast
            echo 出现No such file or directory就去安调度</set>
        </action>
        
        
    <action interruptible="false">
        <title>帧率</title>
        <desc></desc>
        <param name="test" type="app" />
        <param name="test6" desc="只能输入数字" label="最小帧率" max="144" min="30"
                required="required" type="int" />
        <param name="test7" desc="只能输入数字" label="最大帧率" max="144" min="30"
                required="required" type="int" />
        <set>sed -i '$s/.*/'$test' '$test6' '$test7/'' /sdcard/Android/yc/dfps/dfps.txt</set>
    </action>
  
        
    <action interruptible="false">
        <title>应用调度</title>
        <desc></desc>
        <param name="test" type="app" />
        <param name="test6"> value="X">
                <option value="auto">动态</option>
                <option value="powersave">省电</option>
                <option value="balance">均衡</option>
                <option value="fast">极速</option>
                <option value="performance">性能</option>
            </param>
        <set>sed -i '$s/.*/'$test' '$test6/'' /sdcard/Android/yc/uperf/perapp_powermode.txt</set>
    </action>
  
  
<group>
         <action>
            <title>安装模块</title>
            
            <param name="test">
                <option value="magisk --install-module">Magisk</option>
                <option value="kernelsuinstall1">KernelSU</option>
            </param>
            
            <param name="test2">
                <option value="/data/data/com.root.system/files/usr/xbin/far2.zip">帧率</option>
                <option value="/data/data/com.root.system/files/usr/xbin/far.zip">调度</option>
            </param>
            <set>
            $test $test2
               </set>
        </action>
</group>

<group>
    
     <action>
        <title>导入配置文件</title>
        <desc></desc>
        <set>
        cp "${json:="$json2"}" /sdcard/Android/yc/uperf/</set>
        <params>
            <param name="json" type="file" suffix="json" editable="true" required="true" title="选择json" desc="" />
        </params>
    </action>
   
</group>