import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mudawanat_alsala/src/core/constants/constants.dart';
import 'package:mudawanat_alsala/src/core/utils/print.dart';

class LocalStorageRepo {
  static late final Box _box;

  static Future init() async {
    _box = await Hive.openBox(kHiveBoxName);
  }

  ///* ******* App folder path ******* */
  static const String appFolderPathKey = "appFolderPath";
  static String? get appFolderPath {
    return _box.get(appFolderPathKey) as String?;
  }

  static Future<void> changeAppFolderPath({required String value}) async =>
      _box.put(appFolderPathKey, value);

  ///* ******* desktop Window Size ******* */
  static const String desktopWindowSizeKey = "desktopWindowSize";
  static Size? get desktopWindowSize {
    try {
      final data = jsonDecode(_box.get(desktopWindowSizeKey) as String? ?? "{}")
          as Map<String, dynamic>;

      final double width = (data['width'] as num).toDouble();
      final double height = (data['height'] as num).toDouble();

      return Size(width, height);
    } catch (e) {
      changeDesktopWindowSize(const Size(400, 800));
      appPrint(e);
    }
    return null;
  }

  static Future<void> changeDesktopWindowSize(Size value) async {
    final screenSize = {
      'width': value.width,
      'height': value.height,
    };
    final String data = jsonEncode(screenSize);
    return _box.put(desktopWindowSizeKey, data);
  }
}
