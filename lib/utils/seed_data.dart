import 'dart:math';
import '../database/database_helper.dart';
import '../models/vehicle.dart';
import '../models/gas_record.dart';

class SeedData {
  static Future<void> seed() async {
    final db = DatabaseHelper.instance;
    final vehicles = await db.readAllVehicles();

    for (final v in vehicles) {
      final records = await db.readAllRecords(v.id!);
      if (records.isNotEmpty) return;
    }

    await _fill();
  }

  static Future<void> fill() async {
    await _fill();
  }

  static Future<void> reset() async {
    final db = DatabaseHelper.instance;
    final vehicles = await db.readAllVehicles();
    if (vehicles.isEmpty) return;

    for (final v in vehicles) {
      await db.deleteAllRecords(v.id!);
    }
    for (final v in vehicles) {
      await db.deleteVehicle(v.id!);
    }
  }

  static Future<void> _fill() async {
    final db = DatabaseHelper.instance;

    final existingVehicles = await db.readAllVehicles();
    if (existingVehicles.isEmpty) {
      final seedVehicles = [
        Vehicle(name: 'Toyota Camry', tankSize: 60.0),
        Vehicle(name: 'Honda Civic', tankSize: 47.0),
        Vehicle(name: 'Ford F-150', tankSize: 95.0),
        Vehicle(name: 'BMW X5', tankSize: 85.0),
        Vehicle(name: 'Mercedes-Benz C300', tankSize: 66.0),
        Vehicle(name: 'Hyundai Tucson', tankSize: 54.0),
        Vehicle(name: 'Chevrolet Malibu', tankSize: 55.0),
        Vehicle(name: 'Nissan Altima', tankSize: 61.0),
        Vehicle(name: 'Kia Sportage', tankSize: 54.0),
        Vehicle(name: 'Volkswagen Golf', tankSize: 50.0),
        Vehicle(name: 'Tesla Model 3', tankSize: 0.0),
        Vehicle(name: 'Mazda CX-5', tankSize: 56.0),
      ];

      for (final v in seedVehicles) {
        await db.createVehicle(v);
      }
    }

    final allVehicles = await db.readAllVehicles();
    final random = Random(42);

    for (final vehicle in allVehicles) {
      if (vehicle.name == 'Tesla Model 3') continue;

      final existingRecords = await db.readAllRecords(vehicle.id!);
      if (existingRecords.isNotEmpty) continue;

      final recordCount = 15 + random.nextInt(11);
      var odometer = 10000 + random.nextInt(50000);
      var fuelPrice = 3.20 + random.nextDouble() * 1.5;

      for (var i = 0; i < recordCount; i++) {
        odometer += 200 + random.nextInt(400);

        final tankFraction = 0.80 + random.nextDouble() * 0.20;
        final gallons = vehicle.tankSize * tankFraction;
        final isFull = i % 3 == 0;
        final cost = gallons * fuelPrice;
        fuelPrice += (random.nextDouble() - 0.5) * 0.15;
        fuelPrice = fuelPrice.clamp(2.80, 5.50);

        final daysAgo = (recordCount - i) * (180 ~/ recordCount) + random.nextInt(5);
        final date = DateTime.now().subtract(Duration(days: daysAgo));

        final record = GasRecord(
          vehicleId: vehicle.id!,
          date: date,
          odometer: odometer,
          gallons: double.parse(gallons.toStringAsFixed(3)),
          cost: double.parse(cost.toStringAsFixed(3)),
          price: double.parse(fuelPrice.toStringAsFixed(3)),
          fullTank: isFull,
          notes: isFull ? 'Full tank' : '',
        );

        await db.createRecord(record);
      }
    }
  }

  static Future<int> getVehicleCount() async {
    final db = DatabaseHelper.instance;
    final vehicles = await db.readAllVehicles();
    return vehicles.length;
  }

  static Future<int> getRecordCount() async {
    final db = DatabaseHelper.instance;
    final vehicles = await db.readAllVehicles();
    int total = 0;
    for (final v in vehicles) {
      final records = await db.readAllRecords(v.id!);
      total += records.length;
    }
    return total;
  }
}
