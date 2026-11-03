import 'package:intl/intl.dart';
import '../models/gas_record.dart';
import '../models/vehicle.dart';
import '../models/units.dart';
import '../controllers/settings_controller.dart';
import '../utils/mileage_calculator.dart';
import '../utils/currency_manager.dart';
import 'package:get/get.dart';
import '../l10n/generated/app_localizations.dart';

class _TripRecord {
  int distance;
  double gallons;
  double cost;

  _TripRecord(
      {required this.distance, required this.gallons, required this.cost});
}

class StatsExporter {
  static String generateHtml(
      Vehicle vehicle,
      List<GasRecord> records,
      AppLocalizations l10n) {
    final sc = Get.find<SettingsController>();
    final unit = sc.unit;
    final currencyCode = sc.currency;
    final cm = CurrencyManager.instance;

    final sorted = List<GasRecord>.from(records)
      ..sort((a, b) => a.odometer.compareTo(b.odometer));

    if (sorted.isEmpty) return '';

    // Build trips exactly like Java MonthlyTrips
    final tripsByMonth = <String, List<_TripRecord>>{};

    // First record: self-trip (distance=0)
    final firstKey = DateFormat('yyyy-MM').format(sorted.first.date);
    tripsByMonth.putIfAbsent(firstKey, () => []).add(
      _TripRecord(
          distance: 0,
          gallons: sorted.first.gallons,
          cost: sorted.first.cost),
    );

    // Subsequent records: trip from previous record
    for (int i = 1; i < sorted.length; i++) {
      final prev = sorted[i - 1];
      final curr = sorted[i];
      final key = DateFormat('yyyy-MM').format(curr.date);
      tripsByMonth.putIfAbsent(key, () => []).add(
        _TripRecord(
          distance: curr.odometer - prev.odometer,
          gallons: curr.gallons,
          cost: curr.cost,
        ),
      );
    }

    // Group records by month for mileage calculation
    final recordsByMonth = <String, List<GasRecord>>{};
    for (final r in sorted) {
      final key = DateFormat('yyyy-MM').format(r.date);
      recordsByMonth.putIfAbsent(key, () => []).add(r);
    }

    // Generate ALL months between first and last record
    final firstDate = sorted.first.date;
    final lastDate = sorted.last.date;
    final allMonths = _generateAllMonths(firstDate, lastDate);

    // Summary totals from trips
    int totalTripDistance = 0;
    double totalFuel = 0;
    double totalCost = 0;
    for (final trips in tripsByMonth.values) {
      for (final t in trips) {
        totalTripDistance += t.distance;
        totalFuel += t.gallons;
        totalCost += t.cost;
      }
    }

    final sb = StringBuffer();
    sb.writeln(
        '<?xml version="1.0" encoding="utf-8"?>');
    sb.writeln(
        '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML Basic 1.1//EN" "http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd">');
    sb.writeln('<html>');
    sb.writeln('<head>');
    sb.writeln('<title>${l10n.statistics}</title>');
    sb.writeln(
        '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />');
    sb.writeln(
        '<meta name="generator" content="FillUp/Flutter" />');
    sb.writeln(_css());
    sb.writeln('</head>');
    sb.writeln('<body>');

    // Summary table
    if (allMonths.length > 1) {
      sb.writeln('<div>');
      sb.writeln(_summaryTable(sorted, allMonths.length, totalTripDistance,
          totalFuel, totalCost, unit, currencyCode, cm, l10n));
      sb.writeln('</div>');
      sb.writeln('<p/>');
    }

    // Monthly tables (newest first)
    for (int i = allMonths.length - 1; i >= 0; i--) {
      final monthKey = allMonths[i];
      final trips = tripsByMonth[monthKey] ?? [];
      final monthRecords = recordsByMonth[monthKey] ?? [];
      final label = _monthLabel(monthKey);
      sb.writeln('<div>');
      sb.writeln(
          _monthTable(label, trips, monthRecords, unit, currencyCode, cm, l10n));
      sb.writeln('</div>');
      sb.writeln('<p/>');
    }

    sb.writeln('</body>');
    sb.writeln('</html>');
    return sb.toString();
  }

