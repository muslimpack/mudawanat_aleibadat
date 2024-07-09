import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';
import 'package:mudawanat_aleibadat/src/core/shared/loading.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/data/models/stats_range.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/controller/cubit/deeds_statistics_cubit.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/screens/additional_stats_view.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/screens/awrad_stats_view.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/screens/obligatory_stats_view.dart';

class DailyDeedsStatisticsView extends StatelessWidget {
  const DailyDeedsStatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DeedsStatisticsCubit>();
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        if (state is! DeedsStatisticsLoaded) {
          return const Loading();
        }
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            body: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TabBar(
                        tabAlignment: TabAlignment.center,
                        isScrollable: true,
                        tabs: <Widget>[
                          Tab(
                            text: S.of(context).awrad,
                          ),
                          Tab(
                            text: S.of(context).prayer_obligatory,
                          ),
                          Tab(
                            text: S.of(context).prayer_additional,
                          ),
                        ],
                      ),
                    ),
                    DropdownButton<StatsRange?>(
                      value: state.timeRange,
                      underline: const SizedBox(),
                      onChanged: (value) {
                        if (value == null) return;
                        context
                            .read<DeedsStatisticsCubit>()
                            .changeTimeRange(value);
                      },
                      items: StatsRange.values
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.localeName(context)),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      AwradStatsView(
                        cubit: cubit,
                      ),
                      ObligatoryStatsView(
                        cubit: cubit,
                      ),
                      AdditionalStatsView(
                        cubit: cubit,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
