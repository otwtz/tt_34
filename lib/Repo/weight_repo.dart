import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Models/weight_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'entries.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE cur_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, value REAL)',
        ).then((_) {
          return db.execute(
            'CREATE TABLE goal_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, targetWeight REAL)',
          );
        }).then((_) {
          return db.execute(
            'CREATE TABLE start_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, startWeight REAL)',
          );
        });
      },
    );
  }
}

class CurEntryRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<CurEntry>> fetchCurEntries() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('cur_entries');
    return List.generate(maps.length, (i) {
      return CurEntry.fromMap(maps[i]);
    });
  }

  Future<void> addCurEntry(CurEntry entry) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'cur_entries',
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

class GoalEntryRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<GoalEntry>> fetchGoalEntries() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('goal_entries');
    return List.generate(maps.length, (i) {
      return GoalEntry.fromMap(maps[i]);
    });
  }

  Future<void> addGoalEntry(GoalEntry entry) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'goal_entries',
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

class StartEntryRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<StartEntry>> fetchStartEntries() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('start_entries');
    return List.generate(maps.length, (i) {
      return StartEntry.fromMap(maps[i]);
    });
  }

  Future<void> addStartEntry(StartEntry entry) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'start_entries',
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}