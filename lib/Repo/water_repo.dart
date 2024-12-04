import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Models/water_model.dart';

class DatabaseHelperWater {
  static final DatabaseHelperWater _instance = DatabaseHelperWater._internal();
  factory DatabaseHelperWater() => _instance;

  static Database? _database;

  DatabaseHelperWater._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<List<WaterEntry>> getWaterEntriesForWeek(DateTime startDate) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'water_entries',
      where: 'date >= ? AND date <= ?',
      whereArgs: [
        startDate.toIso8601String(),
        startDate.add(Duration(days: 6)).toIso8601String(),
      ],
    );

    return List.generate(maps.length, (i) {
      return WaterEntry.fromMap(maps[i]);
    });
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'water_tracker.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE water_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, amount REAL)',
        );
      },
    );
  }

  Future<void> insertWaterEntry(WaterEntry entry) async {
    final db = await database;
    await db.insert(
      'water_entries',
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<WaterEntry>> getWaterEntries(DateTime date) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'water_entries',
      where: 'date = ?',
      whereArgs: [date.toIso8601String()],
    );

    return List.generate(maps.length, (i) {
      return WaterEntry.fromMap(maps[i]);
    });
  }
}