  static List<String> _generateAllMonths(DateTime first, DateTime last) {
    final months = <String>[];
    var current = DateTime(first.year, first.month);
    final end = DateTime(last.year, last.month);
    while (!current.isAfter(end)) {
      months.add(DateFormat('yyyy-MM').format(current));
      current = DateTime(current.year, current.month + 1);
    }
    return months;
  }

  static String _monthLabel(String yyyyMM) {
    final dt = DateFormat('yyyy-MM').parse(yyyyMM);
    return DateFormat('MMM yyyy').format(dt).toUpperCase();
  }

  static String _summaryTable(
    List<GasRecord> sorted,
    int numMonths,
    int totalDistance,
    double totalFuel,
    double totalCost,
    Units unit,
    String currencyCode,
    CurrencyManager cm,
    AppLocalizations l10n,
  ) {
    final firstDate = sorted.first.date;
    final lastDate = sorted.last.date;
    final firstMonth =
        DateFormat('MMM yyyy').format(firstDate).toUpperCase();
    final lastMonth = DateFormat('MMM yyyy').format(lastDate).toUpperCase();

    // Mileage stats — matches Java StatisticsMonthTable: includes zero-mileage
    // values in min/sum (no m > 0 guard).
    double mileageSum = 0;
    double mileageMin = 0;
    double mileageMax = 0;
    int mileageCount = 0;
    for (final r in sorted) {
      if (r.hasCalculation && !r.hidden) {
        final calc = r.calculation;
        if (calc == null) continue;
        final m = calc.getMileage();
        mileageSum += m;
        if (mileageCount == 0 || m < mileageMin) mileageMin = m;
        if (m > mileageMax) mileageMax = m;
        mileageCount++;
      }
    }

    final avgDistPerMonth =
        numMonths > 0 ? totalDistance / numMonths : 0.0;
    final avgFuelPerMonth = numMonths > 0 ? totalFuel / numMonths : 0.0;
    final avgCostPerMonth = numMonths > 0 ? totalCost / numMonths : 0.0;
    final costPerDist =
        totalDistance > 0 ? totalCost / totalDistance : 0.0;
    final avgPrice = totalFuel > 0 ? totalCost / totalFuel : 0.0;

    final distLabel = unit.distanceLabel.toLowerCase();
    final fuelLabel = unit.liquidVolumeLabel.toLowerCase();

    final sb = StringBuffer();
    sb.writeln('<table class="summary">');
    sb.writeln('<tr class="summary">');
    sb.writeln(
        '  <th class="summary" colspan="2">${l10n.summary}: ${l10n.allData}</th>');
    sb.writeln('</tr>');
    sb.writeln('<tr class="summary">');
    sb.writeln(
        '  <td class="summary">${l10n.dateRange}</td>');
    sb.writeln(
        '  <td class="summary"><span style="white-space: nowrap">$firstMonth</span> &mdash; <span style="white-space: nowrap">$lastMonth</span> <br/>($numMonths ${l10n.months})</td>');
    sb.writeln('</tr>');

    int row = 0;
    if (mileageCount > 0) {
      for (final entry in [
        ('Fuel Economy (avg)', _fmtMileage(mileageSum / mileageCount, unit)),
        ('Fuel Economy (min)', _fmtMileage(mileageMin, unit)),
        ('Fuel Economy (max)', _fmtMileage(mileageMax, unit)),
      ]) {
        sb.writeln(
            '<tr class="summary${row.isOdd ? ' odd' : ''}">');
        sb.writeln(
            '  <td class="summary">${l10n.fuelEconomy(entry.$1)}</td>');
        sb.writeln('  <td class="summary">${entry.$2}</td>');
        sb.writeln('</tr>');
        row++;
      }
    } else {
      for (final lbl in [l10n.fuelEconomy('avg'),
          l10n.fuelEconomy('min'),
          l10n.fuelEconomy('max')]) {
        sb.writeln(
            '<tr class="summary${row.isOdd ? ' odd' : ''}">');
        sb.writeln('  <td class="summary">$lbl</td>');
        sb.writeln('  <td class="summary">-</td>');
        sb.writeln('</tr>');
        row++;
      }
    }

    sb.writeln(
        '<tr class="summary${row.isOdd ? ' odd' : ''}">');
    sb.writeln(
        '  <td class="summary">${l10n.distanceDriven}</td>');
    sb.writeln(
        '  <td class="summary">$totalDistance $distLabel <br/>(${avgDistPerMonth.toStringAsFixed(0)} ${l10n.perMonth})</td>');
    sb.writeln('</tr>');
    row++;

    sb.writeln(
        '<tr class="summary${row.isOdd ? ' odd' : ''}">');
    sb.writeln('  <td class="summary">${l10n.fuelPurchased}</td>');
    sb.writeln(
        '  <td class="summary">${totalFuel.toStringAsFixed(3)} $fuelLabel <br/>(${avgFuelPerMonth.toStringAsFixed(3)} ${l10n.perMonth})</td>');
    sb.writeln('</tr>');
    row++;

    sb.writeln(
        '<tr class="summary${row.isOdd ? ' odd' : ''}">');
    sb.writeln('  <td class="summary">${l10n.fuelCost}</td>');
    final costPerDistStr = totalDistance > 0
        ? ' <br/>(${cm.formatCurrency(costPerDist, currencyCode)} ${l10n.per(distLabel)})'
        : '';
    sb.writeln(
        '  <td class="summary">${cm.formatCurrency(totalCost, currencyCode)} <br/>(${cm.formatCurrency(avgCostPerMonth, currencyCode)} ${l10n.perMonth})$costPerDistStr</td>');
    sb.writeln('</tr>');
    row++;

    sb.writeln(
        '<tr class="summary${row.isOdd ? ' odd' : ''}">');
    sb.writeln('  <td class="summary">${l10n.fuelPrice}</td>');
    if (totalFuel > 0) {
      sb.writeln(
          '  <td class="summary">${cm.formatCurrency(avgPrice, currencyCode)} ${l10n.per(fuelLabel)}</td>');
    } else {
      sb.writeln('  <td class="summary">-</td>');
    }
    sb.writeln('</tr>');

    sb.writeln('</table>');
    return sb.toString();
  }

