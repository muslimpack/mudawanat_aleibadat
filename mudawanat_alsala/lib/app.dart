import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mudawanat_alsala/generated/l10n.dart';
import 'package:mudawanat_alsala/scroll_behavior.dart';
import 'package:mudawanat_alsala/src/core/repos/local_storage_repo.dart';
import 'package:mudawanat_alsala/src/features/home/presentation/screens/home_screen.dart';
import 'package:mudawanat_alsala/src/features/theme/presentation/controller/cubit/theme_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return GetMaterialApp(
            /// to force update GetMaterialApp
            key: GlobalKey(),
            debugShowCheckedModeBanner: false,
            scrollBehavior: AppScrollBehavior(),
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            onGenerateTitle: (context) => S.of(context).appTitle,
            theme: state.useOldTheme
                ? ThemeData(
                    useMaterial3: state.useMaterial3,
                    brightness: state.brightness,
                    colorSchemeSeed: state.color,
                    fontFamily:
                        state.locale?.languageCode == "ar" ? "Cairo" : null,
                  )
                : ThemeData(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: state.color,
                      brightness: state.brightness,
                    ),
                    fontFamily:
                        state.locale?.languageCode == "ar" ? "Cairo" : null,
                    useMaterial3: state.useMaterial3,
                  ),
            locale: state.locale,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
