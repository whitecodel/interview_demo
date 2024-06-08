package com.example.interview_demo

import com.scottyab.rootbeer.RootBeer
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                    if (call.method == "isRooted") {
                        val rootBeer = RootBeer(applicationContext)
                        result.success(rootBeer.isRooted)
                    } else {
                        result.notImplemented()
                    }
                }
    }

    companion object {
        private const val CHANNEL = "root_checker_channel"
    }
}
