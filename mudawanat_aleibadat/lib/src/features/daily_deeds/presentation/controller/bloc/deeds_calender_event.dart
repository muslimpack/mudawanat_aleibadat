part of 'deeds_calender_bloc.dart';

sealed class DeedsCalenderEvent extends Equatable {
  const DeedsCalenderEvent();

  @override
  List<Object> get props => [];
}

class DeedsCalenderStartEvent extends DeedsCalenderEvent {}

class DeedsCalenderLoadDataEvent extends DeedsCalenderEvent {}

class DeedsCalenderUpdateDeedEvent extends DeedsCalenderEvent {
  final DailyDeeds deed;

  const DeedsCalenderUpdateDeedEvent(this.deed);

  @override
  List<Object> get props => [deed];
}
