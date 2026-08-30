import '../models/gas_record.dart';
import '../models/mileage_calculation.dart';
import '../models/units.dart';

class GasRecordList {
  static void calculateMileage(List<GasRecord> records, Units units) {
    if (records.isEmpty) return;

    // Clear all calculations
    for (final record in records) {
      record.setCalculation(null);
    }

    // Find first full tank
    MileageCalculation? calc;
    int startIdx = -1;
    for (int i = 0; i < records.length; i++) {
      if (records[i].fullTank) {
        calc = MileageCalculation.fromRecord(records[i], units);
        startIdx = i;
        break;
      }
    }
    if (calc == null || startIdx < 0) return;

    // Calculate mileage between full tanks (matches Java exactly)
    for (int i = startIdx + 1; i < records.length; i++) {
      final record = records[i];
      calc!.add(record);
      if (record.fullTank) {
        record.setCalculation(calc);
        calc = MileageCalculation.fromRecord(record, units);
      } else {
        record.setCalculation(null);
      }
    }
  }

  static List<GasRecord> filterByDateRange(
    List<GasRecord> records,
    DateTime startDate,
    DateTime endDate,
  ) {
    return records.where((record) {
      return record.date.isAfter(startDate) && record.date.isBefore(endDate);
    }).toList();
  }

  static double calculateTotalCost(List<GasRecord> records) {
    return records.fold(0, (sum, record) => sum + record.cost);
  }

  static double calculateTotalGallons(List<GasRecord> records) {
    return records.fold(0, (sum, record) => sum + record.gallons);
  }
}
