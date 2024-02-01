// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:mudawanat_aleibadat/src/core/extension/extension_bool.dart';

class DailyWird {
  final bool azkar;
  final int quran;

  DailyWird({
    required this.azkar,
    required this.quran,
  });

  DailyWird copyWith({
    bool? azkar,
    int? quran,
  }) {
    return DailyWird(
      azkar: azkar ?? this.azkar,
      quran: quran ?? this.quran,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'azkar': azkar.toInt(),
      'quran': quran,
    };
  }

  factory DailyWird.fromMap(Map<String, dynamic> map) {
    return DailyWird(
      azkar: map['azkar'] == 1,
      quran: map['quran'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyWird.fromJson(String source) =>
      DailyWird.fromMap(json.decode(source) as Map<String, dynamic>);
}
