import 'package:flutter/material.dart';
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
    return ColoredBox(
      color: meeting.background,
      child: Center(
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: RotatedBox(
              quarterTurns:
                  calendarDetails.bounds.width > calendarDetails.bounds.height
                      ? 3
                      : 4,
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
        ),
      ),
    );
  }
}
