// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mudawanat_aleibadat/src/core/extension/extension_bool.dart';

class DailyAwrad extends Equatable {
  final bool azkar;
  final int quran;

  const DailyAwrad({
    required this.azkar,
    required this.quran,
  });

  const DailyAwrad.empty({
    this.azkar = false,
    this.quran = 0,
  });

  DailyAwrad copyWith({
    bool? azkar,
    int? quran,
  }) {
    return DailyAwrad(
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

  factory DailyAwrad.fromMap(Map<String, dynamic> map) {
    return DailyAwrad(
      azkar: map['azkar'] == 1,
      quran: map['quran'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyAwrad.fromJson(String source) =>
      DailyAwrad.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [azkar, quran];
}
