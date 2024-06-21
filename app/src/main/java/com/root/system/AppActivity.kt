package com.root.system

import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.drawable.Drawable
import android.net.Uri
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import java.io.DataOutputStream
import java.util.*

class AppActivity : AppCompatActivity() {

    private lateinit var runningAppsListView: ListView
    private lateinit var adapter: AppAdapter
    private lateinit var allRunningApps: List<RunningAppInfo>

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_app)

        runningAppsListView = findViewById(R.id.runningAppsListView)

        allRunningApps = getRunningApps()
        adapter = AppAdapter(this, allRunningApps)
        runningAppsListView.adapter = adapter

        runningAppsListView.setOnItemClickListener { _, _, position, _ ->
            val selectedRunningApp = adapter.getItem(position) as RunningAppInfo
            showAppOptionsDialog(selectedRunningApp)
        }
    }

    private fun filterApps(query: String) {
        val filteredApps = allRunningApps.filter {
            it.packageName.toLowerCase(Locale.getDefault()).contains(query.toLowerCase(Locale.getDefault()))
        }
        adapter.updateList(filteredApps)
    }

    private fun getRunningApps(): List<RunningAppInfo> {
        val runningApps = mutableListOf<RunningAppInfo>()

        val packageManager: PackageManager = packageManager
        val intent = Intent(Intent.ACTION_MAIN, null)
        intent.addCategory(Intent.CATEGORY_LAUNCHER)

        val resolveInfoList = packageManager.queryIntentActivities(intent, 0)
        for (resolveInfo in resolveInfoList) {
            val appInfo = resolveInfo.activityInfo.applicationInfo
            if ((appInfo.flags and ApplicationInfo.FLAG_SYSTEM) == 0) {
                val processName = appInfo.processName
                val packageName = appInfo.packageName
                val appName = appInfo.loadLabel(packageManager).toString()
                val appIcon = appInfo.loadIcon(packageManager)
                val packageUri = Uri.parse("package:$packageName")

                val processInfo = ActivityManager.RunningAppProcessInfo()
                processInfo.processName = processName

                runningApps.add(RunningAppInfo(processInfo, packageName, appName, appIcon, packageUri))
            }
        }

        return runningApps
    }
    
private fun showAppOptionsDialog(selectedRunningApp: RunningAppInfo) {
    val alertDialogBuilder = AlertDialog.Builder(this)
    alertDialogBuilder.setTitle("应用操作")
    alertDialogBuilder.setMessage("选择操作")

    alertDialogBuilder.setPositiveButton("冻结") { dialog, _ ->
        freezeApp(selectedRunningApp.packageName)
        dialog.dismiss()
    }

    alertDialogBuilder.setNeutralButton("冻结") { _, _ ->
        // Freeze the selected app
        freezeApp(selectedRunningApp.packageName)
    }

    alertDialogBuilder.setNegativeButton("卸载") { _, _ ->
        // Use the system uninstall intent
        val intent = Intent(Intent.ACTION_UNINSTALL_PACKAGE)
        intent.data = selectedRunningApp.packageUri
        startActivity(intent)
    }

    alertDialogBuilder.setNeutralButton("杀死") { _, _ ->
        // Kill the selected app
        killProcessWithRoot(selectedRunningApp.processInfo.processName)
    }

    val alertDialog = alertDialogBuilder.create()
    alertDialog.show()
}

    private fun killProcessWithRoot(processName: String) {
        try {
            val process = Runtime.getRuntime().exec("su")
            val outputStream = DataOutputStream(process.outputStream)
            outputStream.writeBytes("am force-stop $processName\n")
            outputStream.writeBytes("exit\n")
            outputStream.flush()
            outputStream.close()
            process.waitFor()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun freezeApp(packageName: String) {
    try {
        val process = Runtime.getRuntime().exec("su")
        val outputStream = DataOutputStream(process.outputStream)
        outputStream.writeBytes("pm disable $packageName\n")
        outputStream.writeBytes("exit\n")
        outputStream.flush()
        outputStream.close()
        process.waitFor()
    } catch (e: Exception) {
        e.printStackTrace()
    }
  }
}

data class RunningAppInfo(
    val processInfo: ActivityManager.RunningAppProcessInfo,
    val packageName: String,
    val appName: String,
    val appIcon: Drawable,
    val packageUri: Uri
)

class AppAdapter(context: Context, private var appList: List<RunningAppInfo>) :
    ArrayAdapter<RunningAppInfo>(context, R.layout.list_item_app, appList) {

    override fun getView(position: Int, convertView: View?, parent: ViewGroup): View {
        val itemView = convertView ?: LayoutInflater.from(context)
            .inflate(R.layout.list_item_app, parent, false)
        val appIconView: ImageView = itemView.findViewById(R.id.appIconView)
        val appNameView: TextView = itemView.findViewById(R.id.appNameView)
        val packageNameView: TextView = itemView.findViewById(R.id.packageNameView)

        val appInfo = getItem(position) as RunningAppInfo
        appIconView.setImageDrawable(appInfo.appIcon)
        appNameView.text = appInfo.appName
        packageNameView.text = appInfo.packageName

        return itemView
    }

    fun updateList(newList: List<RunningAppInfo>) {
        appList = newList
        notifyDataSetChanged()
    }
}
