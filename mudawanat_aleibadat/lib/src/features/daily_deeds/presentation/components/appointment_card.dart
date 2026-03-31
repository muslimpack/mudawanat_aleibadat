import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/src/core/extension/extension_color.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/models/slot.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.calendarDetails,
  });

  final CalendarAppointmentDetails calendarDetails;

  @override
  Widget build(BuildContext context) {
    final Slot meeting = calendarDetails.appointments.first as Slot;
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool landscapeCard = constraints.maxWidth > constraints.maxHeight;
        return ColoredBox(
          color: meeting.background,
          child: Center(
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: RotatedBox(
                  quarterTurns: landscapeCard ? 0 : 3,
                  child: Text(
                    meeting.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: meeting.background.getContrastColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
