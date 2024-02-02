import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/screens/daily_deeds_calender_view.dart';
import 'package:mudawanat_aleibadat/src/features/daily_statistics/presentation/screens/daily_deeds_statistics_view.dart';
import 'package:mudawanat_aleibadat/src/features/daily_summary/presentation/screens/daily_deeds_summary_view.dart';
import 'package:mudawanat_aleibadat/src/features/theme/presentation/screens/theme_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const ThemeScreen();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const [
          DailyDeedsCalenderView(),
          DailyDeedsSummaryView(),
          DailyDeedsStatisticsView(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabController.index,
        onDestinationSelected: (value) {
          setState(() {
            _tabController.animateTo(value);
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(FontAwesomeIcons.calendarDays),
            label: S.of(context).calender,
          ),
          NavigationDestination(
            icon: const Icon(FontAwesomeIcons.fileInvoice),
            label: S.of(context).summary,
          ),
          NavigationDestination(
            icon: const Icon(FontAwesomeIcons.chartLine),
            label: S.of(context).statistics,
          ),
        ],
      ),
    );
  }
}
