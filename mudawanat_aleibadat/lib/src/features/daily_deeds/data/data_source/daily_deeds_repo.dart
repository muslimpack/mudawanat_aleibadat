import 'dart:async';
import 'dart:io';

import 'package:mudawanat_aleibadat/src/core/extension/date_time.dart';
import 'package:mudawanat_aleibadat/src/core/utils/print.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/data/models/daily_deeds.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

DailyDeedsRepo dailyDeedsRepo = DailyDeedsRepo();

class DailyDeedsRepo {
  /* ************* Variables ************* */
  static const String dbName = 'daily_deeds.db';
  static const String tableName = 'daily_deeds';

  /// 1 => initial database
  /// 2 => add lastUpdated column
  static const int dbVersion = 3;

  /* ************* Singleton Constructor ************* */

  static DailyDeedsRepo? _databaseHelper;
  static Database? _database;

  factory DailyDeedsRepo() {
    _databaseHelper ??= DailyDeedsRepo._createInstance();
    return _databaseHelper!;
  }

  DailyDeedsRepo._createInstance();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  /* ************* Database Creation ************* */

  // init
  Future<Database> _initDatabase() async {
    late final String path;
    if (Platform.isWindows) {
      final dbPath = (await getApplicationSupportDirectory()).path;
      path = join(dbPath, dbName);
    } else {
      final dbPath = await getDatabasesPath();
      path = join(dbPath, dbName);
    }

    return openDatabase(
      path,
      version: dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: _onDowngrade,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    appPrint("Creating $tableName Database");
    await db.execute('''
          CREATE TABLE $tableName (
            date INTEGER PRIMARY KEY,
            lastUpdated INTEGER,
            fasting INTEGER,
            
            -- additional
            fajrPre INTEGER,
            dhuhrPre INTEGER,
            dhuhrAfter INTEGER,
            asrPre INTEGER,
            maghribPre INTEGER,
            maghribAfter INTEGER,
            ishaaPre INTEGER,
            ishaaAfter INTEGER,
            doha INTEGER,
            nightPrayer INTEGER,
            
            -- obligatory
            fajr INTEGER,
            dhuhr INTEGER,
            asr INTEGER,
            maghrib INTEGER,
            ishaa INTEGER,
            
            -- awrad
            quran INTEGER,
            azkar INTEGER
          )
        ''');
  }

  FutureOr<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    ///
    if (oldVersion < 2) {
      await db.execute('''
      ALTER TABLE $tableName
      ADD COLUMN lastUpdated INTEGER DEFAULT ;
      ''');
      await db.execute('''
      UPDATE $tableName
      SET lastUpdated = date;
      ''');
    }

    ///
    if (oldVersion < 3) {
      await db.execute('''
      UPDATE $tableName
      SET azkar = azkar * 5;
      ''');
    }
  }

  FutureOr<void> _onDowngrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {}

  ///* ************* Functions ************* */

  Future<void> insertDailyDeeds(DailyDeeds dailyDeeds) async {
    final Database db = await database;

    await db.insert(
      tableName,
      dailyDeeds.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteDailyDeeds(DateTime date) async {
    final Database db = await database;

    await db.delete(
      tableName,
      where: "date = ?",
      whereArgs: [date.dateOnly],
    );
  }

  Future<void> insertList(List<DailyDeeds> list) async {
    final Database db = await database;

    final Batch batch = db.batch();

    for (final DailyDeeds dailyDeeds in list) {
      batch.insert(
        tableName,
        dailyDeeds.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<DailyDeeds>> getAllDailyDeeds() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    final deeds = List.generate(maps.length, (i) {
      return DailyDeeds.fromMap(maps[i]);
    });

    appPrint("getAllDailyDeeds  ${deeds.length}");

    return deeds;
  }

  Future<List<DailyDeeds>> getAllDailyDeedsSortedByDate() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      orderBy: 'date ASC',
    );

    final deeds = List.generate(maps.length, (i) {
      return DailyDeeds.fromMap(maps[i]);
    });

    appPrint("getAllDailyDeedsSortedByDate  ${deeds.length}");

    return deeds;
  }

  Future<List<DailyDeeds>> getDailyDeedsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'date >= ? AND date <= ?',
      whereArgs: [
        startDate.dateOnly.millisecondsSinceEpoch,
        endDate.dateOnly.millisecondsSinceEpoch,
      ],
    );

    final deeds = List.generate(maps.length, (i) {
      return DailyDeeds.fromMap(maps[i]);
    });

    return deeds;
  }

