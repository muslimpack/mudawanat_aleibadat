import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mudawanat_alsala/src/core/extension/extension_platform.dart';
import 'package:mudawanat_alsala/src/core/managers/file_manager.dart';
import 'package:mudawanat_alsala/src/core/repos/local_storage_repo.dart';
import 'package:mudawanat_alsala/src/core/utils/app_bloc_observer.dart';
import 'package:mudawanat_alsala/src/core/utils/device_bars.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';

Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = AppBlocObserver();

  if (PlatformExtension.isDesktopOrWeb) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  await FileManager.init();
  await LocalStorageRepo.init();

  deviceBarsTransparent();

  if (PlatformExtension.isDesktop) {
    await windowManager.ensureInitialized();

    final WindowOptions windowOptions = WindowOptions(
      size: LocalStorageRepo.desktopWindowSize,
      center: true,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  await initHive();
}

Future initHive() async {
  await Hive.initFlutter();
  if (!kIsWeb) {
    final dir = LocalStorageRepo.appFolderPath;
    Hive.init(dir);
  }
}
