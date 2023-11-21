import 'dart:async';

import 'package:flutter/services.dart';

class MajaScan {
  static const MethodChannel _channel = MethodChannel('majascan');
  static const cameraAccessDenied = 'PERMISSION_NOT_GRANTED';

  static Future<String?> startScan({
    String title = "",
    bool flashlightEnable = true,
    Color? barColor,
    Color? titleColor,
    Color? qRCornerColor,
    Color? qRScannerColor,
    double scanAreaScale = 0.7,
  }) async {
    int flashlight = (flashlightEnable ? 1 : 0);

    Map<String, String> scanArgs = {
      ScanArgs.title: title,
      ScanArgs.flastlight: flashlight.toString(),
      ScanArgs.scanAreaScale: scanAreaScale.toString(),
    };

    if (barColor != null) {
      scanArgs[ScanArgs.barColor] = '#${barColor.value.toRadixString(16)}';
    }

    if (titleColor != null) {
      scanArgs[ScanArgs.titleColor] = '#${titleColor.value.toRadixString(16)}';
    }

    if (qRCornerColor != null) {
      scanArgs[ScanArgs.qrCornerColor] = '#${qRCornerColor.value.toRadixString(16)}';
    }

    if (qRScannerColor != null) {
      scanArgs[ScanArgs.qrScannerColor] = '#${qRScannerColor.value.toRadixString(16)}';
    }

    final String? result = await _channel.invokeMethod('scan', scanArgs);
    return result;
  }
}

class ScanArgs {
  static const flastlight = "FLASHLIGHT";
  static const title = "TITLE";
  static const titleColor = "TITLE_COLOR";
  static const barColor = "BAR_COLOR";
  static const qrCornerColor = "QR_CORNER_COLOR";
  static const qrScannerColor = "QR_SCANNER_COLOR";
  static const scanAreaScale = "SCAN_AREA_SCALE";
}
