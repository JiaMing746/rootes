# This script is from Github@entr0pia, thanks to him.

function squoosh_libs() {
  echo "如果出现了什么错误信息，这是正常的，因为它正在被使用"
  for lib in $1; do
    echo "正在卸载 $lib"
    pm uninstall $lib
  done
}

if [ "$(whoami)" != "shell" ]; then
  echo "原脚本有个19秒的等待时间，很遗憾我不知道它在等什么，所以不敢去掉，麻烦你们也等一等"
  sleep 19
fi

webview_stat=$(dumpsys webviewupdate)
current_ver=$(echo "$webview_stat" | grep 'Current WebView package' | grep -oE '[0-9\.]{2,}')
current_code=$(echo "$webview_stat" | grep "$current_ver" | grep -oE '[0-9]{9}')

tri_libs=$(dumpsys -t 1 package | grep -E 'name.*version:[0-9]*' | sed "s/[ ]version:/_/g; s/name://g; /$current_code/d")
squoosh_libs "$tri_libs" | tee "/data/local/tmp/trichromelibrary-squoosh.log"