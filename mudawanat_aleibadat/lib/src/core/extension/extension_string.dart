import 'package:mudawanat_aleibadat/generated/l10n.dart';

extension StringExtension on String {
  String readableColumnName(S s) {
    switch (this) {
      case "fasting":
        return s.fasting;

      case "fajr":
        return s.prayer_fajr;

      case "dhuhr":
        return s.prayer_dhuhr;

      case "asr":
        return s.prayer_asr;

      case "maghrib":
        return s.prayer_maghrib;

      case "ishaa":
        return s.prayer_ishaa;

      case "fajrPre":
        return s.prayer_fajr_pre;

      case "dhuhrPre":
        return s.prayer_dhuhr_pre;

      case "dhuhrAfter":
        return s.prayer_dhuhr_after;

      case "asrPre":
        return s.prayer_asr_pre;

      case "maghribPre":
        return s.prayer_maghrib_pre;

      case "maghribAfter":
        return s.prayer_maghrib_after;

      case "ishaaPre":
        return s.prayer_ishaa_pre;

      case "ishaaAfter":
        return s.prayer_ishaa_after;

      case "doha":
        return s.prayer_doha;

      case "nightPrayer":
        return s.prayer_night_prayer;

      case "quran":
        return s.awrad_quran;

      case "azkar":
        return s.awrad_azkar;

      default:
        return "";
    }
  }
}
