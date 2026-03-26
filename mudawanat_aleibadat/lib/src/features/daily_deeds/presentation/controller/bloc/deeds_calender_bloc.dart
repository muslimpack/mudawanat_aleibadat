// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/data_source/daily_deeds_repo.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/models/daily_deeds.dart';

part 'deeds_calender_event.dart';
part 'deeds_calender_state.dart';

class DeedsCalenderBloc extends Bloc<DeedsCalenderEvent, DeedsCalenderState> {
  DeedsCalenderBloc() : super(DeedsCalenderLoadingState()) {
    on<DeedsCalenderStartEvent>(_start);
    on<DeedsCalenderLoadDataEvent>(_loadData);
    on<DeedsCalenderUpdateDeedEvent>(_onUpdateDeed);
  }

  Future<void> _start(
    DeedsCalenderStartEvent event,
    Emitter<DeedsCalenderState> emit,
  ) async {
    await dailyDeedsRepo.addMissingDays();

    add(DeedsCalenderLoadDataEvent());
  }

  Future<void> _loadData(
    DeedsCalenderLoadDataEvent event,
    Emitter<DeedsCalenderState> emit,
  ) async {
    final Map<DateTime, bool> dataCollection;
    final List<DailyDeeds> deeds;

    final state = this.state;
    if (state is DeedsCalenderLoadedState) {
      dataCollection = Map.of(state.dataCollection);
      deeds = List.of(state.deeds);
    } else {
      dataCollection = {};
      deeds = [];
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

    // Filter out duplicates before adding
    for (final deed in loadedDeeds) {
      if (!deeds.any((d) => d.date == deed.date)) {
        deeds.add(deed);
      }
    }

    emit(
      DeedsCalenderLoadedState(
        dataCollection: dataCollection,
        deeds: deeds,
      ),
    );
  }

  Future<void> _onUpdateDeed(
    DeedsCalenderUpdateDeedEvent event,
    Emitter<DeedsCalenderState> emit,
  ) async {
    final state = this.state;
    if (state is! DeedsCalenderLoadedState) return;

    final result = event.deed;
    final dateTimeToEdit = result.date;

    await dailyDeedsRepo.insertDailyDeeds(result);

    final Map<DateTime, bool> dataCollection = Map.of(state.dataCollection);
    final List<DailyDeeds> deeds = List.of(state.deeds);

    deeds.removeWhere((deed) => deed.date == dateTimeToEdit);
    deeds.add(result);

    emit(
      DeedsCalenderLoadedState(
        dataCollection: dataCollection,
        deeds: deeds,
      ),
    );
  }
}
