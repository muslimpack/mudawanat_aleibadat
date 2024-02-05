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
}
