package com.root.system

import android.app.Activity
import com.omarea.common.shell.KeepShellPublic
import com.omarea.common.ui.DialogHelper
import android.view.View

class DialogPower(var context: Activity) {
    fun showPowerMenu() {
        val view = context.layoutInflater.inflate(R.layout.dialog_power_operation, null)
        val dialog = DialogHelper.customDialog(context, view)

        // Function to execute power operation
        fun executePowerOperation(cmd: String) {
            dialog.dismiss()
            KeepShellPublic.doCmdSync(cmd)
        }

        // Set up click listeners with confirmation dialog
        view.findViewById<View>(R.id.power_shutdown).setOnClickListener {
            DialogHelper.confirm(
                context,
                "是否确定选择操作？",
                onConfirm = DialogHelper.DialogButton("是", Runnable {
                    executePowerOperation(context.getString(R.string.power_shutdown_cmd))
                }),
                onCancel = DialogHelper.DialogButton("否")
            )
        }

        view.findViewById<View>(R.id.power_reboot).setOnClickListener {
            DialogHelper.confirm(
                context,
                "是否确定选择操作？",
                onConfirm = DialogHelper.DialogButton("是", Runnable {
                    executePowerOperation(context.getString(R.string.power_reboot_cmd))
                }),
                onCancel = DialogHelper.DialogButton("否")
            )
        }

        view.findViewById<View>(R.id.power_hot_reboot).setOnClickListener {
            DialogHelper.confirm(
                context,
                "是否确定选择操作？",
                onConfirm = DialogHelper.DialogButton("是", Runnable {
                    executePowerOperation(context.getString(R.string.power_hot_reboot_cmd))
                }),
                onCancel = DialogHelper.DialogButton("否")
            )
        }

        view.findViewById<View>(R.id.power_recovery).setOnClickListener {
            DialogHelper.confirm(
                context,
                "是否确定选择操作？",
                onConfirm = DialogHelper.DialogButton("是", Runnable {
                    executePowerOperation(context.getString(R.string.power_recovery_cmd))
                }),
                onCancel = DialogHelper.DialogButton("否")
            )
        }

        view.findViewById<View>(R.id.power_fastboot).setOnClickListener {
            DialogHelper.confirm(
                context,
                "是否确定选择操作？",
                onConfirm = DialogHelper.DialogButton("是", Runnable {
                    executePowerOperation(context.getString(R.string.power_fastboot_cmd))
                }),
                onCancel = DialogHelper.DialogButton("否")
            )
        }

        view.findViewById<View>(R.id.power_emergency).setOnClickListener {
            DialogHelper.confirm(
                context,
                "是否确定选择操作？",
                onConfirm = DialogHelper.DialogButton("是", Runnable {
                    executePowerOperation(context.getString(R.string.power_emergency_cmd))
                }),
                onCancel = DialogHelper.DialogButton("否")
            )
        }
    }
}