import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';

enum StatsRange {
  last365Days,
  last180Days,
  last30Days,
  last7Days,
  all,
}

extension StatsRangeExt on StatsRange {
  String localeName(BuildContext context) {
    switch (this) {
      case StatsRange.last365Days:
        return S.of(context).statsRangeLast365Days;
      case StatsRange.last180Days:
        return S.of(context).statsRangeLast180Days;
      case StatsRange.last30Days:
        return S.of(context).statsRangeLast30Days;
      case StatsRange.last7Days:
        return S.of(context).statsRangeLast7Days;
      case StatsRange.all:
        return S.of(context).statsRangeAll;
    }
  }

  int? daysNumber() {
    switch (this) {
      case StatsRange.last365Days:
        return 365;
      case StatsRange.last180Days:
        return 180;
      case StatsRange.last30Days:
        return 30;
      case StatsRange.last7Days:
        return 7;
      case StatsRange.all:
        return null;
    }
  }
}
