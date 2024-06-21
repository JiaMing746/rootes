package com.root.system

import android.os.Bundle
import android.view.Gravity
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.root.system.AboutPage
import com.root.system.Element
import java.util.Calendar

class AboutActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val adsElement = Element()
        adsElement.title = "编译信息 root@localhost\n版本时间2024/2/6"

        val aboutPage = AboutPage(this)
            .isRTL(false)
            .setImage(R.drawable.dummy_image)
            .addItem(Element().setTitle("Version 2.0.0"))
            .addItem(adsElement)
            .addGroup("介绍:这是一个多功能玩机工具箱，原[搞机助手]，也采用了WearOS管家 kr-script XMLShellRoot 搞机助手源码驱动，一个给Root手机扩展，刷机，美化，自定义，免费开放，非官方版本可能会有危险！")
            .addEmail("rootsystemtools@163.com")
            .addWebsite("https://twmcy.github.io/")
            .addFacebook("31097469")
            .addTwitter("NO4zWlt")
            .addGitHub("twmcy")
            .addItem(getCopyRightsElement())
            .create()

        setContentView(aboutPage)
    }

    private fun getCopyRightsElement(): Element {
        val copyRightsElement = Element()
        val copyrights = getString(R.string.copy_right, Calendar.getInstance().get(Calendar.YEAR))
        copyRightsElement.title = copyrights
        copyRightsElement.iconDrawable = R.drawable.about_icon_copy_right
        copyRightsElement.iconTint = com.root.system.R.color.about_item_icon_color
        copyRightsElement.iconNightTint = android.R.color.white
        copyRightsElement.gravity = Gravity.CENTER
        copyRightsElement.setOnClickListener {
            Toast.makeText(this@AboutActivity, copyrights, Toast.LENGTH_SHORT).show()
        }
        return copyRightsElement
    }
}
