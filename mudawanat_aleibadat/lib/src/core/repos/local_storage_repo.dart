import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mudawanat_aleibadat/src/core/constants/constants.dart';
import 'package:mudawanat_aleibadat/src/core/utils/print.dart';

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

  ///* ******* Themes ******* */
  static const String brightnessKey = "ThemeBrightness";

  static Brightness getBrightness() {
    final String? brightness = _box.get(brightnessKey) as String?;
    return brightness == Brightness.light.toString()
        ? Brightness.light
        : Brightness.dark;
  }

  static Future setBrightness(Brightness brightness) async {
    await _box.put(brightnessKey, brightness.toString());
  }

  static const String themeUseMaterial3Key = "themeUseMaterial3";

  static bool getUseMaterial3() {
    final bool? useMaterial3 = _box.get(themeUseMaterial3Key) as bool?;
    return useMaterial3 ?? true;
  }

  static Future setUseMaterial3(bool useMaterial3) async {
    await _box.put(themeUseMaterial3Key, useMaterial3);
  }

  static const String useOldThemeKey = "themeUseOldTheme";

  static bool getUseOldTheme() {
    final bool? useOldTheme = _box.get(useOldThemeKey) as bool?;
    return useOldTheme ?? false;
  }

  static Future setUseOldTheme(bool useOldTheme) async {
    await _box.put(useOldThemeKey, useOldTheme);
  }

  static const String themeColorKey = "ThemeColor";

  static Color getColor() {
    final int? colorValue = _box.get(themeColorKey) as int?;
    return colorValue != null ? Color(colorValue) : Colors.brown;
  }

  static Future setColor(Color color) async {
    await _box.put(themeColorKey, color.value);
  }

  ///* ******* app language ******* */

  static const String _localeKey = "locale";
  static Locale? getLocale() {
    final value = _box.get(_localeKey) as String?;
    if (value == null) return null;
    return Locale(value);
  }

  static Future changeLocale(Locale locale) async {
    return _box.put(_localeKey, locale.languageCode);
  }
}
