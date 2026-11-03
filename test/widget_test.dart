import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:FillUp/database/database_helper.dart';
import 'package:FillUp/models/vehicle.dart';
import 'package:FillUp/controllers/vehicle_controller.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    await DatabaseHelper.resetForTest();
    Get.reset();
  });

  tearDown(() async {
    Get.reset();
  });

  test('Vehicle controller loads empty list', () async {
    final controller = Get.put(VehicleController());
    await Future.delayed(const Duration(milliseconds: 500));
    expect(controller.vehicles, isEmpty);
  });

  test('Vehicle controller add and delete', () async {
    final controller = Get.put(VehicleController());
    await Future.delayed(const Duration(milliseconds: 500));

    final vehicle = Vehicle(name: 'Test Vehicle', tankSize: 15.0);
    await controller.addVehicle(vehicle);
    await Future.delayed(const Duration(milliseconds: 200));
    expect(controller.vehicles.length, 1);
    expect(controller.vehicles.first.name, 'Test Vehicle');

    final id = controller.vehicles.first.id!;
    await controller.deleteVehicle(id);
    await Future.delayed(const Duration(milliseconds: 200));
    expect(controller.vehicles.length, 0);
  });
}
