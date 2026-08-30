import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:fillup/database/database_helper.dart';
import 'package:fillup/models/vehicle.dart';
import 'package:fillup/models/gas_record.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    await DatabaseHelper.resetForTest();
  });

  group('Database CRUD Operations', () {
    test('Create and read vehicles', () async {
      final db = DatabaseHelper.instance;

      final v1 = Vehicle(name: 'Toyota Camry', tankSize: 16.0);
      final v2 = Vehicle(name: 'Honda Civic', tankSize: 12.5);

      final id1 = await db.createVehicle(v1);
      final id2 = await db.createVehicle(v2);

      expect(id1, greaterThan(0));
      expect(id2, greaterThan(0));
      expect(id1, isNot(equals(id2)));

      final vehicles = await db.readAllVehicles();
      expect(vehicles.length, 2);

      final names = vehicles.map((v) => v.name).toList();
      expect(names, contains('Toyota Camry'));
      expect(names, contains('Honda Civic'));
    });

    test('Update vehicle', () async {
      final db = DatabaseHelper.instance;

      final vehicle = Vehicle(name: 'Ford F150', tankSize: 26.0);
      final id = await db.createVehicle(vehicle);

      final updated = Vehicle(id: id, name: 'Ford F150 2024', tankSize: 30.0);
      final rowsAffected = await db.updateVehicle(updated);
      expect(rowsAffected, 1);

      final vehicles = await db.readAllVehicles();
      expect(vehicles.length, 1);
      expect(vehicles.first.name, 'Ford F150 2024');
      expect(vehicles.first.tankSize, 30.0);
    });

    test('Delete vehicle cascades to records', () async {
      final db = DatabaseHelper.instance;

      final vehicle = Vehicle(name: 'Delete Me', tankSize: 15.0);
      final vid = await db.createVehicle(vehicle);

      final record = GasRecord(
        vehicleId: vid,
        date: DateTime(2024, 1, 15),
        odometer: 10000,
        gallons: 10.5,
        cost: 35.0,
        fullTank: true,
      );
      await db.createRecord(record);

      final recordsBefore = await db.readAllRecords(vid);
      expect(recordsBefore.length, 1);

      final deleted = await db.deleteVehicle(vid);
      expect(deleted, true);

      final vehicles = await db.readAllVehicles();
      expect(vehicles.length, 0);

      final recordsAfter = await db.readAllRecords(vid);
      expect(recordsAfter.length, 0);
    });

    test('Create and read gas records', () async {
      final db = DatabaseHelper.instance;

      final vehicle = Vehicle(name: 'Test Car', tankSize: 15.0);
      final vid = await db.createVehicle(vehicle);

      final r1 = GasRecord(
        vehicleId: vid,
        date: DateTime(2024, 1, 1),
        odometer: 10000,
        gallons: 10.0,
        cost: 35.0,
        fullTank: true,
      );
      final r2 = GasRecord(
        vehicleId: vid,
        date: DateTime(2024, 1, 15),
        odometer: 10300,
        gallons: 12.0,
        cost: 42.0,
        fullTank: false,
        notes: 'Highway trip',
      );

      final id1 = await db.createRecord(r1);
      final id2 = await db.createRecord(r2);

      expect(id1, greaterThan(0));
      expect(id2, greaterThan(0));

      final records = await db.readAllRecords(vid);
      expect(records.length, 2);

      final sorted = records..sort((a, b) => a.odometer.compareTo(b.odometer));
      expect(sorted.first.odometer, 10000);
      expect(sorted.last.odometer, 10300);
      expect(sorted.last.notes, 'Highway trip');
    });

    test('Update gas record', () async {
      final db = DatabaseHelper.instance;

      final vehicle = Vehicle(name: 'Update Test', tankSize: 15.0);
      final vid = await db.createVehicle(vehicle);

      final record = GasRecord(
        vehicleId: vid,
        date: DateTime(2024, 2, 1),
        odometer: 5000,
        gallons: 8.0,
        cost: 28.0,
        fullTank: true,
      );
      final id = await db.createRecord(record);

      final updated = GasRecord(
        id: id,
        vehicleId: vid,
        date: DateTime(2024, 2, 1),
        odometer: 5000,
        gallons: 9.5,
        cost: 33.25,
        fullTank: true,
        notes: 'Corrected amount',
      );
      final rowsAffected = await db.updateRecord(updated);
      expect(rowsAffected, 1);

      final records = await db.readAllRecords(vid);
      expect(records.length, 1);
      expect(records.first.gallons, 9.5);
      expect(records.first.cost, 33.25);
      expect(records.first.notes, 'Corrected amount');
    });

    test('Delete gas record', () async {
      final db = DatabaseHelper.instance;

      final vehicle = Vehicle(name: 'Delete Record Test', tankSize: 15.0);
      final vid = await db.createVehicle(vehicle);

      final record = GasRecord(
        vehicleId: vid,
        date: DateTime(2024, 3, 1),
        odometer: 7000,
        gallons: 10.0,
        cost: 35.0,
        fullTank: true,
      );
      final id = await db.createRecord(record);

      final deleted = await db.deleteRecord(id);
      expect(deleted, true);

      final records = await db.readAllRecords(vid);
      expect(records.length, 0);
    });

    test('Read current odometer', () async {
      final db = DatabaseHelper.instance;

      final vehicle = Vehicle(name: 'Odometer Test', tankSize: 15.0);
      final vid = await db.createVehicle(vehicle);

      final maxOdo = await db.readCurrentOdometer(vid);
      expect(maxOdo, -1);

      await db.createRecord(GasRecord(
        vehicleId: vid,
        date: DateTime(2024, 1, 1),
        odometer: 5000,
        gallons: 10.0,
        cost: 35.0,
        fullTank: true,
      ));
      await db.createRecord(GasRecord(
        vehicleId: vid,
        date: DateTime(2024, 1, 15),
        odometer: 5300,
        gallons: 12.0,
        cost: 42.0,
        fullTank: true,
      ));

      final current = await db.readCurrentOdometer(vid);
      expect(current, 5300);
    });

    test('Delete all records for vehicle', () async {
      final db = DatabaseHelper.instance;

      final vehicle = Vehicle(name: 'Bulk Delete', tankSize: 15.0);
      final vid = await db.createVehicle(vehicle);

      for (int i = 0; i < 5; i++) {
        await db.createRecord(GasRecord(
          vehicleId: vid,
          date: DateTime(2024, 1, 1 + i),
          odometer: 5000 + (i * 300),
          gallons: 10.0,
          cost: 35.0,
          fullTank: true,
        ));
      }

      var records = await db.readAllRecords(vid);
      expect(records.length, 5);

      await db.deleteAllRecords(vid);

      records = await db.readAllRecords(vid);
      expect(records.length, 0);
    });

    test('Multiple vehicles with separate records', () async {
      final db = DatabaseHelper.instance;

      final v1 = Vehicle(name: 'Car A', tankSize: 15.0);
      final v2 = Vehicle(name: 'Car B', tankSize: 20.0);
      final vid1 = await db.createVehicle(v1);
      final vid2 = await db.createVehicle(v2);

      await db.createRecord(GasRecord(
        vehicleId: vid1,
        date: DateTime(2024, 1, 1),
        odometer: 1000,
        gallons: 10.0,
        cost: 35.0,
        fullTank: true,
      ));
      await db.createRecord(GasRecord(
        vehicleId: vid2,
        date: DateTime(2024, 1, 1),
        odometer: 5000,
        gallons: 15.0,
        cost: 52.5,
        fullTank: true,
      ));

      final records1 = await db.readAllRecords(vid1);
      final records2 = await db.readAllRecords(vid2);

      expect(records1.length, 1);
      expect(records2.length, 1);
      expect(records1.first.odometer, 1000);
      expect(records2.first.odometer, 5000);
    });

    test('Duplicate odometer unique constraint', () async {
      final db = DatabaseHelper.instance;

      final vehicle = Vehicle(name: 'Unique Test', tankSize: 15.0);
      final vid = await db.createVehicle(vehicle);

      await db.createRecord(GasRecord(
        vehicleId: vid,
        date: DateTime(2024, 1, 1),
        odometer: 5000,
        gallons: 10.0,
        cost: 35.0,
        fullTank: true,
      ));

      expect(
        () => db.createRecord(GasRecord(
          vehicleId: vid,
          date: DateTime(2024, 1, 2),
          odometer: 5000,
          gallons: 10.0,
          cost: 35.0,
          fullTank: true,
        )),
        throwsA(anything),
      );
    });

    test('Vehicle name uniqueness constraint', () async {
      final db = DatabaseHelper.instance;

      await db.createVehicle(Vehicle(name: 'Unique Name', tankSize: 15.0));

      expect(
        () => db.createVehicle(Vehicle(name: 'Unique Name', tankSize: 20.0)),
        throwsA(anything),
      );
    });
  });
}
