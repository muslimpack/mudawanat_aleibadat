import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';
import 'package:mudawanat_aleibadat/src/core/extension/date_time.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/data_source/prayer_time.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/models/daily_deeds.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/models/slot.dart';

extension DailyDeedsListExtension on List<DailyDeeds> {
  List<Slot> convertToSlot(S s) {
    return map(
      (e) => e.allSlots(s),
    ).fold(
      <Slot>[],
      (previousValue, element) => previousValue..addAll(element),
    );
  }
}

extension DailyDeedsExtension on DailyDeeds {
  List<Slot> allSlots(S s) {
    return [
      ...obligatoryPrayersSlots(s),
      ...additionalPrayersSlots(s),
      ...fastSlots(s),
      ...awradSlots(s),
    ]..sort((a, b) => a.order.compareTo(b.order));
  }

  List<Slot> awradSlots(S s) {
    return [
      Slot(
        id: date,
        order: 1,
        title: s.awrad_quran,
        from: date,
        to: date,
        isAllDay: true,
        background: getColorByInt(awrad.quran),
      ),
      Slot(
        id: date,
        order: 2,
        title: s.awrad_azkar,
        from: date,
        to: date,
        isAllDay: true,
        background: getColorByInt(awrad.azkar),
      ),
    ];
  }

  List<Slot> fastSlots(S s) {
    return [
      Slot(
        id: date,
        order: 3,
        title: s.fasting,
        from: date,
        to: date,
        isAllDay: true,
        background: getColor(fasting),
      ),
    ];
  }

  List<Slot> obligatoryPrayersSlots(S s) {
    final PrayerTime prayerTime = PrayerTime.instance;
    final List<Slot> slots = <Slot>[];
    final DateTime today = date;

    slots.add(
      Slot(
        id: date,
        order: 5,
        title: s.prayer_fajr,
        from: today.setTime(prayerTime.fajr),
        to: today.setTime(
          prayerTime.fajr.add(prayerTime.fajrDuration),
        ),
        background: getColor(obligatoryPrayers.fajr),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 10,
        title: s.prayer_dhuhr,
        from: today.setTime(prayerTime.dhuhr),
        to: today.setTime(
          prayerTime.dhuhr.add(prayerTime.dhuhrDuration),
        ),
        background: getColor(obligatoryPrayers.dhuhr),
      ),
    );
    slots.add(
      Slot(
        id: date,
        order: 15,
        title: s.prayer_asr,
        from: today.setTime(prayerTime.asr),
        to: today.setTime(
          prayerTime.asr.add(prayerTime.asrDuration),
        ),
        background: getColor(obligatoryPrayers.asr),
      ),
    );
    slots.add(
      Slot(
        id: date,
        order: 20,
        title: s.prayer_maghrib,
        from: today.setTime(prayerTime.maghrib),
        to: today.setTime(
          prayerTime.maghrib.add(prayerTime.maghribDuration),
        ),
        background: getColor(obligatoryPrayers.maghrib),
      ),
    );
    slots.add(
      Slot(
        id: date,
        order: 25,
        title: s.prayer_ishaa,
        from: today.setTime(prayerTime.isha),
        to: today.setTime(
          prayerTime.isha.add(prayerTime.ishaDuration),
        ),
        background: getColor(obligatoryPrayers.ishaa),
      ),
    );

    return slots;
  }

  List<Slot> additionalPrayersSlots(S s) {
    final PrayerTime prayerTime = PrayerTime.instance;
    final List<Slot> slots = <Slot>[];
    final DateTime today = date;

    slots.add(
      Slot(
        id: date,
        order: 4,
        title: s.prayer_fajr_pre,
        from: today.setTime(prayerTime.fajr),
        to: today.setTime(
          prayerTime.fajr.add(prayerTime.fajrDuration),
        ),
        background: getColorByInt(additionalPrayers.fajrPre),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 6,
        title: s.prayer_doha,
        from: today.setTime(prayerTime.doha),
        to: today.setTime(
          prayerTime.doha.add(prayerTime.dohaDuration),
        ),
        background: getColorByInt(additionalPrayers.doha),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 9,
        title: s.prayer_dhuhr_pre,
        from: today.setTime(prayerTime.dhuhr),
        to: today.setTime(
          prayerTime.dhuhr.add(prayerTime.dhuhrDuration),
        ),
        background: getColorByInt(additionalPrayers.dhuhrPre),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 11,
        title: s.prayer_dhuhr_after,
        from: today.setTime(prayerTime.dhuhr),
        to: today.setTime(
          prayerTime.dhuhr.add(prayerTime.dhuhrDuration),
        ),
        background: getColorByInt(additionalPrayers.dhuhrAfter),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 14,
        title: s.prayer_asr_pre,
        from: today.setTime(prayerTime.asr),
        to: today.setTime(
          prayerTime.asr.add(prayerTime.asrDuration),
        ),
        background: getColorByInt(additionalPrayers.asrPre),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 19,
        title: s.prayer_maghrib_pre,
        from: today.setTime(prayerTime.maghrib),
        to: today.setTime(
          prayerTime.maghrib.add(prayerTime.maghribDuration),
        ),
        background: getColorByInt(additionalPrayers.maghribPre),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 21,
        title: s.prayer_maghrib_after,
        from: today.setTime(prayerTime.maghrib),
        to: today.setTime(
          prayerTime.maghrib.add(prayerTime.maghribDuration),
        ),
        background: getColorByInt(additionalPrayers.maghribAfter),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 24,
        title: s.prayer_ishaa_pre,
        from: today.setTime(prayerTime.isha),
        to: today.setTime(prayerTime.isha.add(prayerTime.ishaDuration)),
        background: getColorByInt(additionalPrayers.ishaaPre),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 26,
        title: s.prayer_ishaa_after,
        from: today.setTime(prayerTime.isha),
        to: today.setTime(prayerTime.isha.add(prayerTime.ishaDuration)),
        background: getColorByInt(additionalPrayers.ishaaAfter),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 27,
        title: s.prayer_night_prayer,
        from: today.setTime(prayerTime.midnight),
        to: today.add(const Duration(days: 1)).setTime(prayerTime.fajr),
        background: getColorByInt(additionalPrayers.nightPrayer),
      ),
    );

    return slots;
  }

  Color getColor(bool value) {
    return value ? Colors.greenAccent : Colors.pink;
  }

  Color getColorByInt(int value) {
    return getColor(value != 0);
  }
}