  Future<void> deleteAllDailyDeeds() async {
    final Database db = await database;
    await db.delete(tableName);
  }

  Future<DailyDeeds?> getDailyDeedsByDate(DateTime date) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'date = ?',
      whereArgs: [date.dateOnly.millisecondsSinceEpoch],
    );

    if (maps.isEmpty) {
      return null; // Return null if no record is found for the given date
    }

    return DailyDeeds.fromMap(maps.first);
  }

  Future<DateTime?> getLastAddedDate() async {
    final Database db = await database;

    // Use the aggregate function MAX to get the maximum date from the 'daily_deeds' table
    final maps =
        await db.rawQuery('SELECT MAX(date) as maxDate FROM $tableName');

    appPrint(maps);

    if (maps.isNotEmpty) {
      // The result will contain a single row with the maximum date
      final maxDateMilliseconds = maps.first['maxDate'] as int?;
      if (maxDateMilliseconds == null) return null;
      return DateTime.fromMillisecondsSinceEpoch(maxDateMilliseconds);
    }

    return null; // Return null if the table is empty
  }

  Future addMissingDays() async {
    final DateTime? dbLastAdded = await getLastAddedDate();

    final List<DateTime> dates;

    if (dbLastAdded == null) {
      dates = [DateTime.now().dateOnly];
    } else {
      dates = _missingDays(dbLastAdded);
    }

    appPrint("LastDate: $dbLastAdded || Missing Days: ${dates.length}");
    appPrint("Missing Days:");
    for (final date in dates) {
      appPrint(date);
    }

    await insertList(
      dates.map((e) {
        return DailyDeeds.empty(date: e.dateOnly);
      }).toList(),
    );
  }

  List<DateTime> _missingDays(DateTime lastAddedDate) {
    // Get the current date
    final DateTime currentDate = DateTime.now();

    if (lastAddedDate == currentDate) return [];

    final List<DateTime> missingDates = [];

    // Iterate from lastAddedDate to currentDate and add each date to the list
    for (DateTime date = lastAddedDate.add(const Duration(days: 1));
        date.isBefore(currentDate);
        date = date.add(const Duration(days: 1))) {
      missingDates.add(date);
    }

    return missingDates;
  }

  Future<int> sumColumn(String columnName) async {
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT SUM($columnName) as total FROM $tableName
    ''');

    final int total = result.first['total'] as int? ?? 0;
    return total;
  }

  Future<int> countColumn(String columnName) async {
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT SUM($columnName) as total FROM $tableName
    ''');

    final int total = result.first['total'] as int? ?? 0;
    return total;
  }

  Future<int> countNonZeroValues(String columnName) async {
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT COUNT($columnName) as count FROM $tableName WHERE $columnName != 0
    ''');

    final int count = Sqflite.firstIntValue(result) ?? 0;
    return count;
  }

  Future<int> daysCount() async {
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT COUNT(*) as count FROM $tableName
    ''');

    final int count = Sqflite.firstIntValue(result) ?? 0;
    return count;
  }

  Future<Map<DateTime, int>> getMapDateColumn(
    List<String> columnNames, [
    int? days,
  ]) async {
    final Database db = await database;
    final daysCondition = days != null
        ? """
(
  SELECT *
  FROM $tableName
  ORDER BY date DESC
  limit $days
) AS subquery
    """
        : tableName;
    final List<Map<String, dynamic>> rows = await db.rawQuery('''
      SELECT
        date,
        ${columnNames.map((col) => 'COALESCE(SUM($col), 0) AS $col').join(', ')}
      FROM $daysCondition
      GROUP BY date
      ORDER BY date
    ''');

    final Map<DateTime, int> result = {};

    for (final Map<String, dynamic> row in rows) {
      final DateTime date =
          DateTime.fromMillisecondsSinceEpoch(row['date'] as int);
      int sum = 0;

      for (final String columnName in columnNames) {
        sum += row[columnName] as int;
      }

      result[date] = sum;
    }

    return result;
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
