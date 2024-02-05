import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';
import 'package:mudawanat_aleibadat/src/core/shared/loading.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/components/plot_card.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/controller/cubit/deeds_statistics_cubit.dart';

class ObligatoryStatsView extends StatelessWidget {
  final DeedsStatisticsCubit cubit;
  const ObligatoryStatsView({super.key, required this.cubit});

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
          height: 150,
          maxY: 5,
          label: S.of(context).prayer_obligatory,
          spots: state.obligatorySpots,
        ),
        ...state.obligatorySeparatedSpots.map(
          (e) => PlotCard(
            height: 150,
            maxY: 1,
            label: e.label,
            spots: e.spots,
          ),
        ),
      ],
    );
  }
}
