import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';
import 'package:mudawanat_aleibadat/src/core/constants/deeds_reward.dart';
import 'package:mudawanat_aleibadat/src/core/extension/extension_list.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/models/daily_deeds.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/components/deeds_num_tile.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/components/deeds_reward_builder.dart';

class AdditionalPrayerEditor extends StatefulWidget {
  final DailyDeeds dailyDeeds;
  final ValueChanged<DailyDeeds> onChanged;
  const AdditionalPrayerEditor({
    super.key,
    required this.dailyDeeds,
    required this.onChanged,
  });

  @override
  State<AdditionalPrayerEditor> createState() => _AdditionalPrayerEditorState();
}

class _AdditionalPrayerEditorState extends State<AdditionalPrayerEditor> {
  final fajrPreAward = DeedsReward.fajrPre.getRandomItem<String>();
  final additionalAward = DeedsReward.additionalPrayers.getRandomItem<String>();
  final dohaAward = DeedsReward.doha.getRandomItem<String>();
  final nightPrayerAward = DeedsReward.nightPrayer.getRandomItem<String>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      physics: const BouncingScrollPhysics(),
      children: [
        DeedsNumTile(
          numbers: const [0, 2],
          value: widget.dailyDeeds.additionalPrayers.fajrPre,
          title: Text(S.of(context).prayer_fajr_pre),
          info: DeedsRewardBuilder(
            rewards: fajrPreAward,
          ),
          onChanged: (value) {
            widget.onChanged.call(
              widget.dailyDeeds.copyWith(
                additionalPrayers: widget.dailyDeeds.additionalPrayers
                    .copyWith(fajrPre: value),
              ),
            );
          },
        ),
        DeedsNumTile(
          numbers: const [0, 2, 4, 6, 8],
          value: widget.dailyDeeds.additionalPrayers.doha,
          title: Text(S.of(context).prayer_doha),
          info: DeedsRewardBuilder(
            rewards: dohaAward,
          ),
          onChanged: (value) {
            widget.onChanged.call(
              widget.dailyDeeds.copyWith(
                additionalPrayers:
                    widget.dailyDeeds.additionalPrayers.copyWith(doha: value),
              ),
            );
          },
        ),
        DeedsNumTile(
          numbers: const [0, 4],
          value: widget.dailyDeeds.additionalPrayers.dhuhrPre,
          title: Text(S.of(context).prayer_dhuhr_pre),
          info: DeedsRewardBuilder(
            rewards: additionalAward,
          ),
          onChanged: (value) {
            widget.onChanged.call(
              widget.dailyDeeds.copyWith(
                additionalPrayers: widget.dailyDeeds.additionalPrayers
                    .copyWith(dhuhrPre: value),
              ),
            );
          },
        ),
        DeedsNumTile(
          numbers: const [0, 2, 4],
          value: widget.dailyDeeds.additionalPrayers.dhuhrAfter,
          title: Text(S.of(context).prayer_dhuhr_after),
          info: DeedsRewardBuilder(
            rewards: additionalAward,
          ),
          onChanged: (value) {
            widget.onChanged.call(
              widget.dailyDeeds.copyWith(
                additionalPrayers: widget.dailyDeeds.additionalPrayers
                    .copyWith(dhuhrAfter: value),
              ),
            );
          },
        ),
        DeedsNumTile(
          numbers: const [0, 4],
          value: widget.dailyDeeds.additionalPrayers.asrPre,
          title: Text(S.of(context).prayer_asr_pre),
          onChanged: (value) {
            widget.onChanged.call(
              widget.dailyDeeds.copyWith(
                additionalPrayers:
                    widget.dailyDeeds.additionalPrayers.copyWith(asrPre: value),
              ),
            );
          },
        ),
        DeedsNumTile(
          numbers: const [0, 2],
          value: widget.dailyDeeds.additionalPrayers.maghribPre,
          title: Text(S.of(context).prayer_maghrib_pre),
          onChanged: (value) {
            widget.onChanged.call(
              widget.dailyDeeds.copyWith(
                additionalPrayers: widget.dailyDeeds.additionalPrayers
                    .copyWith(maghribPre: value),
              ),
            );
          },
        ),
        DeedsNumTile(
          numbers: const [0, 2],
          value: widget.dailyDeeds.additionalPrayers.maghribAfter,
          title: Text(S.of(context).prayer_maghrib_after),
          info: DeedsRewardBuilder(
            rewards: additionalAward,
          ),
          onChanged: (value) {
            widget.onChanged.call(
              widget.dailyDeeds.copyWith(
                additionalPrayers: widget.dailyDeeds.additionalPrayers
                    .copyWith(maghribAfter: value),
              ),
            );
          },
        ),
        DeedsNumTile(
          numbers: const [0, 2],
          value: widget.dailyDeeds.additionalPrayers.ishaaPre,
          title: Text(S.of(context).prayer_ishaa_pre),
          onChanged: (value) {
            widget.onChanged.call(
              widget.dailyDeeds.copyWith(
                additionalPrayers: widget.dailyDeeds.additionalPrayers
                    .copyWith(ishaaPre: value),
              ),
            );
          },
        ),
        DeedsNumTile(
          numbers: const [0, 2],
          value: widget.dailyDeeds.additionalPrayers.ishaaAfter,
          title: Text(S.of(context).prayer_ishaa_after),
          info: DeedsRewardBuilder(
            rewards: additionalAward,
          ),
          onChanged: (value) {
            widget.onChanged.call(
              widget.dailyDeeds.copyWith(
                additionalPrayers: widget.dailyDeeds.additionalPrayers
                    .copyWith(ishaaAfter: value),
              ),
            );
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
          value: widget.dailyDeeds.additionalPrayers.nightPrayer,
          title: Text(S.of(context).prayer_night_prayer),
          info: DeedsRewardBuilder(
            rewards: nightPrayerAward,
          ),
          onChanged: (value) {
            widget.onChanged.call(
              widget.dailyDeeds.copyWith(
                additionalPrayers: widget.dailyDeeds.additionalPrayers
                    .copyWith(nightPrayer: value),
              ),
            );
          },
        ),
      ],
    );
  }
}
