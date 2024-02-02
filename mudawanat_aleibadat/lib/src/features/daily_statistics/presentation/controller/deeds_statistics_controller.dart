import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:mudawanat_aleibadat/src/core/extension/extension_string.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/data_source/daily_deeds_repo.dart';
import 'package:mudawanat_aleibadat/src/features/daily_summary/data/models/stats_model.dart';

class DeedsStatisticsController extends GetxController {
  late final int totalDays;
  bool isLoading = true;
  final List<PlotCardItem> additionalSeparatedSpots = [];
  final List<PlotCardItem> obligatorySeparatedSpots = [];
  final List<FlSpot> obligatorySpots = [];
  final List<FlSpot> additionalSpots = [];
  final List<FlSpot> quranSpots = [];
  final List<FlSpot> azkarSpots = [];
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

    for (final element in obligatoryColumn) {
      final spots = <FlSpot>[];
      final map = await dailyDeedsRepo.getMapDateColumn([element]);

      map.forEach((key, value) {
        spots.add(
          FlSpot(key.millisecondsSinceEpoch.toDouble(), value.toDouble()),
        );
      });

      obligatorySeparatedSpots
          .add(PlotCardItem(label: element.readableColumnName(), spots: spots));
    }
  }

  Future loadAdditional() async {
    final map = await dailyDeedsRepo.getMapDateColumn(additionalColumn);

    map.forEach((key, value) {
      additionalSpots.add(
        FlSpot(key.millisecondsSinceEpoch.toDouble(), value.toDouble()),
      );
    });

    for (final element in additionalColumn) {
      final spots = <FlSpot>[];
      final map = await dailyDeedsRepo.getMapDateColumn([element]);

      map.forEach((key, value) {
        spots.add(
          FlSpot(key.millisecondsSinceEpoch.toDouble(), value.toDouble()),
        );
      });

      additionalSeparatedSpots
          .add(PlotCardItem(label: element.readableColumnName(), spots: spots));
    }
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

class PlotCardItem {
  final String label;
  final List<FlSpot> spots;

  PlotCardItem({required this.label, required this.spots});
}
