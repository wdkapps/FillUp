import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/vehicle.dart';
import '../models/gas_record.dart';
import '../constants/app_constants.dart';

class DatabaseHelper {
  static Database? _database;
  static DatabaseHelper? _instance;
  static bool _testMode = false;

  DatabaseHelper._();
  static DatabaseHelper get instance => _instance ??= DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null && _database!.isOpen) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    if (_testMode) {
      return await openDatabase(
        inMemoryDatabasePath,
        version: AppConstants.dbVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onConfigure: _onConfigure,
      );
    }
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppConstants.dbName);
    return await openDatabase(
      path,
      version: AppConstants.dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onConfigure: _onConfigure,
    );
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Vehicles (
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        tanksize REAL NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE Records (
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        _vid INTEGER NOT NULL,
        time INTEGER NOT NULL,
        odometer INTEGER NOT NULL,
        gallons REAL NOT NULL,
        fulltank INTEGER NOT NULL,
        hidden INTEGER NOT NULL DEFAULT 0,
        cost REAL NOT NULL DEFAULT 0,
        notes TEXT,
        UNIQUE (_vid, odometer),
        FOREIGN KEY (_vid) REFERENCES Vehicles (_id)
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 5) {
      // Add columns for version 5 if upgrading from older version
    }
  }

  // Vehicle CRUD
  Future<int> createVehicle(Vehicle vehicle) async {
    final db = await database;
    return await db.insert('Vehicles', vehicle.toMap());
  }

  Future<int> updateVehicle(Vehicle vehicle) async {
    final db = await database;
    return await db.update(
      'Vehicles',
      vehicle.toMap(),
      where: '_id = ?',
      whereArgs: [vehicle.id],
    );
  }

  Future<List<Vehicle>> readAllVehicles() async {
    final db = await database;
    final maps = await db.query('Vehicles', orderBy: 'name');
    return maps.map((map) => Vehicle.fromMap(map)).toList();
  }

  Future<bool> deleteVehicle(int id) async {
    final db = await database;
    await db.delete('Records', where: '_vid = ?', whereArgs: [id]);
    final count = await db.delete('Vehicles', where: '_id = ?', whereArgs: [id]);
    return count > 0;
  }

  // Gas Record CRUD
  Future<int> createRecord(GasRecord record) async {
    final db = await database;
    return await db.insert('Records', record.toMap());
  }

  Future<int> updateRecord(GasRecord record) async {
    final db = await database;
    return await db.update(
      'Records',
      record.toMap(),
      where: '_id = ?',
      whereArgs: [record.id],
    );
  }

  Future<List<GasRecord>> readAllRecords(int vehicleId) async {
    final db = await database;
    final maps = await db.query(
      'Records',
      where: '_vid = ?',
      whereArgs: [vehicleId],
      orderBy: 'odometer',
    );
    return maps.map((map) => GasRecord.fromMap(map)).toList();
  }

  Future<bool> deleteRecord(int id) async {
    final db = await database;
    final count = await db.delete('Records', where: '_id = ?', whereArgs: [id]);
    return count > 0;
  }

  Future<bool> deleteAllRecords(int vehicleId) async {
    final db = await database;
    await db.delete('Records', where: '_vid = ?', whereArgs: [vehicleId]);
    return true;
  }

  Future<int> readCurrentOdometer(int vehicleId) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT MAX(odometer) as maxOdometer FROM Records WHERE _vid = ?',
      [vehicleId],
    );
    if (result.isNotEmpty && result.first['maxOdometer'] != null) {
      return result.first['maxOdometer'] as int;
    }
    return -1;
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  static Future<void> resetForTest() async {
    _testMode = true;
    if (_database != null && _database!.isOpen) {
      await _database!.close();
    }
    _database = null;
    _instance = null;
  }
}
