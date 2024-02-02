import 'package:mudawanat_aleibadat/generated/l10n.dart';

extension StringExtension on String {
  String readableColumnName() {
    switch (this) {
      case "fasting":
        return S.current.fasting;

      case "fajr":
        return S.current.prayer_fajr;

      case "dhuhr":
        return S.current.prayer_dhuhr;

      case "asr":
        return S.current.prayer_asr;

      case "maghrib":
        return S.current.prayer_maghrib;

      case "ishaa":
        return S.current.prayer_ishaa;

      case "fajrPre":
        return S.current.prayer_fajr_pre;

      case "dhuhrPre":
        return S.current.prayer_dhuhr_pre;

      case "dhuhrAfter":
        return S.current.prayer_dhuhr_after;

      case "asrPre":
        return S.current.prayer_asr_pre;

      case "maghribPre":
        return S.current.prayer_maghrib_pre;

      case "maghribAfter":
        return S.current.prayer_maghrib_after;

      case "ishaaPre":
        return S.current.prayer_ishaa_pre;

      case "ishaaAfter":
        return S.current.prayer_ishaa_after;

      case "doha":
        return S.current.prayer_doha;

      case "nightPrayer":
        return S.current.prayer_night_prayer;

      case "quran":
        return S.current.awrad_quran;

      case "azkar":
        return S.current.awrad_azkar;

      default:
        return "";
    }
  }
}
