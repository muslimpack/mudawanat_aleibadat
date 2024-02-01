import 'package:flutter/material.dart';
import 'package:mudawanat_alsala/src/core/repos/local_storage_repo.dart';
import 'package:window_manager/window_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowResize() {
    super.onWindowResize();
    LocalStorageRepo.changeDesktopWindowSize(MediaQuery.of(context).size);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mudawanat alsala',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const Scaffold(),
    );
  }
}
