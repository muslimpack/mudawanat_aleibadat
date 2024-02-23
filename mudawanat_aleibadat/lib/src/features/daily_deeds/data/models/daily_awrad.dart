// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class DailyAwrad extends Equatable {
  final int azkar;
  final int quran;

  const DailyAwrad({
    required this.azkar,
    required this.quran,
  });

  const DailyAwrad.empty({
    this.azkar = 0,
    this.quran = 0,
  });

  DailyAwrad copyWith({
    int? azkar,
    int? quran,
  }) {
    return DailyAwrad(
      azkar: azkar ?? this.azkar,
      quran: quran ?? this.quran,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'azkar': azkar,
      'quran': quran,
    };
  }

  factory DailyAwrad.fromMap(Map<String, dynamic> map) {
    return DailyAwrad(
      azkar: map['azkar'] as int,
      quran: map['quran'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyAwrad.fromJson(String source) =>
      DailyAwrad.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [azkar, quran];
}
