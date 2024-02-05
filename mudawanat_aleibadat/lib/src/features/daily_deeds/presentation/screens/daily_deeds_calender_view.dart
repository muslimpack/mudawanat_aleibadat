import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mudawanat_aleibadat/src/core/shared/loading.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/components/appointment_card.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/components/months_cell_card.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/controller/bloc/deeds_calender_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DailyDeedsCalenderView extends StatefulWidget {
  const DailyDeedsCalenderView({super.key});

  @override
  State<DailyDeedsCalenderView> createState() => _DailyDeedsCalenderViewState();
}

class _DailyDeedsCalenderViewState extends State<DailyDeedsCalenderView> {
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final bloc = context.read<DeedsCalenderBloc>();
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        final now = DateTime.now();

        if (state is! DeedsCalenderLoadedState) {
          return const Loading();
        }
        return Scaffold(
          key: scaffoldKey,
          body: SfCalendar(
            controller: bloc.controller,
            initialDisplayDate: now,
            initialSelectedDate: now,
            maxDate: now.add(const Duration(days: 1)),
            minDate: DateTime(1900),

            showNavigationArrow: true,
            showTodayButton: true,
            // showWeekNumber: true,
            // allowViewNavigation: true,
            showDatePickerButton: true,
            firstDayOfWeek: DateTime.saturday,
            view: CalendarView.month,

            allowedViews: const <CalendarView>[
              CalendarView.day,
              CalendarView.week,
              CalendarView.month,
            ],

            monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.none,
              // appointmentDisplayCount: 5,
              // showAgenda: true,
              showTrailingAndLeadingDates: false,
            ),

            dataSource: state.dataSource,
            appointmentBuilder: (_, details) => AppointmentCard(
              calendarDetails: details,
            ),
            monthCellBuilder: (_, details) => MonthCellCard(
              monthDetails: details,
            ),
            loadMoreWidgetBuilder: (_, loadMoreAppointments) =>
                FutureBuilder<void>(
              future: loadMoreAppointments(),
              builder: (_, snapShot) {
                return const Loading();
              },
            ),

            onTap: (details) {
              bloc.add(
                DeedsCalenderOnTapEvent(
                  details: details,
                  scaffoldKey: scaffoldKey,
                ),
              );
            },
            onLongPress: (details) {
              bloc.add(
                DeedsCalenderOnLongTapEvent(
                  details: details,
                  scaffoldKey: scaffoldKey,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
