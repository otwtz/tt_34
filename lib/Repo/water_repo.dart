import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Models/water_model.dart';

class WaterEntryRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'water_entry.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE water_entry(id INTEGER PRIMARY KEY AUTOINCREMENT, amount INTEGER, date TEXT)',
        );
      },
    );
  }

  Future<void> addWaterEntry(WaterEntry waterEntry) async {
    final db = await database;
    await db.insert(
      'water_entry',
      waterEntry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateWaterEntry(WaterEntry waterEntry) async {
    final db = await database;
    await db.update(
      'water_entry',
      waterEntry.toMap(),
      where: 'id = ?',
      whereArgs: [waterEntry.id],
    );
  }

  Future<void> deleteWaterEntry(int id) async {
    final db = await database;
    await db.delete(
      'water_entry',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<WaterEntry>> getWaterEntryByDate(DateTime date) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'water_entry',
      where: 'date >= ? AND date < ?',
      whereArgs: [
        DateTime(date.year, date.month, date.day).toIso8601String(),
        DateTime(date.year, date.month, date.day + 1).toIso8601String(),
      ],
    );
    return List.generate(maps.length, (i) {
      return WaterEntry.fromMap(maps[i]);
    });
  }

  Future<List<WaterEntry>> getAllWaterEntry() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('water_entry');
    return List.generate(maps.length, (i) {
      return WaterEntry.fromMap(maps[i]);
    });
  }
}