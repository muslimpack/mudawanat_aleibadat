import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';
import 'package:mudawanat_aleibadat/src/core/shared/loading.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/components/plot_card.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/controller/deeds_statistics_controller.dart';

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
                      if (controller.isLoading)
                        const Loading()
                      else
                        ListView(
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
                        ),
                      if (controller.isLoading)
                        const Loading()
                      else
                        ListView(
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
                        ),
                      if (controller.isLoading)
                        const Loading()
                      else
                        ListView(
                          padding: const EdgeInsets.all(15),
                          children: [
                            PlotCard(
                              height: 150,
                              label: S.of(context).prayer_additional,
                              spots: controller.additionalSpots,
                            ),
                            ...controller.additionalSeparatedSpots.map(
                              (e) => PlotCard(
                                height: 150,
                                label: e.label,
                                spots: e.spots,
                              ),
                            ),
                          ],
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
