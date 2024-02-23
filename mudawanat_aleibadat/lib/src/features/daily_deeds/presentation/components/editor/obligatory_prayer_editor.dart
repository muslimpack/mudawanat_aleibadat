// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';
import 'package:mudawanat_aleibadat/src/core/constants/deeds_reward.dart';
import 'package:mudawanat_aleibadat/src/core/extension/extension_list.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/models/daily_deeds.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/components/deeds_reward_builder.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/components/deeds_switch_tile.dart';

class ObligatoryPrayerEditor extends StatefulWidget {
  final DailyDeeds dailyDeeds;
  final ValueChanged<DailyDeeds> onChanged;
  const ObligatoryPrayerEditor({
    super.key,
    required this.dailyDeeds,
    required this.onChanged,
  });

  @override
  State<ObligatoryPrayerEditor> createState() => _ObligatoryPrayerEditorState();
}

class _ObligatoryPrayerEditorState extends State<ObligatoryPrayerEditor> {
  final rewards = DeedsReward.obligatoryPrayers.getRandomItem<String>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      physics: const BouncingScrollPhysics(),
      children: [
        DeedsSwitchTile(
          value: widget.dailyDeeds.obligatoryPrayers.fajr,
          title: Text(S.of(context).prayer_fajr),
          info: DeedsRewardBuilder(
            rewards: rewards,
          ),
          onChanged: (value) {
            widget.onChanged.call(
              widget.dailyDeeds.copyWith(
                obligatoryPrayers:
                    widget.dailyDeeds.obligatoryPrayers.copyWith(fajr: value),
              ),
            );
          },
        ),
        DeedsSwitchTile(
          value: widget.dailyDeeds.obligatoryPrayers.dhuhr,
          title: Text(S.of(context).prayer_dhuhr),
          info: DeedsRewardBuilder(
            rewards: rewards,
          ),
          onChanged: (value) {
            widget.onChanged.call(
              widget.dailyDeeds.copyWith(
                obligatoryPrayers:
                    widget.dailyDeeds.obligatoryPrayers.copyWith(dhuhr: value),
              ),
            );
          },
        ),
        DeedsSwitchTile(
          value: widget.dailyDeeds.obligatoryPrayers.asr,
          title: Text(S.of(context).prayer_asr),
          info: DeedsRewardBuilder(
            rewards: rewards,
          ),
          onChanged: (value) {
            widget.onChanged.call(
              widget.dailyDeeds.copyWith(
                obligatoryPrayers:
                    widget.dailyDeeds.obligatoryPrayers.copyWith(asr: value),
              ),
            );
          },
        ),
        DeedsSwitchTile(
          value: widget.dailyDeeds.obligatoryPrayers.maghrib,
          title: Text(S.of(context).prayer_maghrib),
          info: DeedsRewardBuilder(
            rewards: rewards,
          ),
          onChanged: (value) {
            widget.onChanged.call(
              widget.dailyDeeds.copyWith(
                obligatoryPrayers: widget.dailyDeeds.obligatoryPrayers
                    .copyWith(maghrib: value),
              ),
            );
          },
        ),
        DeedsSwitchTile(
          value: widget.dailyDeeds.obligatoryPrayers.ishaa,
          title: Text(S.of(context).prayer_ishaa),
          info: DeedsRewardBuilder(
            rewards: rewards,
          ),
          onChanged: (value) {
            widget.onChanged.call(
              widget.dailyDeeds.copyWith(
                obligatoryPrayers:
                    widget.dailyDeeds.obligatoryPrayers.copyWith(ishaa: value),
              ),
            );
          },
        ),
      ],
    );
  }
}
