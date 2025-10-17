import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/models/slot.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MonthCellCard extends StatelessWidget {
  const MonthCellCard({
    super.key,
    required this.monthDetails,
  });

  final MonthCellDetails monthDetails;
  @override
  Widget build(BuildContext context) {
    if (monthDetails.appointments.length < 5 && monthDetails.date.isBefore(DateTime.now())) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.withAlpha((.2 * 255).toInt()),
            width: .5,
          ),
        ),
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.yellow.withAlpha((.1 * 255).toInt()),
          ),
          child: Text(
            monthDetails.date.day.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    final List<Widget> slots = monthDetails.appointments.fold([], (previousValue, e) {
      if (e is! Slot) return previousValue;
      final meeting = e;

      if (meeting.order % 5 != 0) return previousValue;

      final slot = Expanded(
        child: Container(
          color: meeting.background,
          padding: const EdgeInsets.all(2.0),
          child: FittedBox(
            child: Text(
              meeting.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

      return previousValue..add(slot);
    });

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withAlpha((.2 * 255).toInt()),
          width: .5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            monthDetails.date.day.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          ...slots,
        ],
      ),
    );
  }
}
