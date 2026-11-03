import 'dart:io';
import 'dart:math';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as p;

/// Demo data tool for FillUp.
///
/// Usage:
///   dart run lib/tools/demo_data.dart fill
///   dart run lib/tools/demo_data.dart reset
Future<void> main(List<String> args) async {
  if (args.isEmpty || (args[0] != 'fill' && args[0] != 'reset')) {
    print('Usage: dart run lib/tools/demo_data.dart <fill|reset>');
    exit(1);
  }

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  final dbPath = p.join(await getDatabasesPath(), 'gaslog.db');
  print('Database: $dbPath');

  final db = await openDatabase(
    dbPath,
    version: 5,
    onConfigure: (db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    },
    onCreate: (db, version) async {
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
    },
  );

  if (args[0] == 'fill') {
    await fillDemo(db);
  } else {
    await resetDemo(db);
  }

  await db.close();
}

Future<void> fillDemo(Database db) async {
  final existing = await db.query('Vehicles');
  if (existing.isNotEmpty) {
    print('Database already has ${existing.length} vehicle(s). Use "reset" first to clear.');
    return;
  }

  print('Filling demo data...');

  final vehicles = [
    {'name': 'Toyota Camry', 'tanksize': 60.0},
    {'name': 'Honda Civic', 'tanksize': 47.0},
    {'name': 'Ford F-150', 'tanksize': 95.0},
    {'name': 'BMW X5', 'tanksize': 85.0},
    {'name': 'Mercedes-Benz C300', 'tanksize': 66.0},
    {'name': 'Hyundai Tucson', 'tanksize': 54.0},
    {'name': 'Chevrolet Malibu', 'tanksize': 55.0},
    {'name': 'Nissan Altima', 'tanksize': 61.0},
    {'name': 'Kia Sportage', 'tanksize': 54.0},
    {'name': 'Volkswagen Golf', 'tanksize': 50.0},
    {'name': 'Tesla Model 3', 'tanksize': 0.0},
    {'name': 'Mazda CX-5', 'tanksize': 56.0},
  ];

  for (final v in vehicles) {
    await db.insert('Vehicles', v);
  }
  print('  Created ${vehicles.length} vehicles');

  final allVehicles = await db.query('Vehicles');
  final random = Random(42);
  int totalRecords = 0;

  for (final vehicle in allVehicles) {
    final vehicleId = vehicle['_id'] as int;
    final tankSize = vehicle['tanksize'] as double;
    final name = vehicle['name'] as String;

    if (name == 'Tesla Model 3') continue;

    final recordCount = 15 + random.nextInt(11);
    var odometer = 10000 + random.nextInt(50000);
    var fuelPrice = 3.20 + random.nextDouble() * 1.5;

    for (var i = 0; i < recordCount; i++) {
      odometer += 200 + random.nextInt(400);

      final tankFraction = 0.80 + random.nextDouble() * 0.20;
      final gallons = tankSize * tankFraction;
      final isFull = i % 3 == 0;
      final cost = gallons * fuelPrice;
      fuelPrice += (random.nextDouble() - 0.5) * 0.15;
      fuelPrice = fuelPrice.clamp(2.80, 5.50);

      final daysAgo = (recordCount - i) * (180 ~/ recordCount) + random.nextInt(5);
      final date = DateTime.now().subtract(Duration(days: daysAgo));

      await db.insert('Records', {
        '_vid': vehicleId,
        'time': date.millisecondsSinceEpoch,
        'odometer': odometer,
        'gallons': double.parse(gallons.toStringAsFixed(3)),
        'fulltank': isFull ? 1 : 0,
        'hidden': 0,
        'cost': double.parse(cost.toStringAsFixed(3)),
        'notes': isFull ? 'Full tank' : '',
      });
      totalRecords++;
    }
  }

  print('  Created $totalRecords fuel records');
  print('Demo data filled successfully!');
}

Future<void> resetDemo(Database db) async {
  final vehicles = await db.query('Vehicles');
  if (vehicles.isEmpty) {
    print('Database is already empty. Nothing to reset.');
    return;
  }

  print('Resetting demo data...');
  final recordCount = await db.rawQuery('SELECT COUNT(*) as cnt FROM Records');
  await db.delete('Records');
  await db.delete('Vehicles');
  print('Deleted ${vehicles.length} vehicle(s) and ${recordCount.first['cnt']} record(s).');
  print('Database reset successfully!');
}
