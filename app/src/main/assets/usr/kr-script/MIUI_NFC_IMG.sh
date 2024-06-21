#!/bin/sh
echo '<?xml version="1.0" encoding="utf-8"?>'
NFC_PATH="/data/user/0/com.miui.tsmclient/cache/image_manager_disk_cache"
build()
{
	cat <<-EOF
		<group>
			<action reload="true" icon="$1">
				<title>${TITLE}</title>
				<desc>$2</desc>
				<param
					title="备注"
					name="RENAME"
					type="text"/>
				<param
					label="重置图片"
					name="RELOAD"
					type="switch"/>
				<param
					title="更换图片"
					name="CARDFILE"
					type="file"
					suffix="png"
					editable="true"/>
				<set>
					#重命名
					if [[ -n &#34;\${RENAME}&#34; ]]; then
						echo \${RENAME} > ${TEMP_DIR}/${1##*/}
					fi
					#更换图片
					if [[ -f &#34;\${CARDFILE}&#34; ]]; then
						file &#34;\${CARDFILE}&#34; | grep 'PNG' > /dev/null
						if [[ \$? -eq 0 ]]; then
							cp -f &#34;\${CARDFILE}&#34; $1
							chmod -w $1
							am start -S com.miui.tsmclient/.ui.quick.DoubleClickActivity
						else
							echo '请选择PNG格式的图片'
						fi
					fi
					#重置图片
					if [[ \${RELOAD} -eq 1 ]]; then
						rm -f $1
						am start -S com.miui.tsmclient/.ui.quick.DoubleClickActivity
					fi
				</set>
			</action>
		</group>
	EOF
}

ls ${NFC_PATH}/*.0 | while read line
do
	file ${line} | grep "PNG" > /dev/null
	if [[ $? -eq 0 ]]; then
		if [[ -f ${TEMP_DIR}/${line##*/} ]]; then
			TITLE="$(cat ${TEMP_DIR}/${line##*/} | head -n 1)"
		else
			TITLE="${line##*/}"
		fi
		WH=$(file ${line} | egrep -o "[0-9 ]+x[0-9 ]+")
		build ${line} "${WH}"
	fi
done