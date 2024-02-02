import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/components/plot_card.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/controller/deeds_statistics_controller.dart';

class DailyDeedsStatisticsView extends StatelessWidget {
  const DailyDeedsStatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DeedsStatisticsController(),
      builder: (controller) {
        return Scaffold(
          body: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              PlotCard(
                label: S.of(context).awrad_quran,
                height: 150,
                spots: controller.quranSpots,
              ),
              PlotCard(
                height: 150,
                label: S.of(context).prayer_obligatory,
                spots: controller.obligatorySpots,
              ),
              PlotCard(
                height: 150,
                label: S.of(context).prayer_additional,
                spots: controller.additionalSpots,
              ),
              PlotCard(
                height: 150,
                label: S.of(context).awrad_azkar,
                spots: controller.azkarSpots,
              ),
            ],
          ),
        );
      },
    );
  }
}
