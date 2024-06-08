import UIKit
import Flutter
import IOSSecuritySuite

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller = window?.rootViewController as! FlutterViewController
    let jailbreakChannel = FlutterMethodChannel(name: "root_checker_channel",
                                                binaryMessenger: controller.binaryMessenger)
    
    jailbreakChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "isRooted" {
        result(IOSSecuritySuite.amIJailbroken())
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
