import 'dart:io';

import 'package:mudawanat_alsala/src/core/repos/local_storage_repo.dart';
import 'package:mudawanat_alsala/src/core/utils/print.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class FileManager {
  static late String folderPath;
  static const String baseFolderName = "mudawanat_alsala";
  static const String dbsFolderName = "databases";
  static String appDirPath = path.join(folderPath, baseFolderName);
  static String databasesDirPath = path.join(appDirPath, dbsFolderName);

  factory FileManager() {
    return instance;
  }

  static Future init() async {
    String? pathFromSaved = LocalStorageRepo.appFolderPath;

    if (pathFromSaved == null) {
      pathFromSaved = (await getApplicationSupportDirectory()).path;
      await LocalStorageRepo.changeAppFolderPath(value: pathFromSaved);
    }
    appPrint(pathFromSaved);
    folderPath = pathFromSaved;

    await _createAppDirectory();
  }

  static Future _createAppDirectory() async {
    await Directory(appDirPath).create(recursive: true);
    await Directory(databasesDirPath).create(recursive: true);
  }

  FileManager._();
  static FileManager instance = FileManager._();

  static Future<List<Directory>> getExternalStorages() async {
    final List<Directory> allDirs = [];
    allDirs.add(await getApplicationSupportDirectory());
    allDirs.addAll(await getExternalStorageDirectories() ?? []);

    return allDirs;
  }

  static Future<bool> copyDirectory({
    required String from,
    required String to,
  }) async {
    appPrint("copyDirectory from $from to $to");
    final List<FileSystemEntity> contents = Directory(from).listSync();

    final Directory destinationDirectory = Directory(to);
    if (!destinationDirectory.existsSync()) {
      destinationDirectory.createSync(recursive: true);
    }

    for (final item in contents) {
      if (item is File) {
        try {
          final String destinationFilePath =
              path.join(to, path.basename(item.path));
          await item.copy(destinationFilePath);
        } catch (e) {
          return false;
        }
      } else if (item is Directory) {
        try {
          final String subdirectoryName = path.basename(item.path);
          final String newSubdirectoryPath = path.join(to, subdirectoryName);
          await copyDirectory(from: item.path, to: newSubdirectoryPath);
        } catch (e) {
          return false;
        }
      }
    }

    return true;
  }

  static Future<bool> moveDirectory({
    required String from,
    required String to,
  }) async {
    appPrint("copyDirectory from $from to $to");
    final List<FileSystemEntity> contents = Directory(from).listSync();

    final Directory destinationDirectory = Directory(to);
    if (!destinationDirectory.existsSync()) {
      destinationDirectory.createSync(recursive: true);
    }

    for (final item in contents) {
      if (item is File) {
        try {
          final String destinationFilePath =
              path.join(to, path.basename(item.path));
          await item.copy(destinationFilePath);
          item.deleteSync();
        } catch (e) {
          return false;
        }
      } else if (item is Directory) {
        try {
          final String subdirectoryName = path.basename(item.path);
          final String newSubdirectoryPath = path.join(to, subdirectoryName);
          await copyDirectory(from: item.path, to: newSubdirectoryPath);
        } catch (e) {
          return false;
        }
      }
    }

    Directory(from).deleteSync(recursive: true);

    return true;
  }
}