  static String _monthTable(
    String label,
    List<_TripRecord> trips,
    List<GasRecord> monthRecords,
    Units unit,
    String currencyCode,
    CurrencyManager cm,
    AppLocalizations l10n,
  ) {
    int mDistance = 0;
    double mFuel = 0;
    double mCost = 0;
    for (final t in trips) {
      mDistance += t.distance;
      mFuel += t.gallons;
      mCost += t.cost;
    }

    // Mileage from records with calculations (matches Java StatisticsMonthTable:
    // includes zero-mileage values in min/sum — no m > 0 guard).
    double mileageSum = 0;
    double mileageMin = 0;
    double mileageMax = 0;
    int mileageCount = 0;
    for (final r in monthRecords) {
      if (r.hasCalculation && !r.hidden) {
        final calc = r.calculation;
        if (calc == null) continue;
        final m = calc.getMileage();
        mileageSum += m;
        if (mileageCount == 0 || m < mileageMin) mileageMin = m;
        if (m > mileageMax) mileageMax = m;
        mileageCount++;
      }
    }

    final mCostPerDist = mDistance > 0 ? mCost / mDistance : 0.0;
    final mAvgPrice = mFuel > 0 ? mCost / mFuel : 0.0;

    final distLabel = unit.distanceLabel.toLowerCase();
    final fuelLabel = unit.liquidVolumeLabel.toLowerCase();

    final sb = StringBuffer();
    sb.writeln('<table class="month">');
    sb.writeln('<tr class="month">');
    sb.writeln('  <th class="month" colspan="2">$label</th>');
    sb.writeln('</tr>');

    int row = 0;
    if (mileageCount > 0) {
      for (final entry in [
        ('Fuel Economy (avg)', _fmtMileage(mileageSum / mileageCount, unit)),
        ('Fuel Economy (min)', _fmtMileage(mileageMin, unit)),
        ('Fuel Economy (max)', _fmtMileage(mileageMax, unit)),
      ]) {
        sb.writeln('<tr class="month${row.isOdd ? ' odd' : ''}">');
        sb.writeln(
            '  <td class="month">${l10n.fuelEconomy(entry.$1)}</td>');
        sb.writeln('  <td class="month">${entry.$2}</td>');
        sb.writeln('</tr>');
        row++;
      }
    } else {
      for (final lbl in [
        l10n.fuelEconomy('avg'),
        l10n.fuelEconomy('min'),
        l10n.fuelEconomy('max')
      ]) {
        sb.writeln('<tr class="month${row.isOdd ? ' odd' : ''}">');
        sb.writeln('  <td class="month">$lbl</td>');
        sb.writeln('  <td class="month">-</td>');
        sb.writeln('</tr>');
        row++;
      }
    }

    sb.writeln('<tr class="month${row.isOdd ? ' odd' : ''}">');
    sb.writeln('  <td class="month">${l10n.distanceDriven}</td>');
    sb.writeln('  <td class="month">$mDistance $distLabel</td>');
    sb.writeln('</tr>');
    row++;

    sb.writeln('<tr class="month${row.isOdd ? ' odd' : ''}">');
    sb.writeln('  <td class="month">${l10n.fuelPurchased}</td>');
    sb.writeln(
        '  <td class="month">${mFuel.toStringAsFixed(3)} $fuelLabel</td>');
    sb.writeln('</tr>');
    row++;

    sb.writeln('<tr class="month${row.isOdd ? ' odd' : ''}">');
    sb.writeln('  <td class="month">${l10n.fuelCost}</td>');
    final costPerDistStr = mDistance > 0
        ? ' <br/>(${cm.formatCurrency(mCostPerDist, currencyCode)} ${l10n.per(distLabel)})'
        : ' <br/>(- ${l10n.per(distLabel)})';
    sb.writeln(
        '  <td class="month">${cm.formatCurrency(mCost, currencyCode)}$costPerDistStr</td>');
    sb.writeln('</tr>');
    row++;

    sb.writeln('<tr class="month${row.isOdd ? ' odd' : ''}">');
    sb.writeln('  <td class="month">${l10n.fuelPrice}</td>');
    if (mFuel > 0) {
      sb.writeln(
          '  <td class="month">${cm.formatCurrency(mAvgPrice, currencyCode)} ${l10n.per(fuelLabel)}</td>');
    } else {
      sb.writeln('  <td class="month">-</td>');
    }
    sb.writeln('</tr>');

    sb.writeln('</table>');
    return sb.toString();
  }

  static String _fmtMileage(double value, Units unit) {
    return '${value.toStringAsFixed(2)} ${MileageCalculator.getMileageLabel(unit)}';
  }

  static String _css() {
    return '''<style type="text/css">
 body {
     background-color: #000000;
 }

 table {
     border-collapse:collapse; 
     margin-left:10px; 
     margin-right:10px;
     font-size:14px;    
 }

 tr.odd {
     background-color:#f6f4f0;
 }

 tr {
     background-color:#ffffff;
 }

 th {
     color:#ffffff;
     background-color:#555555;
     border:1px solid #555555;
     padding:5px;
     vertical-align:top;
     text-align:left;
 }

 td {
     border:1px solid #d4d4d4;
     padding:5px;
     padding-top:7px;
     padding-bottom:7px;
     vertical-align:top;
     text-align:left;
 }

 table.month {
     width:95%;
 }

 td.month {
     width:50%;
 }

 table.summary {
     width:95%;
 }

 td.summary {
     width:50%;
 }

 th.summary {
     color:#7bd610;
 }

 </style>''';
  }
}
