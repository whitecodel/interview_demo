import 'package:flutter/services.dart';

class RootChecker {
  static const platform = MethodChannel('root_checker_channel');

  static Future<bool> isRooted() async {
    try {
      final bool isRooted = await platform.invokeMethod('isRooted');
      return isRooted;
    } on PlatformException catch (e) {
      print("Failed to check root status: '${e.message}'.");
      return false;
    }
  }
}
