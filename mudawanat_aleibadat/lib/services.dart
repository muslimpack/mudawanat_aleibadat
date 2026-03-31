import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mudawanat_aleibadat/src/core/constants/constants.dart';
import 'package:mudawanat_aleibadat/src/core/extension/extension_platform.dart';
import 'package:mudawanat_aleibadat/src/core/managers/file_manager.dart';
import 'package:mudawanat_aleibadat/src/core/repos/local_storage_repo.dart';
import 'package:mudawanat_aleibadat/src/core/utils/app_bloc_observer.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';

Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();

  final packageInfo = await PackageInfo.fromPlatform();
  kAppVersion = "${packageInfo.version} (${packageInfo.buildNumber})";

  Bloc.observer = AppBlocObserver();

  if (PlatformExtension.isDesktopOrWeb) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  await initHive();
  await LocalStorageRepo.init();
  await FileManager.init();

  if (PlatformExtension.isDesktop) {
    await windowManager.ensureInitialized();

    final WindowOptions windowOptions = WindowOptions(
      size: LocalStorageRepo.desktopWindowSize,
      center: true,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
        windowButtonVisibility: false,
      );
      await windowManager.show();
      await windowManager.focus();
    });
  }
}

Future initHive() async {
  await Hive.initFlutter();
  if (!kIsWeb) {
    final dir = await getApplicationSupportDirectory();
    Hive.init(dir.path);
  }
}
