// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'deeds_summary_cubit.dart';

sealed class DeedsSummaryState extends Equatable {
  const DeedsSummaryState();

  @override
  List<Object> get props => [];
}

final class DeedsSummaryLoading extends DeedsSummaryState {}

final class DeedsSummaryLoaded extends DeedsSummaryState {
  final int totalDays;
  final List<StatsElement> obligatoryElements;
  final List<StatsElement> additionalElements;
  final List<StatsElement> awradElements;
  final StatsElement fastingElement;

  const DeedsSummaryLoaded({
    required this.totalDays,
    required this.obligatoryElements,
    required this.additionalElements,
    required this.awradElements,
    required this.fastingElement,
  });

  @override
  List<Object> get props {
    return [
      totalDays,
      obligatoryElements,
      additionalElements,
      awradElements,
      fastingElement,
    ];
  }

  DeedsSummaryLoaded copyWith({
    int? totalDays,
    List<StatsElement>? obligatoryElements,
    List<StatsElement>? additionalElements,
    List<StatsElement>? awradElements,
    StatsElement? fastingElement,
  }) {
    return DeedsSummaryLoaded(
      totalDays: totalDays ?? this.totalDays,
      obligatoryElements: obligatoryElements ?? this.obligatoryElements,
      additionalElements: additionalElements ?? this.additionalElements,
      awradElements: awradElements ?? this.awradElements,
      fastingElement: fastingElement ?? this.fastingElement,
    );
  }
}
