import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mudawanat_aleibadat/src/core/constants/deeds_columns.dart';
import 'package:mudawanat_aleibadat/src/core/extension/extension_string.dart';
import 'package:mudawanat_aleibadat/src/core/repos/local_storage_repo.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/data_source/daily_deeds_repo.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/controller/bloc/deeds_calender_bloc.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/data/models/plot_card_item.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/data/models/time_range.dart';

part 'deeds_statistics_state.dart';

class DeedsStatisticsCubit extends Cubit<DeedsStatisticsState> {
  final DeedsCalenderBloc deedsCalenderBloc;
  late StreamSubscription deedsCalenderSubscription;
  DeedsStatisticsCubit(this.deedsCalenderBloc)
      : super(DeedsStatisticsLoading()) {
    deedsCalenderSubscription = deedsCalenderBloc.stream.listen((event) {
      init();
    });
  }

  Future init() async {
    final TimeRange timeRange = LocalStorageRepo.getStatisticsTimeRange();
    await loadData(timeRange);
  }

  Future loadData(TimeRange timeRange) async {
    final totalDays = await dailyDeedsRepo.daysCount();

    final List<Future> futures = [
      _loadSeparatedAdditional(timeRange),
      _loadSeparatedObligatory(timeRange),
      _loadObligatory(timeRange),
      _loadAdditional(timeRange),
      _loadQuranData(timeRange),
      _loadAzkarData(timeRange),
    ];

    final List results = await Future.wait(futures);

    emit(
      DeedsStatisticsLoaded(
        timeRange: timeRange,
        totalDays: totalDays,
        additionalSeparatedSpots: results[0] as List<PlotCardItem>,
        obligatorySeparatedSpots: results[1] as List<PlotCardItem>,
        obligatorySpots: results[2] as List<FlSpot>,
        additionalSpots: results[3] as List<FlSpot>,
        quranSpots: results[4] as List<FlSpot>,
        azkarSpots: results[5] as List<FlSpot>,
      ),
    );
  }

  Future<List<FlSpot>> _loadObligatory(TimeRange timeRange) async {
    final List<FlSpot> spots = [];
    final map = await dailyDeedsRepo.getMapDateColumn(
      obligatoryColumn,
      timeRange.daysNumber(),
    );

    map.forEach((key, value) {
      spots.add(
        FlSpot(key.millisecondsSinceEpoch.toDouble(), value.toDouble()),
      );
    });

    return spots;
  }

  Future<List<PlotCardItem>> _loadSeparatedObligatory(
    TimeRange timeRange,
  ) async {
    final List<PlotCardItem> spots = [];

    for (final element in obligatoryColumn) {
      final spots0 = <FlSpot>[];
      final map = await dailyDeedsRepo
          .getMapDateColumn([element], timeRange.daysNumber());

      map.forEach((key, value) {
        spots0.add(
          FlSpot(key.millisecondsSinceEpoch.toDouble(), value.toDouble()),
        );
      });

      spots.add(
        PlotCardItem(
          label: element.readableColumnName(),
          spots: spots0,
        ),
      );
    }
    return spots;
  }

  Future<List<FlSpot>> _loadAdditional(TimeRange timeRange) async {
    final List<FlSpot> spots = [];
    final map = await dailyDeedsRepo.getMapDateColumn(
      additionalColumn,
      timeRange.daysNumber(),
    );

    map.forEach((key, value) {
      spots.add(
        FlSpot(key.millisecondsSinceEpoch.toDouble(), value.toDouble()),
      );
    });

    return spots;
  }

  Future<List<PlotCardItem>> _loadSeparatedAdditional(
    TimeRange timeRange,
  ) async {
    final List<PlotCardItem> spots = [];

    for (final element in additionalColumn) {
      final spots0 = <FlSpot>[];
      final map = await dailyDeedsRepo
          .getMapDateColumn([element], timeRange.daysNumber());

      map.forEach((key, value) {
        spots0.add(
          FlSpot(key.millisecondsSinceEpoch.toDouble(), value.toDouble()),
        );
      });

      spots.add(
        PlotCardItem(label: element.readableColumnName(), spots: spots0),
      );
    }

    return spots;
  }

  Future<List<FlSpot>> _loadQuranData(TimeRange timeRange) async {
    final List<FlSpot> spots = [];
    final quranMap = await dailyDeedsRepo
        .getMapDateColumn(["quran"], timeRange.daysNumber());
    quranMap.forEach((key, value) {
      spots.add(
        FlSpot(key.millisecondsSinceEpoch.toDouble(), value.toDouble()),
      );
    });

    return spots;
  }

  Future<List<FlSpot>> _loadAzkarData(TimeRange timeRange) async {
    final List<FlSpot> spots = [];

    final azkarMap = await dailyDeedsRepo
        .getMapDateColumn(["azkar"], timeRange.daysNumber());
    azkarMap.forEach((key, value) {
      spots.add(
        FlSpot(key.millisecondsSinceEpoch.toDouble(), value.toDouble()),
      );
    });

    return spots;
  }

  Future changeTimeRange(TimeRange timeRange) async {
    final state = this.state;
    if (state is! DeedsStatisticsLoaded) return;

    await LocalStorageRepo.changeStatisticsTimeRange(timeRange);
    loadData(timeRange);
  }

  @override
  Future<void> close() {
    deedsCalenderSubscription.cancel();
    return super.close();
  }
}
