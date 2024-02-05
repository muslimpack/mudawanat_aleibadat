// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'deeds_calender_bloc.dart';

sealed class DeedsCalenderEvent extends Equatable {
  const DeedsCalenderEvent();

  @override
  List<Object> get props => [];
}

class DeedsCalenderStartEvent extends DeedsCalenderEvent {}

class DeedsCalenderLoadDataEvent extends DeedsCalenderEvent {}

class DeedsCalenderOnTapEvent extends DeedsCalenderEvent {
  final CalendarTouchDetails details;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const DeedsCalenderOnTapEvent({
    required this.details,
    required this.scaffoldKey,
  });
}

class DeedsCalenderOnLongTapEvent extends DeedsCalenderEvent {
  final CalendarTouchDetails details;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const DeedsCalenderOnLongTapEvent({
    required this.details,
    required this.scaffoldKey,
  });
}

class DeedsCalenderEditEvent extends DeedsCalenderEvent {
  final CalendarTouchDetails details;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const DeedsCalenderEditEvent({
    required this.details,
    required this.scaffoldKey,
  });
}
