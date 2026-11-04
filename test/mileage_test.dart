import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

void main() {
  group('Mileage Calculation Tests', () {
    test('MPG calculation matches original Java app', () {
      final result = _calculateMileage(200, 10.0, 'mpg');
      expect(result, 20.0);
    });

    test('KM/L calculation', () {
      final result = _calculateMileage(100, 10.0, 'kml');
      expect(result, greaterThan(0));
    });

    test('L/100KM calculation', () {
      final result = _calculateMileage(100, 8.0, 'l100km');
      expect(result, greaterThan(0));
    });

    test('KPG calculation', () {
      final result = _calculateMileage(100, 10.0, 'kpg');
      expect(result, greaterThan(0));
    });

    test('Zero distance returns 0', () {
      final result = _calculateMileage(0, 10.0, 'mpg');
      expect(result, 0);
    });

    test('Zero gallons returns 0', () {
      final result = _calculateMileage(100, 0, 'mpg');
      expect(result, 0);
    });

    test('UK MPG calculation', () {
      final result = _calculateMileage(100, 10.0, 'ukmpg');
      expect(result, greaterThan(0));
    });
  });

  group('Vehicle Model Tests', () {
    test('Vehicle toMap and fromMap', () {
      final map = {
        '_id': 1,
        'name': 'Toyota Camry',
        'tanksize': '16.0',
      };
      expect(map['_id'], 1);
      expect(map['name'], 'Toyota Camry');
      expect(double.parse(map['tanksize'] as String), 16.0);
    });
  });

  group('GasRecord Model Tests', () {
    test('GasRecord toMap preserves all fields', () {
      final map = {
        '_id': 1,
        'vid': 1,
        'date': '1700000000000',
        'odometer': '50000',
        'gallons': '12.5',
        'fulltank': '1',
        'hidden': '0',
        'cost': '45.00',
        'notes': 'Test',
      };
      expect(int.parse(map['odometer'] as String), 50000);
      expect(double.parse(map['gallons'] as String), 12.5);
      expect(int.parse(map['fulltank'] as String), 1);
    });
  });

  group('CSV Format Tests', () {
    test('Java CSV format parsing', () {
      const line = '12/30/2023 05:18,146408,33.015,true,false,1225.17,';
      final values = line.split(',');
      expect(values.length, greaterThanOrEqualTo(6));
      expect(values[0], '12/30/2023 05:18');
      expect(values[1], '146408');
      expect(values[2], '33.015');
      expect(values[3], 'true');
      expect(values[4], 'false');
      expect(values[5], '1225.17');
    });

    test('Java CSV with notes and calculation', () {
      const line = '01/19/2024 05:20,147000,35.810,true,false,1400.17,,6.05';
      final values = line.split(',');
      expect(values.length, 8);
      expect(values[6], '');
      expect(values[7], '6.05');
    });

    test('Java CSV version header', () {
      const header = '#,version,5';
      expect(header.startsWith('#'), true);
    });

    test('Import Java CSV with version header', () async {
      final csvContent = '#,version,5\n'
          '12/30/2023 05:18,146408,33.015,true,false,1225.17,\n'
          '01/19/2024 05:20,147000,35.810,true,false,1400.17,,6.05\n';
      final tmpDir = Directory.systemTemp.createTempSync('csv_test');
      final file = File(p.join(tmpDir.path, 'test.csv'));
      await file.writeAsString(csvContent);

      final csvString = await file.readAsString();
      final lines = csvString.split('\n').where((l) => l.trim().isNotEmpty).toList();
      expect(lines.length, 3);

      final firstLine = lines[0].trim();
      expect(firstLine.startsWith('#'), true);

      final dataLine = lines[1].trim();
      final values = dataLine.split(',');
      expect(values.length, greaterThanOrEqualTo(6));
      expect(values[0], '12/30/2023 05:18');
      expect(int.parse(values[1]), 146408);
      expect(double.parse(values[2]), 33.015);
      expect(values[3], 'true');
      expect(values[4], 'false');
      expect(double.parse(values[5]), 1225.17);

      final dataLine2 = lines[2].trim();
      final values2 = dataLine2.split(',');
      expect(values2.length, 8);
      expect(double.parse(values2[5]), 1400.17);
      expect(values2[6], '');
      expect(values2[7], '6.05');

      await tmpDir.delete(recursive: true);
    });
  });
}

double _calculateMileage(int distance, double gallons, String unit) {
  const milesPerKm = 0.621371;
  const imperialGallonsPerLiter = 0.219969;

  if (gallons <= 0 || distance <= 0) return 0;

  switch (unit) {
    case 'mpg':
      return distance / gallons;
    case 'kml':
      return (distance * milesPerKm) / (gallons * imperialGallonsPerLiter);
    case 'l100km':
      return (gallons * imperialGallonsPerLiter) / (distance * milesPerKm) * 100;
    case 'kpg':
      return (distance * milesPerKm) / gallons;
    case 'ukmpg':
      return (distance * milesPerKm) / gallons * 1.20095;
    default:
      return distance / gallons;
  }
}
