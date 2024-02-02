import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';
import 'package:mudawanat_aleibadat/src/core/shared/loading.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/components/plot_card.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/controller/deeds_statistics_controller.dart';

class ObligatoryStatsView extends StatelessWidget {
  final DeedsStatisticsController controller;
  const ObligatoryStatsView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return controller.isLoading
        ? const Loading()
        : ListView(
            padding: const EdgeInsets.all(15),
            children: [
              PlotCard(
                height: 150,
                label: S.of(context).prayer_obligatory,
                spots: controller.obligatorySpots,
              ),
              ...controller.obligatorySeparatedSpots.map(
                (e) => PlotCard(
                  height: 150,
                  label: e.label,
                  spots: e.spots,
                ),
              ),
            ],
          );
  }
}
