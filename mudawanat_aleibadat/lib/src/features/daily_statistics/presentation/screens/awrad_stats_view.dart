import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';
import 'package:mudawanat_aleibadat/src/core/shared/loading.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/components/plot_card.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/controller/deeds_statistics_controller.dart';

class AwradStatsView extends StatelessWidget {
  final DeedsStatisticsController controller;
  const AwradStatsView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return controller.isLoading
        ? const Loading()
        : ListView(
            padding: const EdgeInsets.all(15),
            children: [
              PlotCard(
                label: S.of(context).awrad_quran,
                height: 150,
                spots: controller.quranSpots,
              ),
              PlotCard(
                height: 150,
                label: S.of(context).awrad_azkar,
                spots: controller.azkarSpots,
              ),
            ],
          );
  }
}
