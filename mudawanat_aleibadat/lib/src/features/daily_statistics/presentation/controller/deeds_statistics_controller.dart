import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';
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
    // for (final element in awradColumn) {}
  }

  String readableColumnName(String column) {
    switch (column) {
      case "fasting":
        return S.current.fasting;

      case "fajr":
        return S.current.prayer_fajr;

      case "dhuhr":
        return S.current.prayer_dhuhr;

      case "asr":
        return S.current.prayer_asr;

      case "maghrib":
        return S.current.prayer_maghrib;

      case "ishaa":
        return S.current.prayer_ishaa;

      case "fajrPre":
        return S.current.prayer_fajr_pre;

      case "dhuhrPre":
        return S.current.prayer_dhuhr_pre;

      case "dhuhrAfter":
        return S.current.prayer_dhuhr_after;

      case "asrPre":
        return S.current.prayer_asr_pre;

      case "maghribPre":
        return S.current.prayer_maghrib_pre;

      case "maghribAfter":
        return S.current.prayer_maghrib_after;

      case "ishaaPre":
        return S.current.prayer_ishaa_pre;

      case "ishaaAfter":
        return S.current.prayer_ishaa_after;

      case "doha":
        return S.current.prayer_doha;

      case "nightPrayer":
        return S.current.prayer_night_prayer;

      case "quran":
        return S.current.awrad_quran;

      case "azkar":
        return S.current.awrad_azkar;

      default:
        return "";
    }
  }
}
