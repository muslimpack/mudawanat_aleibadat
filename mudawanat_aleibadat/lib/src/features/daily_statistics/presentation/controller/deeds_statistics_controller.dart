import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/data_source/daily_deeds_repo.dart';
import 'package:mudawanat_aleibadat/src/features/daily_summary/data/models/stats_model.dart';

class DeedsStatisticsController extends GetxController {
  late final int totalDays;
  bool isLoading = true;
  final List<FlSpot> obligatorySpots = [];
  final List<FlSpot> additionalSpots = [];
  final List<FlSpot> quranSpots = [];
  final List<FlSpot> azkarSpots = [];
  // final List<FlSpot> awradElements = [];
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

    await loadObligatory();
    await loadAdditional();
    await loadAwrad();
    isLoading = false;
    update();
  }

  Future loadObligatory() async {
    final map = await dailyDeedsRepo.getMapDateColumn(obligatoryColumn);

    map.forEach((key, value) {
      obligatorySpots.add(
        FlSpot(key.millisecondsSinceEpoch.toDouble(), value.toDouble()),
      );
    });
  }

  Future loadAdditional() async {
    final map = await dailyDeedsRepo.getMapDateColumn(additionalColumn);

    map.forEach((key, value) {
      additionalSpots.add(
        FlSpot(key.millisecondsSinceEpoch.toDouble(), value.toDouble()),
      );
    });
  }

  Future loadAwrad() async {
    final quranMap = await dailyDeedsRepo.getMapDateColumn(["quran"]);
    quranMap.forEach((key, value) {
      quranSpots.add(
        FlSpot(key.millisecondsSinceEpoch.toDouble(), value.toDouble()),
      );
    });

    final azkarMap = await dailyDeedsRepo.getMapDateColumn(["azkar"]);
    azkarMap.forEach((key, value) {
      azkarSpots.add(
        FlSpot(key.millisecondsSinceEpoch.toDouble(), value.toDouble()),
      );
    });
  }
}
