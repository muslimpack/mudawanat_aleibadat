import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';
import 'package:mudawanat_aleibadat/src/core/shared/loading.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/components/plot_card.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/controller/cubit/deeds_statistics_cubit.dart';

class AwradStatsView extends StatelessWidget {
  final DeedsStatisticsCubit cubit;
  const AwradStatsView({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final state = cubit.state;
    if (state is! DeedsStatisticsLoaded) {
      return const Loading();
    }
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        PlotCard(
          label: S.of(context).awrad_quran,
          height: 150,
          spots: state.quranSpots,
        ),
        PlotCard(
          height: 150,
          label: S.of(context).awrad_azkar,
          spots: state.azkarSpots,
        ),
      ],
    );
  }
}
