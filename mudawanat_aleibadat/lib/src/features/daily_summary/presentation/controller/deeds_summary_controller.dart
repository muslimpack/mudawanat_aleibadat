import 'package:get/get.dart';
import 'package:mudawanat_aleibadat/src/core/extension/extension_string.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/data_source/daily_deeds_repo.dart';
import 'package:mudawanat_aleibadat/src/features/daily_summary/data/models/stats_model.dart';

class DeedsSummaryController extends GetxController {
  late final int totalDays;
  bool isLoading = true;
  final List<StatsElement> obligatoryElements = [];
  final List<StatsElement> additionalElements = [];
  final List<StatsElement> awradElements = [];
  late StatsElement fastingElement;
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

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  Future loadData() async {
    totalDays = await dailyDeedsRepo.daysCount();
    await loadFasting();
    await loadObligatory();
    await loadAdditional();
    await loadAwrad();
    isLoading = false;
    update();
  }

  Future loadFasting() async {
    final double percentage;
    final int count;

    if (totalDays == 0) {
      percentage = 1;
      count = 0;
    } else {
      count = await dailyDeedsRepo.countNonZeroValues(fastingColumn);
      percentage = count / totalDays;
    }

    fastingElement = StatsElement(
      label: fastingColumn.readableColumnName(),
      times: count,
      percentage: percentage,
    );
  }

  Future loadObligatory() async {
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

      obligatoryElements.add(
        StatsElement(
          label: label.readableColumnName(),
          times: totalDays - times,
          percentage: percentage,
        ),
      );
    }
  }

  Future loadAdditional() async {
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

      additionalElements.add(
        StatsElement(
          label: label.readableColumnName(),
          times: times,
          percentage: percentage,
          count: count,
        ),
      );
    }
  }

  Future loadAwrad() async {
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

      awradElements.add(
        StatsElement(
          label: label.readableColumnName(),
          times: times,
          percentage: percentage,
          count: count,
        ),
      );
    }
  }
}
