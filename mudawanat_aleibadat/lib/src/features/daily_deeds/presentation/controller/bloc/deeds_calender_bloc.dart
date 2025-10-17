// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/src/core/shared/loading.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/data_source/daily_deeds_repo.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/data_source/sf_data_source.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/models/daily_deeds.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/models/daily_deeds_extension.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/models/slot.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/components/editor/daily_deeds_editor.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'deeds_calender_event.dart';
part 'deeds_calender_state.dart';

class DeedsCalenderBloc extends Bloc<DeedsCalenderEvent, DeedsCalenderState> {
  late final CalendarController controller;

  DeedsCalenderBloc() : super(DeedsCalenderLoadingState()) {
    on<DeedsCalenderStartEvent>(_start);
    on<DeedsCalenderLoadDataEvent>(_loadData);
    on<DeedsCalenderOnTapEvent>(_onTap);
    on<DeedsCalenderOnLongTapEvent>(_onLongTap);
    on<DeedsCalenderEditEvent>(_edit);
  }

  Future<void> _start(
    DeedsCalenderStartEvent event,
    Emitter<DeedsCalenderState> emit,
  ) async {
    controller = CalendarController();

    await dailyDeedsRepo.addMissingDays();

    add(DeedsCalenderLoadDataEvent());
  }

  Future<void> _loadData(
    DeedsCalenderLoadDataEvent event,
    Emitter<DeedsCalenderState> emit,
  ) async {
    final Map<DateTime, bool> dataCollection;
    final List<Slot> slots;
    final CalendarDataSource dataSource;

    final state = this.state;
    if (state is DeedsCalenderLoadedState) {
      dataCollection = Map.of(state.dataCollection);
      slots = List.of(state.slots);
    } else {
      dataCollection = {};
      slots = [];
    }

    final loadedDeeds = await dailyDeedsRepo.getDailyDeedsByDateRange(
      DateTime.now().subtract(
        const Duration(
          days: 30,
        ),
      ),
      DateTime.now().add(
        const Duration(
          days: 1,
        ),
      ),
    );

    final map = {for (final e in loadedDeeds) e.date: true};
    dataCollection.addAll(map);

    slots.addAll(loadedDeeds.convertToSlot());

    dataSource = SlotsDataSourceLoadMore(slots, dataCollection);

    emit(
      DeedsCalenderLoadedState(
        dataCollection: dataCollection,
        slots: slots,
        dataSource: dataSource,
      ),
    );
  }

  Future<void> _onTap(
    DeedsCalenderOnTapEvent event,
    Emitter<DeedsCalenderState> emit,
  ) async {
    final List<CalendarElement> allowToTouch = [
      CalendarElement.appointment,
      CalendarElement.calendarCell,
    ];

    if (!allowToTouch.contains(event.details.targetElement)) {
      return;
    }

    add(
      DeedsCalenderEditEvent(
        details: event.details,
        scaffoldKey: event.scaffoldKey,
      ),
    );
  }

  Future<void> _onLongTap(
    DeedsCalenderOnLongTapEvent event,
    Emitter<DeedsCalenderState> emit,
  ) async {
    final List<CalendarElement> allowToTouch = [
      // CalendarElement.appointment,
      CalendarElement.calendarCell,
    ];

    if (!allowToTouch.contains(event.details.targetElement)) {
      return;
    }

    add(
      DeedsCalenderEditEvent(
        details: event.details,
        scaffoldKey: event.scaffoldKey,
      ),
    );
  }

  Widget loadMoreBuilder(
    BuildContext context,
    LoadMoreCallback loadMoreAppointments,
  ) {
    return FutureBuilder<void>(
      future: loadMoreAppointments(),
      builder: (context, snapShot) {
        return const Loading();
      },
    );
  }

  Future<void> _edit(
    DeedsCalenderEditEvent event,
    Emitter<DeedsCalenderState> emit,
  ) async {
    final state = this.state;
    if (state is! DeedsCalenderLoadedState) return;

    final details = event.details;
    final DateTime? dateTimeToEdit;
    if (details.targetElement == CalendarElement.appointment) {
      dateTimeToEdit = (details.appointments?.first as Slot).id;
    } else {
      dateTimeToEdit = details.date;
    }

    if (dateTimeToEdit == null) return;

    final DailyDeeds? result = await showDialog(
      barrierDismissible: false,
      context: event.scaffoldKey.currentContext!,
      builder: (BuildContext context) {
        return DailyDeedsEditor.byDateTime(
          dateTime: dateTimeToEdit!,
        );
      },
    );

    if (result == null) return;

    await dailyDeedsRepo.insertDailyDeeds(result);

    final Map<DateTime, bool> dataCollection;
    final List<Slot> slots;
    final CalendarDataSource dataSource;

    dataCollection = Map.of(state.dataCollection);
    slots = List.of(state.slots);

    slots.removeWhere((slot) => slot.id == dateTimeToEdit);
    slots.addAll(result.allSlots());
    dataSource = SlotsDataSourceLoadMore(slots, dataCollection);

    emit(
      DeedsCalenderLoadedState(
        dataCollection: dataCollection,
        slots: slots,
        dataSource: dataSource,
      ),
    );
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
