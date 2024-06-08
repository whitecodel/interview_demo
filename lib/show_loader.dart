import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void showLoader(context) async {
  // Get.closeAllSnackbars();

  return showDialog(
    context: context!,
    barrierDismissible: false,
    builder: (context) => PopScope(
      canPop: kDebugMode,
      child: Container(
        color: Colors.black26,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Center(
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    ),
  );
}
