import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';
import 'package:mudawanat_aleibadat/src/core/shared/loading.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/components/liquid_circular_progress.dart';
import 'package:mudawanat_aleibadat/src/features/daily_summary/presentation/components/stats_card_header.dart';
import 'package:mudawanat_aleibadat/src/features/daily_summary/presentation/components/stats_tile.dart';
import 'package:mudawanat_aleibadat/src/features/daily_summary/presentation/controller/cubit/deeds_summary_cubit.dart';

class DailyDeedsSummaryView extends StatelessWidget {
  const DailyDeedsSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeedsSummaryCubit(),
      child: BlocBuilder(
        bloc: DeedsSummaryCubit()..loadData(),
        builder: (context, state) {
          if (state is! DeedsSummaryLoaded) {
            return const Loading();
          }
          return Scaffold(
            body: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                Row(
                  children: state.obligatoryElements
                      .map(
                        (e) => Expanded(
                          child: CircularLiquidProgress(
                            value: e.percentage,
                            child: e.label,
                          ),
                        ),
                      )
                      .toList(),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        StatsCardHeader.labels(
                          labels: [
                            "",
                            S.of(context).timesDone,
                            S.of(context).count,
                          ],
                        ),
                        ...state.awradElements.map(
                          (e) => StatsTile(
                            label: e.label,
                            times: e.times,
                            value: e.percentage,
                            count: e.count,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        StatsCardHeader.labels(
                          labels: [
                            "",
                            S.of(context).count,
                          ],
                        ),
                        StatsTile(
                          label: state.fastingElement.label,
                          times: state.fastingElement.times,
                          value: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        StatsCardHeader.labels(
                          labels: [
                            S.of(context).prayer_name,
                            S.of(context).timesMissed,
                          ],
                        ),
                        ...state.obligatoryElements.map(
                          (e) => StatsTile(
                            label: e.label,
                            times: e.times,
                            value: e.percentage,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        StatsCardHeader.labels(
                          labels: [
                            S.of(context).prayer_name,
                            S.of(context).timesDone,
                            S.of(context).count,
                          ],
                        ),
                        ...state.additionalElements.map(
                          (e) => StatsTile(
                            label: e.label,
                            times: e.times,
                            value: e.percentage,
                            count: e.count,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
