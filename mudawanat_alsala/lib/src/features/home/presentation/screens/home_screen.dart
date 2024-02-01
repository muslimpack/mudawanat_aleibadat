import 'package:flutter/material.dart';
import 'package:mudawanat_alsala/generated/l10n.dart';
import 'package:mudawanat_alsala/src/features/daily_deeds/presentation/screens/daily_deeds_dashboard.dart';
import 'package:mudawanat_alsala/src/features/theme/presentation/screens/theme_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: const DailyDeedsDashBoard(),
    );
  }
}
