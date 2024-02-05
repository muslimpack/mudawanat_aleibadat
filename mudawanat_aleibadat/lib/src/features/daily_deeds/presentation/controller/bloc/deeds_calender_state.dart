part of 'deeds_calender_bloc.dart';

sealed class DeedsCalenderState extends Equatable {
  const DeedsCalenderState();

  @override
  List<Object> get props => [];
}

final class DeedsCalenderLoadingState extends DeedsCalenderState {}

final class DeedsCalenderLoadedState extends DeedsCalenderState {
  final Map<DateTime, bool> dataCollection;
  final List<Slot> slots;
  final CalendarDataSource dataSource;

  const DeedsCalenderLoadedState({
    required this.dataCollection,
    required this.slots,
    required this.dataSource,
  });

  DeedsCalenderLoadedState copyWith({
    Map<DateTime, bool>? dataCollection,
    List<Slot>? slots,
    CalendarDataSource? dataSource,
  }) {
    return DeedsCalenderLoadedState(
      dataCollection: dataCollection ?? this.dataCollection,
      slots: slots ?? this.slots,
      dataSource: dataSource ?? this.dataSource,
    );
  }

  @override
  List<Object> get props => [dataCollection, slots, dataSource];
}
