import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';
import 'package:mudawanat_aleibadat/src/core/constants/deeds_reward.dart';
import 'package:mudawanat_aleibadat/src/core/extension/extension_list.dart';
import 'package:mudawanat_aleibadat/src/core/shared/loading.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/data_source/daily_deeds_repo.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/models/daily_deeds.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/components/deeds_num_tile.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/components/deeds_reward_builder.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/components/deeds_switch_tile.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/components/editor/obligatory_prayer_editor.dart';

class DailyDeedsEditor extends StatefulWidget {
  final DailyDeeds? dailyDeeds;
  final DateTime dateTime;
  DailyDeedsEditor({
    super.key,
    required this.dailyDeeds,
  }) : dateTime = dailyDeeds!.date;

  const DailyDeedsEditor.byDateTime({
    super.key,
    required this.dateTime,
  }) : dailyDeeds = null;

  @override
  State<DailyDeedsEditor> createState() => _DailyDeedsEditorState();
}

class _DailyDeedsEditorState extends State<DailyDeedsEditor> {
  bool isLoading = true;
  late final DailyDeeds initialValue;
  late DailyDeeds dailyDeeds;
  @override
  void initState() {
    if (widget.dailyDeeds == null) {
      loadData();
    } else {
      dailyDeeds = widget.dailyDeeds!;
      initialValue = dailyDeeds;
      setState(() {
        isLoading = false;
      });
    }
    super.initState();
  }

