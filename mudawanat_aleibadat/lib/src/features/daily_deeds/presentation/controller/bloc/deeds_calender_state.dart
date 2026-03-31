part of 'deeds_calender_bloc.dart';

sealed class DeedsCalenderState extends Equatable {
  const DeedsCalenderState();

  @override
  List<Object> get props => [];
}

final class DeedsCalenderLoadingState extends DeedsCalenderState {}

final class DeedsCalenderLoadedState extends DeedsCalenderState {
  final Map<DateTime, bool> dataCollection;
  final List<DailyDeeds> deeds;

  const DeedsCalenderLoadedState({
    required this.dataCollection,
    required this.deeds,
  });

  DeedsCalenderLoadedState copyWith({
    Map<DateTime, bool>? dataCollection,
    List<DailyDeeds>? deeds,
  }) {
    return DeedsCalenderLoadedState(
      dataCollection: dataCollection ?? this.dataCollection,
      deeds: deeds ?? this.deeds,
    );
  }

  @override
  List<Object> get props => [dataCollection, deeds];
}
