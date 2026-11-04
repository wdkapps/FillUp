import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../models/gas_record.dart';
import '../constants/app_constants.dart';

class CsvHandler {
  static final _csvDateFmt = DateFormat('MM/dd/yyyy HH:mm');

  static Future<bool> exportToCsv(List<GasRecord> records, String vehicleName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final safeName = vehicleName.replaceAll(RegExp(r'[^\w\s-]'), '');
      final filePath = '${directory.path}/$safeName.csv';

      final buffer = StringBuffer();
      buffer.writeln('#,version,${AppConstants.dbVersion}');

      for (final record in records) {
        buffer.writeln(record.toCSV());
      }

      await File(filePath).writeAsString(buffer.toString());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<GasRecord>> importFromCsv(String filePath) async {
    try {
      final file = File(filePath);
      final csvString = await file.readAsString();
      final lines = csvString.split('\n').where((l) => l.trim().isNotEmpty).toList();

      if (lines.isEmpty) return [];

      final records = <GasRecord>[];
      int startIndex = 0;

      final firstLine = lines[0].trim();
      if (firstLine.startsWith('#')) {
        startIndex = 1;
      }

      for (int i = startIndex; i < lines.length; i++) {
        final line = lines[i].trim();
        if (line.isEmpty || line.startsWith('#')) continue;

        try {
          final record = _parseCsvLine(line);
          if (record != null) {
            records.add(record);
          }
        } catch (e) {
          continue;
        }
      }

      return records;
    } catch (e) {
      return [];
    }
  }

  static GasRecord? _parseCsvLine(String line) {
    final values = line.split(',');
    if (values.length < 5) return null;

    final date = _parseCsvDateTime(values[0].trim());
    final odometer = int.tryParse(values[1].trim());
    final gallons = double.tryParse(values[2].trim());
    final fullTank = _parseBool(values[3].trim());
    final hidden = _parseBool(values[4].trim());

    if (odometer == null || gallons == null) return null;

    double cost = 0;
    String notes = '';

    if (values.length >= 7) {
      cost = double.tryParse(values[5].trim()) ?? 0;
      notes = values[6].trim();
    } else if (values.length >= 6) {
      cost = double.tryParse(values[5].trim()) ?? 0;
    }

    return GasRecord(
      date: date,
      odometer: odometer,
      gallons: gallons,
      fullTank: fullTank,
      hidden: hidden,
      cost: cost,
      notes: notes,
    );
  }

  static DateTime _parseCsvDateTime(String dateStr) {
    try {
      return _csvDateFmt.parse(dateStr);
    } catch (e) {
      try {
        return DateTime.parse(dateStr);
      } catch (e2) {
        try {
          final parts = dateStr.split(RegExp(r'[/ :\-]'));
          if (parts.length >= 3) {
            return DateTime(
              int.parse(parts[2]),
              int.parse(parts[0]),
              int.parse(parts[1]),
              parts.length > 3 ? int.parse(parts[3]) : 0,
              parts.length > 4 ? int.parse(parts[4]) : 0,
            );
          }
        } catch (e3) {
          // fall through
        }
      }
    }
    return DateTime.now();
  }

  static bool _parseBool(String value) {
    final lower = value.toLowerCase();
    return lower == 'true' || lower == '1' || lower == 'yes';
  }

  static Future<String> getExportPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/${AppConstants.dbName.replaceAll('.db', '')}_export.csv';
  }
}
