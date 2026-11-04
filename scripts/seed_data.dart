// ignore_for_file: avoid_print
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as p;

Future<void> main() async {
  sqfliteFfiInit();

  final dbPath = await getDatabasesPath();
  final path = p.join(dbPath, 'gaslog.db');

  final db = await openDatabase(path, version: 5);

  await db.execute('PRAGMA foreign_keys = ON');

  // Create tables if not exist
  await db.execute('''
    CREATE TABLE IF NOT EXISTS Vehicles (
      _id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL UNIQUE,
      tanksize REAL NOT NULL
    )
  ''');

  await db.execute('''
    CREATE TABLE IF NOT EXISTS Records (
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

  // Clear existing data
  await db.delete('Records');
  await db.delete('Vehicles');

  // Add vehicles
  final toyotaId = await db.insert('Vehicles', {'name': 'Toyota Camry', 'tanksize': 16.0});
  final hondaId = await db.insert('Vehicles', {'name': 'Honda Civic', 'tanksize': 12.4});
  final fordId = await db.insert('Vehicles', {'name': 'Ford F-150', 'tanksize': 26.0});

  // Add fuel records for Toyota Camry (25 records over ~6 months)
  final toyotaRecords = [
    {'_vid': toyotaId, 'time': DateTime(2024, 1, 5).millisecondsSinceEpoch, 'odometer': 45000, 'gallons': 14.2, 'fulltank': 1, 'hidden': 0, 'cost': 48.50, 'notes': ''},
    {'_vid': toyotaId, 'time': DateTime(2024, 1, 19).millisecondsSinceEpoch, 'odometer': 45320, 'gallons': 13.8, 'fulltank': 1, 'hidden': 0, 'cost': 47.20, 'notes': ''},
    {'_vid': toyotaId, 'time': DateTime(2024, 2, 2).millisecondsSinceEpoch, 'odometer': 45650, 'gallons': 14.0, 'fulltank': 1, 'hidden': 0, 'cost': 49.80, 'notes': ''},
    {'_vid': toyotaId, 'time': DateTime(2024, 2, 16).millisecondsSinceEpoch, 'odometer': 45980, 'gallons': 13.5, 'fulltank': 1, 'hidden': 0, 'cost': 46.10, 'notes': 'Highway trip'},
    {'_vid': toyotaId, 'time': DateTime(2024, 3, 1).millisecondsSinceEpoch, 'odometer': 46300, 'gallons': 14.1, 'fulltank': 1, 'hidden': 0, 'cost': 50.20, 'notes': ''},
    {'_vid': toyotaId, 'time': DateTime(2024, 3, 15).millisecondsSinceEpoch, 'odometer': 46620, 'gallons': 13.9, 'fulltank': 1, 'hidden': 0, 'cost': 48.90, 'notes': ''},
    {'_vid': toyotaId, 'time': DateTime(2024, 3, 29).millisecondsSinceEpoch, 'odometer': 46950, 'gallons': 14.3, 'fulltank': 1, 'hidden': 0, 'cost': 51.50, 'notes': ''},
    {'_vid': toyotaId, 'time': DateTime(2024, 4, 12).millisecondsSinceEpoch, 'odometer': 47280, 'gallons': 13.7, 'fulltank': 1, 'hidden': 0, 'cost': 47.80, 'notes': ''},
    {'_vid': toyotaId, 'time': DateTime(2024, 4, 26).millisecondsSinceEpoch, 'odometer': 47600, 'gallons': 14.0, 'fulltank': 1, 'hidden': 0, 'cost': 49.30, 'notes': 'Road trip'},
    {'_vid': toyotaId, 'time': DateTime(2024, 5, 10).millisecondsSinceEpoch, 'odometer': 47940, 'gallons': 14.2, 'fulltank': 1, 'hidden': 0, 'cost': 50.10, 'notes': ''},
    {'_vid': toyotaId, 'time': DateTime(2024, 5, 24).millisecondsSinceEpoch, 'odometer': 48270, 'gallons': 13.6, 'fulltank': 1, 'hidden': 0, 'cost': 47.50, 'notes': ''},
    {'_vid': toyotaId, 'time': DateTime(2024, 6, 7).millisecondsSinceEpoch, 'odometer': 48600, 'gallons': 14.1, 'fulltank': 1, 'hidden': 0, 'cost': 51.20, 'notes': ''},
  ];

  // Add fuel records for Honda Civic (18 records)
  final hondaRecords = [
    {'_vid': hondaId, 'time': DateTime(2024, 1, 10).millisecondsSinceEpoch, 'odometer': 32000, 'gallons': 11.5, 'fulltank': 1, 'hidden': 0, 'cost': 39.80, 'notes': ''},
    {'_vid': hondaId, 'time': DateTime(2024, 1, 28).millisecondsSinceEpoch, 'odometer': 32310, 'gallons': 11.2, 'fulltank': 1, 'hidden': 0, 'cost': 38.50, 'notes': ''},
    {'_vid': hondaId, 'time': DateTime(2024, 2, 14).millisecondsSinceEpoch, 'odometer': 32620, 'gallons': 11.0, 'fulltank': 1, 'hidden': 0, 'cost': 37.90, 'notes': ''},
    {'_vid': hondaId, 'time': DateTime(2024, 3, 3).millisecondsSinceEpoch, 'odometer': 32930, 'gallons': 11.3, 'fulltank': 1, 'hidden': 0, 'cost': 39.20, 'notes': 'Commuting'},
    {'_vid': hondaId, 'time': DateTime(2024, 3, 20).millisecondsSinceEpoch, 'odometer': 33250, 'gallons': 11.1, 'fulltank': 1, 'hidden': 0, 'cost': 38.70, 'notes': ''},
    {'_vid': hondaId, 'time': DateTime(2024, 4, 5).millisecondsSinceEpoch, 'odometer': 33560, 'gallons': 11.4, 'fulltank': 1, 'hidden': 0, 'cost': 40.10, 'notes': ''},
    {'_vid': hondaId, 'time': DateTime(2024, 4, 22).millisecondsSinceEpoch, 'odometer': 33870, 'gallons': 11.0, 'fulltank': 1, 'hidden': 0, 'cost': 37.40, 'notes': ''},
    {'_vid': hondaId, 'time': DateTime(2024, 5, 8).millisecondsSinceEpoch, 'odometer': 34190, 'gallons': 11.2, 'fulltank': 1, 'hidden': 0, 'cost': 38.90, 'notes': ''},
    {'_vid': hondaId, 'time': DateTime(2024, 5, 25).millisecondsSinceEpoch, 'odometer': 34500, 'gallons': 11.5, 'fulltank': 1, 'hidden': 0, 'cost': 40.50, 'notes': 'Long trip'},
    {'_vid': hondaId, 'time': DateTime(2024, 6, 10).millisecondsSinceEpoch, 'odometer': 34810, 'gallons': 11.1, 'fulltank': 1, 'hidden': 0, 'cost': 38.20, 'notes': ''},
  ];

  // Add fuel records for Ford F-150 (10 records)
  final fordRecords = [
    {'_vid': fordId, 'time': DateTime(2024, 2, 1).millisecondsSinceEpoch, 'odometer': 15000, 'gallons': 24.5, 'fulltank': 1, 'hidden': 0, 'cost': 85.80, 'notes': ''},
    {'_vid': fordId, 'time': DateTime(2024, 2, 20).millisecondsSinceEpoch, 'odometer': 15310, 'gallons': 23.8, 'fulltank': 1, 'hidden': 0, 'cost': 82.50, 'notes': ''},
    {'_vid': fordId, 'time': DateTime(2024, 3, 12).millisecondsSinceEpoch, 'odometer': 15620, 'gallons': 24.2, 'fulltank': 1, 'hidden': 0, 'cost': 84.90, 'notes': 'Towing trailer'},
    {'_vid': fordId, 'time': DateTime(2024, 4, 2).millisecondsSinceEpoch, 'odometer': 15930, 'gallons': 24.0, 'fulltank': 1, 'hidden': 0, 'cost': 83.70, 'notes': ''},
    {'_vid': fordId, 'time': DateTime(2024, 4, 22).millisecondsSinceEpoch, 'odometer': 16240, 'gallons': 23.5, 'fulltank': 1, 'hidden': 0, 'cost': 81.20, 'notes': ''},
    {'_vid': fordId, 'time': DateTime(2024, 5, 15).millisecondsSinceEpoch, 'odometer': 16560, 'gallons': 24.8, 'fulltank': 1, 'hidden': 0, 'cost': 86.50, 'notes': 'Moving furniture'},
    {'_vid': fordId, 'time': DateTime(2024, 6, 5).millisecondsSinceEpoch, 'odometer': 16870, 'gallons': 23.9, 'fulltank': 1, 'hidden': 0, 'cost': 83.10, 'notes': ''},
  ];

  for (final record in [...toyotaRecords, ...hondaRecords, ...fordRecords]) {
    await db.insert('Records', record);
  }

  print('=== Sample Data Added ===');
  print('Vehicles: Toyota Camry, Honda Civic, Ford F-150');
  print('Records: ${toyotaRecords.length + hondaRecords.length + fordRecords.length} fuel records');

  // Verify
  final vehicles = await db.query('Vehicles');
  print('\nVehicles in database:');
  for (final v in vehicles) {
    final count = await db.rawQuery(
      'SELECT COUNT(*) as cnt FROM Records WHERE _vid = ?',
      [v['_id']],
    );
    print('  ${v['name']} (${v['tanksize']} gal) - ${count.first['cnt']} records');
  }

  await db.close();
}
