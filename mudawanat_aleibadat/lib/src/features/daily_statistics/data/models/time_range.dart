import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';

enum TimeRange {
  last365Days,
  last180Days,
  last30Days,
  last7Days,
  all,
}

extension TimeRangeExt on TimeRange {
  String localeName(BuildContext context) {
    switch (this) {
      case TimeRange.last365Days:
        return S.of(context).timeRangeLast365Days;
      case TimeRange.last180Days:
        return S.of(context).timeRangeLast180Days;
      case TimeRange.last30Days:
        return S.of(context).timeRangeLast30Days;
      case TimeRange.last7Days:
        return S.of(context).timeRangeLast7Days;
      case TimeRange.all:
        return S.of(context).timeRangeAll;
    }
  }

  int? daysNumber() {
    switch (this) {
      case TimeRange.last365Days:
        return 365;
      case TimeRange.last180Days:
        return 180;
      case TimeRange.last30Days:
        return 30;
      case TimeRange.last7Days:
        return 7;
      case TimeRange.all:
        return null;
    }
  }
}