  Future loadData() async {
    dailyDeeds = (await dailyDeedsRepo.getDailyDeedsByDate(widget.dateTime)) ??
        DailyDeeds.empty(date: widget.dateTime);
    initialValue = dailyDeeds;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                leading: const SizedBox(),
                title: Text(
                  DateFormat('E dd / MM / yyyy').format(dailyDeeds.date),
                ),
                centerTitle: true,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: TabBar(
                    physics: const BouncingScrollPhysics(),
                    tabAlignment: TabAlignment.center,
                    isScrollable: true,
                    tabs: <Widget>[
                      Tab(
                        text: S.of(context).general,
                      ),
                      Tab(
                        text: S.of(context).prayer_obligatory,
                      ),
                      Tab(
                        text: S.of(context).prayer_additional,
                      ),
                      Tab(
                        text: S.of(context).awrad,
                      ),
                    ],
                  ),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        /// General
                        ListView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(15),
                          children: [
                            DeedsSwitchTile(
                              value: dailyDeeds.fasting,
                              title: Text(S.of(context).fasting),
                              info: DeedsRewardBuilder(
                                rewards:
                                    DeedsReward.fasting.getRandomItem<String>(),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  dailyDeeds =
                                      dailyDeeds.copyWith(fasting: value);
                                });
                              },
                            ),
                            ListTile(
                              title: Text(
                                S.of(context).last_update,
                                textAlign: TextAlign.center,
                              ),
                              subtitle: Text(
                                DateFormat('E - dd / MM / yyyy - hh:mm')
                                    .format(dailyDeeds.lastUpdated),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),

                        /// obligatoryPrayers
                        ObligatoryPrayerEditor(
                          dailyDeeds: dailyDeeds,
                          onChanged: (value) {
                            setState(() {
                              dailyDeeds = value;
                            });
                          },
                        ),

                        /// AdditionalPrayers
                        ListView(
                          padding: const EdgeInsets.all(15),
                          physics: const BouncingScrollPhysics(),
                          children: [
                            DeedsNumTile(
                              numbers: const [0, 2],
                              value: dailyDeeds.additionalPrayers.fajrPre,
                              title: Text(S.of(context).prayer_fajr_pre),
                              info: DeedsRewardBuilder(
                                rewards:
                                    DeedsReward.fajrPre.getRandomItem<String>(),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  dailyDeeds = dailyDeeds.copyWith(
                                    additionalPrayers: dailyDeeds
                                        .additionalPrayers
                                        .copyWith(fajrPre: value),
                                  );
                                });
                              },
                            ),
                            DeedsNumTile(
                              numbers: const [0, 2, 4, 6, 8],
                              value: dailyDeeds.additionalPrayers.doha,
                              title: Text(S.of(context).prayer_doha),
                              info: DeedsRewardBuilder(
                                rewards:
                                    DeedsReward.doha.getRandomItem<String>(),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  dailyDeeds = dailyDeeds.copyWith(
                                    additionalPrayers: dailyDeeds
                                        .additionalPrayers
                                        .copyWith(doha: value),
                                  );
                                });
                              },
                            ),
                            DeedsNumTile(
                              numbers: const [0, 4],
                              value: dailyDeeds.additionalPrayers.dhuhrPre,
                              title: Text(S.of(context).prayer_dhuhr_pre),
                              info: DeedsRewardBuilder(
                                rewards: DeedsReward.additionalPrayers
                                    .getRandomItem<String>(),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  dailyDeeds = dailyDeeds.copyWith(
                                    additionalPrayers: dailyDeeds
                                        .additionalPrayers
                                        .copyWith(dhuhrPre: value),
                                  );
                                });
                              },
                            ),
                            DeedsNumTile(
                              numbers: const [0, 2, 4],
                              value: dailyDeeds.additionalPrayers.dhuhrAfter,
                              title: Text(S.of(context).prayer_dhuhr_after),
                              info: DeedsRewardBuilder(
                                rewards: DeedsReward.additionalPrayers
                                    .getRandomItem<String>(),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  dailyDeeds = dailyDeeds.copyWith(
                                    additionalPrayers: dailyDeeds
                                        .additionalPrayers
                                        .copyWith(dhuhrAfter: value),
                                  );
                                });
                              },
                            ),
                            DeedsNumTile(
                              numbers: const [0, 4],
                              value: dailyDeeds.additionalPrayers.asrPre,
                              title: Text(S.of(context).prayer_asr_pre),
                              onChanged: (value) {
                                setState(() {
                                  dailyDeeds = dailyDeeds.copyWith(
                                    additionalPrayers: dailyDeeds
                                        .additionalPrayers
                                        .copyWith(asrPre: value),
                                  );
                                });
                              },
                            ),
                            DeedsNumTile(
                              numbers: const [0, 2],
                              value: dailyDeeds.additionalPrayers.maghribPre,
                              title: Text(S.of(context).prayer_maghrib_pre),
                              onChanged: (value) {
                                setState(() {
                                  dailyDeeds = dailyDeeds.copyWith(
                                    additionalPrayers: dailyDeeds
                                        .additionalPrayers
                                        .copyWith(maghribPre: value),
                                  );
                                });
                              },
                            ),
                            DeedsNumTile(
                              numbers: const [0, 2],
                              value: dailyDeeds.additionalPrayers.maghribAfter,
                              title: Text(S.of(context).prayer_maghrib_after),
                              info: DeedsRewardBuilder(
                                rewards: DeedsReward.additionalPrayers
                                    .getRandomItem<String>(),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  dailyDeeds = dailyDeeds.copyWith(
                                    additionalPrayers: dailyDeeds
                                        .additionalPrayers
                                        .copyWith(maghribAfter: value),
                                  );
                                });
                              },
                            ),
                            DeedsNumTile(
                              numbers: const [0, 2],
                              value: dailyDeeds.additionalPrayers.ishaaPre,
                              title: Text(S.of(context).prayer_ishaa_pre),
                              onChanged: (value) {
                                setState(() {
                                  dailyDeeds = dailyDeeds.copyWith(
                                    additionalPrayers: dailyDeeds
                                        .additionalPrayers
                                        .copyWith(ishaaPre: value),
                                  );
                                });
                              },
                            ),
                            DeedsNumTile(
                              numbers: const [0, 2],
                              value: dailyDeeds.additionalPrayers.ishaaAfter,
                              title: Text(S.of(context).prayer_ishaa_after),
                              info: DeedsRewardBuilder(
                                rewards: DeedsReward.additionalPrayers
                                    .getRandomItem<String>(),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  dailyDeeds = dailyDeeds.copyWith(
                                    additionalPrayers: dailyDeeds
                                        .additionalPrayers
                                        .copyWith(ishaaAfter: value),
                                  );
                                });
                              },
                            ),
                            DeedsNumTile(
                              numbers: const [
                                0,
                                1,
                                3,
                                5,
                                7,
                                9,
                                11,
                                13,
                                15,
                                17,
                                19,
                                21,
                              ],
                              showCounter: true,
                              value: dailyDeeds.additionalPrayers.nightPrayer,
                              title: Text(S.of(context).prayer_night_prayer),
                              info: DeedsRewardBuilder(
                                rewards: DeedsReward.nightPrayer
                                    .getRandomItem<String>(),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  dailyDeeds = dailyDeeds.copyWith(
                                    additionalPrayers: dailyDeeds
                                        .additionalPrayers
                                        .copyWith(nightPrayer: value),
                                  );
                                });
                              },
                            ),
                          ],
                        ),

                        /// Awrad
                        ListView(
                          padding: const EdgeInsets.all(15),
                          physics: const BouncingScrollPhysics(),
                          children: [
                            DeedsSwitchTile(
                              value: dailyDeeds.awrad.azkar,
                              title: Text(S.of(context).awrad_azkar),
                              info: DeedsRewardBuilder(
                                rewards:
                                    DeedsReward.azkar.getRandomItem<String>(),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  dailyDeeds = dailyDeeds.copyWith(
                                    awrad:
                                        dailyDeeds.awrad.copyWith(azkar: value),
                                  );
                                });
                              },
                            ),
                            DeedsNumTile(
                              value: dailyDeeds.awrad.quran,
                              title: Text(S.of(context).awrad_quran),
                              info: DeedsRewardBuilder(
                                rewards:
                                    DeedsReward.quran.getRandomItem<String>(),
                              ),
                              showCounter: true,
                              numbers: const [0, 5, 10, 15, 20, 30, 40, 50],
                              onChanged: (value) {
                                setState(() {
                                  dailyDeeds = dailyDeeds.copyWith(
                                    awrad:
                                        dailyDeeds.awrad.copyWith(quran: value),
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// Footer
                  const Divider(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            S.of(context).close,
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            S.of(context).done,
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            if (dailyDeeds == initialValue) {
                              Navigator.of(context).pop();
                            } else {
                              Navigator.of(context).pop(
                                dailyDeeds.copyWith(
                                  lastUpdated: DateTime.now(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
