import 'package:get/get.dart';
import '../models/vehicle.dart';
import '../database/database_helper.dart';
import '../controllers/settings_controller.dart';
import '../utils/gas_record_list.dart';

class VehicleController extends GetxController {
  final _vehicles = <Vehicle>[].obs;
  final _currentVehicle = Rxn<Vehicle>();
  final _isLoading = false.obs;

  List<Vehicle> get vehicles => _vehicles;
  Vehicle? get currentVehicle => _currentVehicle.value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    loadVehicles();
  }

  Future<void> loadVehicles() async {
    _isLoading.value = true;
    try {
      final db = DatabaseHelper.instance;
      _vehicles.value = await db.readAllVehicles();
      if (_vehicles.isNotEmpty && _currentVehicle.value == null) {
        _currentVehicle.value = _vehicles.first;
      }
    } finally {
      _isLoading.value = false;
    }
  }

  Future<bool> addVehicle(Vehicle vehicle) async {
    try {
      Vehicle.validateName(vehicle.name);
      Vehicle.validateTankSize(vehicle.tankSize);
      
      final db = DatabaseHelper.instance;
      final id = await db.createVehicle(vehicle);
      final newVehicle = vehicle.copyWith(id: id);
      _vehicles.add(newVehicle);
      _vehicles.sort((a, b) => a.name.compareTo(b.name));
      
      if (_currentVehicle.value == null) {
        _currentVehicle.value = newVehicle;
      }
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    }
  }

  Future<bool> updateVehicle(Vehicle vehicle) async {
    try {
      Vehicle.validateName(vehicle.name);
      Vehicle.validateTankSize(vehicle.tankSize);
      
      final db = DatabaseHelper.instance;
      await db.updateVehicle(vehicle);
      
      final index = _vehicles.indexWhere((v) => v.id == vehicle.id);
      if (index != -1) {
        _vehicles[index] = vehicle;
        _vehicles.sort((a, b) => a.name.compareTo(b.name));
      }
      
      if (_currentVehicle.value?.id == vehicle.id) {
        _currentVehicle.value = vehicle;
      }
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    }
  }

  Future<bool> deleteVehicle(int id) async {
    try {
      final db = DatabaseHelper.instance;
      await db.deleteVehicle(id);
      _vehicles.removeWhere((v) => v.id == id);
      
      if (_currentVehicle.value?.id == id) {
        _currentVehicle.value = _vehicles.isNotEmpty ? _vehicles.first : null;
      }
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    }
  }

  void selectVehicle(Vehicle vehicle) {
    _currentVehicle.value = vehicle;
  }

    Future<Map<int, Map<String, dynamic>>> getAllVehicleStats() async {
      final db = DatabaseHelper.instance;
      final stats = <int, Map<String, dynamic>>{};
      final settingsController = Get.find<SettingsController>();
      for (final vehicle in _vehicles) {
        final vid = vehicle.id;
        if (vid == null) continue;
        final records = await db.readAllRecords(vid);
        if (records.isEmpty) {
          stats[vid] = {'odometer': null, 'avgMileage': null, 'recordCount': 0};
          continue;
        }
        
        // Sort by odometer to ensure proper ordering (same as statistics screen)
        final sortedRecords = records..sort((a, b) => a.odometer.compareTo(b.odometer));
        
        // Calculate mileage for records (same as GasRecordController)
        GasRecordList.calculateMileage(sortedRecords, settingsController.unit);
        
        // Calculate average mileage as the average of per-trip mileage values
        // (same as statistics screen)
        double mileageSum = 0;
        int mileageCount = 0;
        for (final r in sortedRecords) {
          if (r.hasCalculation && !r.hidden) {
            final calc = r.calculation;
            if (calc == null) continue;
            final m = calc.getMileage();
            if (m > 0) {
              mileageSum += m;
              mileageCount++;
            }
          }
        }
        final avgMileage = mileageCount > 0 ? mileageSum / mileageCount : null;
        
        stats[vid] = {
          'odometer': sortedRecords.last.odometer,
          'avgMileage': avgMileage,
          'recordCount': records.length,
        };
      }
      return stats;
    }
}
