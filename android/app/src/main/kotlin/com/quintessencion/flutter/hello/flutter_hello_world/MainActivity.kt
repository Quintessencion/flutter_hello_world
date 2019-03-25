package com.quintessencion.flutter.hello.flutter_hello_world

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import android.os.BatteryManager
import android.content.Intent
import android.content.IntentFilter
import android.content.ContextWrapper
import android.content.Context.BATTERY_SERVICE
import android.os.Build.VERSION_CODES
import android.os.Build.VERSION

import android.net.Uri

class MainActivity : FlutterActivity() {

    companion object {
        const val DEEP_LINKING_CHANNEL = "cost_controller.flutter.io/deep_linking"
    }

    var data: Uri? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, DEEP_LINKING_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getDeepLinkingKey") {
                result.success(getDeeplinkingKey())
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onNewIntent(intent: Intent?) {
        super.onNewIntent(intent)
        data = intent?.data
    }

    private fun getDeeplinkingKey() = data.toString()
}
