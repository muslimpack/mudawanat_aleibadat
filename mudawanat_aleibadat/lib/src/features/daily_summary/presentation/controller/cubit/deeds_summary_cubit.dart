import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mudawanat_aleibadat/src/core/extension/extension_string.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/data_source/daily_deeds_repo.dart';
import 'package:mudawanat_aleibadat/src/features/daily_summary/data/models/stats_model.dart';

part 'deeds_summary_state.dart';

class DeedsSummaryCubit extends Cubit<DeedsSummaryState> {
  DeedsSummaryCubit() : super(DeedsSummaryLoading());
  static const String fastingColumn = "fasting";
  static const List<String> obligatoryColumn = [
    "fajr",
    "dhuhr",
    "asr",
    "maghrib",
    "ishaa",
  ];
  static const List<String> additionalColumn = [
    "fajrPre",
    "doha",
    "dhuhrPre",
    "dhuhrAfter",
    "asrPre",
    "maghribPre",
    "maghribAfter",
    "ishaaPre",
    "ishaaAfter",
    "nightPrayer",
  ];
  static const List<String> awradColumn = [
    "quran",
    "azkar",
  ];

  Future loadData() async {
    final int totalDays = await dailyDeedsRepo.daysCount();

    final List<Future> futures = [
      _loadFasting(totalDays),
      _loadObligatory(totalDays),
      _loadAdditional(totalDays),
      _loadAwrad(totalDays),
    ];

    final List results = await Future.wait(futures);

    final fastingElement = results[0];
    final obligatoryElements = results[1];
    final additionalElements = results[2];
    final awradElements = results[3];

    emit(
      DeedsSummaryLoaded(
        totalDays: totalDays,
        obligatoryElements: obligatoryElements as List<StatsElement>,
        additionalElements: additionalElements as List<StatsElement>,
        awradElements: awradElements as List<StatsElement>,
        fastingElement: fastingElement as StatsElement,
      ),
    );
  }

  Future<StatsElement> _loadFasting(int totalDays) async {
    final double percentage;
    final int count;

    if (totalDays == 0) {
      percentage = 1;
      count = 0;
    } else {
      count = await dailyDeedsRepo.countNonZeroValues(fastingColumn);
      percentage = count / totalDays;
    }

    return StatsElement(
      label: fastingColumn.readableColumnName(),
      times: count,
      percentage: percentage,
    );
  }

  Future<List<StatsElement>> _loadObligatory(int totalDays) async {
    final List<StatsElement> elements = [];

    for (final element in obligatoryColumn) {
      final String label = element;
      final double percentage;
      final int times;

      if (totalDays == 0) {
        percentage = 1;
        times = 0;
      } else {
        times = await dailyDeedsRepo.countNonZeroValues(label);

        percentage = times / totalDays;
      }

      elements.add(
        StatsElement(
          label: label.readableColumnName(),
          times: totalDays - times,
          percentage: percentage,
        ),
      );
    }
    return elements;
  }

  Future<List<StatsElement>> _loadAdditional(int totalDays) async {
    final List<StatsElement> elements = [];

    for (final element in additionalColumn) {
      final String label = element;
      final double percentage;
      final int times;
      final int count;

      if (totalDays == 0) {
        percentage = 1;
        times = 0;
        count = 0;
      } else {
        count = await dailyDeedsRepo.sumColumn(label);
        times = await dailyDeedsRepo.countNonZeroValues(label);
        percentage = times / totalDays;
      }

      elements.add(
        StatsElement(
          label: label.readableColumnName(),
          times: times,
          percentage: percentage,
          count: count,
        ),
      );
    }
    return elements;
  }

  Future<List<StatsElement>> _loadAwrad(int totalDays) async {
    final List<StatsElement> elements = [];
    for (final element in awradColumn) {
      final String label = element;
      final double percentage;
      final int times;
      final int count;

      if (totalDays == 0) {
        percentage = 1;
        times = 0;
        count = 0;
      } else {
        count = await dailyDeedsRepo.sumColumn(label);
        times = await dailyDeedsRepo.countNonZeroValues(label);
        percentage = times / totalDays;
      }

      elements.add(
        StatsElement(
          label: label.readableColumnName(),
          times: times,
          percentage: percentage,
          count: count,
        ),
      );
    }

    return elements;
  }
}
