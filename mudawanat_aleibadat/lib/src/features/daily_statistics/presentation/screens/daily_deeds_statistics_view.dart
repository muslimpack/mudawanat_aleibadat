import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/controller/deeds_statistics_controller.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/screens/additional_stats_view.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/screens/awrad_stats_view.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/screens/obligatory_stats_view.dart';

class DailyDeedsStatisticsView extends StatelessWidget {
  const DailyDeedsStatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DeedsStatisticsController(),
      builder: (controller) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            body: Column(
              children: [
                TabBar(
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
                Expanded(
                  child: TabBarView(
                    children: [
                      AwradStatsView(controller: controller),
                      ObligatoryStatsView(controller: controller),
                      AdditionalStatsView(controller: controller),
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
