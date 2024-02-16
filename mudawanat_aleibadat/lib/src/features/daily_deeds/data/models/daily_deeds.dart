// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mudawanat_aleibadat/src/core/extension/date_time.dart';
import 'package:mudawanat_aleibadat/src/core/extension/extension_bool.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/models/additional_prayers.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/models/daily_awrad.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/models/obligatory_prayer.dart';

class DailyDeeds extends Equatable {
  final DailyAdditionalPrayers additionalPrayers;
  final DailyObligatoryPrayers obligatoryPrayers;
  final DailyAwrad awrad;
  final bool fasting;
  final DateTime date;
  final DateTime lastUpdated;

  const DailyDeeds({
    required this.additionalPrayers,
    required this.obligatoryPrayers,
    required this.fasting,
    required this.awrad,
    required this.date,
    required this.lastUpdated,
  });

  const DailyDeeds.empty({
    this.fasting = false,
    required this.date,
  })  : awrad = const DailyAwrad.empty(),
        additionalPrayers = const DailyAdditionalPrayers.empty(),
        obligatoryPrayers = const DailyObligatoryPrayers.empty(),
        lastUpdated = date;

  DailyDeeds copyWith({
    DailyAwrad? awrad,
    DailyAdditionalPrayers? additionalPrayers,
    DailyObligatoryPrayers? obligatoryPrayers,
    bool? fasting,
    DateTime? date,
    DateTime? lastUpdated,
  }) {
    return DailyDeeds(
      additionalPrayers: additionalPrayers ?? this.additionalPrayers,
      obligatoryPrayers: obligatoryPrayers ?? this.obligatoryPrayers,
      fasting: fasting ?? this.fasting,
      date: date ?? this.date,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      awrad: awrad ?? this.awrad,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ...awrad.toMap(),
      ...additionalPrayers.toMap(),
      ...obligatoryPrayers.toMap(),
      'fasting': fasting.toInt(),
      'date': date.dateOnly.millisecondsSinceEpoch,
      'lastUpdated': lastUpdated.millisecondsSinceEpoch,
    };
  }

  factory DailyDeeds.fromMap(Map<String, dynamic> map) {
    return DailyDeeds(
      additionalPrayers: DailyAdditionalPrayers.fromMap(
        map,
      ),
      obligatoryPrayers: DailyObligatoryPrayers.fromMap(
        map,
      ),
      awrad: DailyAwrad.fromMap(
        map,
      ),
      fasting: map['fasting'] == 1,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int).dateOnly,
      lastUpdated:
          DateTime.fromMillisecondsSinceEpoch(map['lastUpdated'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyDeeds.fromJson(String source) =>
      DailyDeeds.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props {
    return [
      additionalPrayers,
      obligatoryPrayers,
      awrad,
      fasting,
      date,
      lastUpdated,
    ];
  }
}
