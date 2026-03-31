import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';
import 'package:mudawanat_aleibadat/src/core/shared/loading.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/data_source/sf_data_source.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/models/daily_deeds.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/models/daily_deeds_extension.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/models/slot.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/components/appointment_card.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/components/editor/daily_deeds_editor.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/components/months_cell_card.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/controller/bloc/deeds_calender_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DailyDeedsCalenderView extends StatefulWidget {
  const DailyDeedsCalenderView({super.key});

  @override
  State<DailyDeedsCalenderView> createState() => _DailyDeedsCalenderViewState();
}

class _DailyDeedsCalenderViewState extends State<DailyDeedsCalenderView> {
  late final CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _editDeed(
    BuildContext context,
    DeedsCalenderBloc bloc,
    CalendarTouchDetails details,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) async {
    final DateTime? dateTimeToEdit;
    if (details.targetElement == CalendarElement.appointment) {
      dateTimeToEdit = (details.appointments?.first as Slot).id;
    } else {
      dateTimeToEdit = details.date;
    }

    if (dateTimeToEdit == null) return;

    final DailyDeeds? result = await showDialog(
      barrierDismissible: false,
      context: scaffoldKey.currentContext ?? context,
      builder: (BuildContext context) {
        return DailyDeedsEditor.byDateTime(
          dateTime: dateTimeToEdit!,
        );
      },
    );

    if (result != null) {
      bloc.add(DeedsCalenderUpdateDeedEvent(result));
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final bloc = context.read<DeedsCalenderBloc>();
    return BlocBuilder<DeedsCalenderBloc, DeedsCalenderState>(
      builder: (context, state) {
        final now = DateTime.now();
        final locale = Localizations.localeOf(context).languageCode;

        if (state is! DeedsCalenderLoadedState) {
          return const Loading();
        }

        final s = S.of(context);
        final dataSource = SlotsDataSourceLoadMore(
          state.deeds.convertToSlot(s),
          state.dataCollection,
          s,
        );

        return Scaffold(
          key: scaffoldKey,
          body: SfCalendar(
            key: ValueKey(locale),
            controller: _controller,
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

            dataSource: dataSource,
            appointmentBuilder: (_, details) => AppointmentCard(
              calendarDetails: details,
            ),
            monthCellBuilder: (_, details) => MonthCellCard(
              monthDetails: details,
            ),
            loadMoreWidgetBuilder: (_, loadMoreAppointments) => FutureBuilder<void>(
              future: loadMoreAppointments(),
              builder: (_, snapShot) {
                return const Loading();
              },
            ),

            onTap: (details) {
              final List<CalendarElement> allowToTouch = [
                CalendarElement.appointment,
                CalendarElement.calendarCell,
              ];

              if (allowToTouch.contains(details.targetElement)) {
                _editDeed(context, bloc, details, scaffoldKey);
              }
            },
            onLongPress: (details) {
              final List<CalendarElement> allowToTouch = [
                CalendarElement.calendarCell,
              ];

              if (allowToTouch.contains(details.targetElement)) {
                _editDeed(context, bloc, details, scaffoldKey);
              }
            },
          ),
        );
      },
    );
  }
}
