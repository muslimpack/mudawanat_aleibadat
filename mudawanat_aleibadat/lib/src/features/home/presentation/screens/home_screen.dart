import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/screens/daily_deeds_calender_view.dart';
import 'package:mudawanat_aleibadat/src/features/daily_summary/presentation/screens/daily_deeds_statistics_view.dart';
import 'package:mudawanat_aleibadat/src/features/theme/presentation/screens/theme_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: TabBar(
              tabAlignment: TabAlignment.center,
              isScrollable: true,
              tabs: <Widget>[
                Tab(
                  text: S.of(context).calender,
                ),
                Tab(
                  text: S.of(context).statistics,
                ),
              ],
            ),
          ),
        ),
        body: const Expanded(
          child: TabBarView(
            children: [
              DailyDeedsCalenderView(),
              DailyDeedsStatisticsView(),
            ],
          ),
        ),
      ),
    );
  }
}
