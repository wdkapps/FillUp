import 'package:get/get.dart';
import '../models/gas_record.dart';
import '../models/units.dart';
import '../utils/gas_record_list.dart';
import '../database/database_helper.dart';
import 'settings_controller.dart';

class GasRecordController extends GetxController {
  final _records = <GasRecord>[].obs;
  final _isLoading = false.obs;

  List<GasRecord> get records => _records;
  bool get isLoading => _isLoading.value;
  Units get selectedUnit => Get.find<SettingsController>().unit;

  Future<void> loadRecords(int vehicleId) async {
    _isLoading.value = true;
    try {
      final db = DatabaseHelper.instance;
      final records = await db.readAllRecords(vehicleId);
      GasRecordList.calculateMileage(records, selectedUnit);
      _records.value = records;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<bool> addRecord(GasRecord record) async {
    try {
      final db = DatabaseHelper.instance;
      final id = await db.createRecord(record);
      final newRecord = record.copyWith(id: id);
      _records.add(newRecord);
      _records.sort((a, b) => a.odometer.compareTo(b.odometer));
      
      if (record.vehicleId != null) {
        await loadRecords(record.vehicleId!);
      }
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    }
  }

  Future<bool> updateRecord(GasRecord record) async {
    try {
      final db = DatabaseHelper.instance;
      await db.updateRecord(record);
      
      final index = _records.indexWhere((r) => r.id == record.id);
      if (index != -1) {
        _records[index] = record;
      }
      
      if (record.vehicleId != null) {
        await loadRecords(record.vehicleId!);
      }
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    }
  }

  Future<bool> deleteRecord(int id, int vehicleId) async {
    try {
      final db = DatabaseHelper.instance;
      await db.deleteRecord(id);
      _records.removeWhere((r) => r.id == id);
      
      await loadRecords(vehicleId);
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    }
  }

  double get totalCost {
    return GasRecordList.calculateTotalCost(_records);
  }

  double get totalGallons {
    return GasRecordList.calculateTotalGallons(_records);
  }
}
