import 'package:flutter/material.dart';

extension HexColorConvertor on Color {
  Color get getContrastColor {
    final luminance = computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
