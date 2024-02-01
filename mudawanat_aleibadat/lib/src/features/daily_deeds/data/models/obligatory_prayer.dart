import 'dart:convert';

import 'package:mudawanat_aleibadat/src/core/extension/extension_bool.dart';

class DailyObligatoryPrayers {
  final bool fajr;
  final bool dhuhr;
  final bool asr;
  final bool maghrib;
  final bool ishaa;

  DailyObligatoryPrayers({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.ishaa,
  });
  DailyObligatoryPrayers.empty({
    this.fajr = false,
    this.dhuhr = false,
    this.asr = false,
    this.maghrib = false,
    this.ishaa = false,
  });

  DailyObligatoryPrayers copyWith({
    bool? fajr,
    bool? dhuhr,
    bool? asr,
    bool? maghrib,
    bool? ishaa,
  }) {
    return DailyObligatoryPrayers(
      fajr: fajr ?? this.fajr,
      dhuhr: dhuhr ?? this.dhuhr,
      asr: asr ?? this.asr,
      maghrib: maghrib ?? this.maghrib,
      ishaa: ishaa ?? this.ishaa,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fajr': fajr.toInt(),
      'dhuhr': dhuhr.toInt(),
      'asr': asr.toInt(),
      'maghrib': maghrib.toInt(),
      'ishaa': ishaa.toInt(),
    };
  }

  factory DailyObligatoryPrayers.fromMap(Map<String, dynamic> map) {
    return DailyObligatoryPrayers(
      fajr: map['fajr'] == 1,
      dhuhr: map['dhuhr'] == 1,
      asr: map['asr'] == 1,
      maghrib: map['maghrib'] == 1,
      ishaa: map['ishaa'] == 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyObligatoryPrayers.fromJson(String source) =>
      DailyObligatoryPrayers.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
