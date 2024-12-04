import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tt_34/Models/entry_model.dart';

class RecordRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'records.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE records(id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, date TEXT)',
        );
      },
    );
  }

  Future<void> addRecord(Entry record) async {
    final db = await database;
    await db.insert(
      'records',
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateRecord(Entry record) async {
    final db = await database;
    await db.update(
      'records',
      record.toMap(),
      where: 'id = ?',
      whereArgs: [record.id],
    );
  }

  Future<void> deleteRecord(int id) async {
    final db = await database;
    await db.delete(
      'records',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Entry>> getRecordsByDate(DateTime date) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'records',
      where: 'date >= ? AND date < ?',
      whereArgs: [
        DateTime(date.year, date.month, date.day).toIso8601String(),
        DateTime(date.year, date.month, date.day + 1).toIso8601String(),
      ],
    );
    return List.generate(maps.length, (i) {
      return Entry.fromMap(maps[i]);
    });
  }

  Future<List<Entry>> getAllRecords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('records');
    return List.generate(maps.length, (i) {
      return Entry.fromMap(maps[i]);
    });
  }
}