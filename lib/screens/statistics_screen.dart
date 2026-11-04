import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/vehicle.dart';
import '../models/gas_record.dart';
import '../controllers/gas_record_controller.dart';
import '../controllers/settings_controller.dart';
import '../utils/mileage_calculator.dart';
import '../utils/currency_manager.dart';
import '../utils/stats_exporter.dart';
import '../models/units.dart';

class StatisticsScreen extends StatefulWidget {
  final Vehicle vehicle;

  const StatisticsScreen({super.key, required this.vehicle});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late GasRecordController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(GasRecordController());
    final id = widget.vehicle.id;
    if (id != null) _controller.loadRecords(id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = widget.vehicle.id;
    if (id != null) _controller.loadRecords(id);
  }

  Future<void> _shareReport() async {
    final l10n = AppLocalizations.of(context);
    try {
      final html = StatsExporter.generateHtml(
          widget.vehicle, _controller.records, l10n);
      if (html.isEmpty) return;
      final dir = await getTemporaryDirectory();
      final file =
          File('${dir.path}/${widget.vehicle.name}_statistics.html');
      await file.writeAsString(html);
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: l10n.shareStatistics(widget.vehicle.name),
        ),
      );
    } catch (e) {
      Get.snackbar(l10n.error, l10n.shareReportError(e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.statistics),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: l10n.shareReport,
            onPressed: _shareReport,
          ),
        ],
      ),
      body: Obx(() {
        if (_controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.records.isEmpty) {
          return Center(
            child: Text(
              l10n.noRecords,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        }

        return _buildStatistics(l10n);
      }),
    );
  }

  Widget _buildStatistics(AppLocalizations l10n) {
    final records = _controller.records;
    final settingsController = Get.find<SettingsController>();
    final unit = settingsController.unit;
    final currencyCode = settingsController.currency;
    final cm = CurrencyManager.instance;

    final sorted = List<GasRecord>.from(records)
      ..sort((a, b) => a.odometer.compareTo(b.odometer));

    // Build trips exactly like Java MonthlyTrips
    final tripsByMonth = <String, _TripData>{};
    // First record: self-trip (distance=0)
    final firstKey = DateFormat('yyyy-MM').format(sorted.first.date);
    tripsByMonth[firstKey] = _TripData(
      distance: 0,
      fuel: sorted.first.gallons,
      cost: sorted.first.cost,
    );
    for (int i = 1; i < sorted.length; i++) {
      final prev = sorted[i - 1];
      final curr = sorted[i];
      final key = DateFormat('yyyy-MM').format(curr.date);
      final existing = tripsByMonth[key];
      final tripDist = curr.odometer - prev.odometer;
      if (existing != null) {
        existing.distance += tripDist;
        existing.fuel += curr.gallons;
        existing.cost += curr.cost;
      } else {
        tripsByMonth[key] = _TripData(
          distance: tripDist,
          fuel: curr.gallons,
          cost: curr.cost,
        );
      }
    }

    // Group records by month for mileage
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
    for (final trip in tripsByMonth.values) {
      totalTripDistance += trip.distance;
      totalFuel += trip.fuel;
      totalCost += trip.cost;
    }

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

    final numMonths = allMonths.length;
    final avgDistPerMonth =
        numMonths > 0 ? totalTripDistance / numMonths : 0.0;
    final avgFuelPerMonth =
        numMonths > 0 ? totalFuel / numMonths : 0.0;
    final avgCostPerMonth =
        numMonths > 0 ? totalCost / numMonths : 0.0;
    final costPerDist =
        totalTripDistance > 0 ? totalCost / totalTripDistance : 0.0;
    final avgPricePerUnit = totalFuel > 0 ? totalCost / totalFuel : 0.0;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Summary
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.summary,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                _buildStatRow(l10n.recordsLabel, '${sorted.length}'),
                const Divider(),
                _buildSectionHeader(l10n.mileage),
                _buildStatRow(
                  '  ${l10n.avg}',
                  mileageCount > 0
                      ? MileageCalculator.formatMileage(
                          mileageSum / mileageCount, unit, l10n)
                      : '-',
                ),
                _buildStatRow(
                  '  ${l10n.min}',
                  mileageCount > 0
                      ? MileageCalculator.formatMileage(mileageMin, unit, l10n)
                      : '-',
                ),
                _buildStatRow(
                  '  ${l10n.max}',
                  mileageCount > 0
                      ? MileageCalculator.formatMileage(mileageMax, unit, l10n)
                      : '-',
                ),
                const Divider(),
                _buildSectionHeader(l10n.distanceSection),
                _buildStatRow(
                  '  ${l10n.total}',
                  '$totalTripDistance ${MileageCalculator.distanceLabel(unit, l10n)}',
                ),
                _buildStatRow(
                  '  ${l10n.avgMonth}',
                  '${avgDistPerMonth.toStringAsFixed(0)} ${MileageCalculator.distanceLabel(unit, l10n)}',
                ),
                const Divider(),
                _buildSectionHeader(l10n.fuelSection),
                _buildStatRow(
                  '  ${l10n.total}',
                  '${totalFuel.toStringAsFixed(3)} ${MileageCalculator.fuelVolumeLabel(unit, l10n)}',
                ),
                _buildStatRow(
                  '  ${l10n.avgMonth}',
                  '${avgFuelPerMonth.toStringAsFixed(3)} ${MileageCalculator.fuelVolumeLabel(unit, l10n)}',
                ),
                const Divider(),
                _buildSectionHeader(l10n.costSection),
                _buildStatRow(
                    '  ${l10n.total}', cm.formatCurrency(totalCost, currencyCode)),
                _buildStatRow(
                    '  ${l10n.avgMonth}',
                    cm.formatCurrency(avgCostPerMonth, currencyCode)),
                if (totalTripDistance > 0)
                  _buildStatRow(
                    '  ${l10n.perDistance(MileageCalculator.distanceLabel(unit, l10n))}',
                    '${cm.formatCurrency(costPerDist, currencyCode)}/${MileageCalculator.distanceLabel(unit, l10n)}',
                  ),
                const Divider(),
                _buildSectionHeader(l10n.priceSection),
                _buildStatRow(
                  '  ${l10n.avgPerVolume(MileageCalculator.fuelVolumeLabel(unit, l10n))}',
                  cm.formatCurrency(avgPricePerUnit, currencyCode),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Monthly Breakdown (newest first)
        Text(
          l10n.monthlyBreakdown,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ...allMonths.reversed.map((month) {
          final trip = tripsByMonth[month] ??
              _TripData(distance: 0, fuel: 0, cost: 0);
          final monthRecs = recordsByMonth[month] ?? [];
          return _buildMonthlyCard(
              context, month, trip, monthRecs, unit, currencyCode, l10n);
        }),
      ],
    );
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

  Widget _buildSectionHeader(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
          label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13)),
          Text(value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildMonthlyCard(
    BuildContext context,
    String month,
    _TripData trip,
    List<GasRecord> monthRecords,
    Units unit,
    String currencyCode,
    AppLocalizations l10n,
  ) {
    final cm = CurrencyManager.instance;
    final mDistance = trip.distance;
    final mFuel = trip.fuel;
    final mCost = trip.cost;
    final mCostPerDist = mDistance > 0 ? mCost / mDistance : 0.0;
    final mAvgPrice = mFuel > 0 ? mCost / mFuel : 0.0;

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

    final label = DateFormat('MMM yyyy')
        .format(DateFormat('yyyy-MM').parse(month))
        .toUpperCase();

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        title: Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          l10n.recordsSummary(
              mDistance.toString(),
              MileageCalculator.distanceLabel(unit, l10n),
              mFuel.toStringAsFixed(3),
              MileageCalculator.fuelVolumeLabel(unit, l10n))),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Column(
              children: [
                if (mileageCount > 0) ...[
                  _buildMonthlySubHeader(l10n.mileage),
                  _buildStatRow(
                      '  ${l10n.avg}',
                      MileageCalculator.formatMileage(
                          mileageSum / mileageCount, unit, l10n)),
                  _buildStatRow('  ${l10n.min}',
                      MileageCalculator.formatMileage(mileageMin, unit, l10n)),
                  _buildStatRow('  ${l10n.max}',
                      MileageCalculator.formatMileage(mileageMax, unit, l10n)),
                  const Divider(height: 16),
                ],
                _buildMonthlySubHeader(l10n.distanceSection),
                _buildStatRow('  ${l10n.total}',
                    '$mDistance ${MileageCalculator.distanceLabel(unit, l10n)}'),
                const Divider(height: 16),
                _buildMonthlySubHeader(l10n.fuelSection),
                _buildStatRow(
                    '  ${l10n.total}',
                    '${mFuel.toStringAsFixed(3)} ${MileageCalculator.fuelVolumeLabel(unit, l10n)}'),
                const Divider(height: 16),
                _buildMonthlySubHeader(l10n.costSection),
                _buildStatRow(
                    '  ${l10n.total}', cm.formatCurrency(mCost, currencyCode)),
                if (mDistance > 0)
                  _buildStatRow(
                    '  ${l10n.perDistance(MileageCalculator.distanceLabel(unit, l10n))}',
                    '${cm.formatCurrency(mCostPerDist, currencyCode)}/${MileageCalculator.distanceLabel(unit, l10n)}',
                  ),
                const Divider(height: 16),
                _buildMonthlySubHeader(l10n.priceSection),
                _buildStatRow(
                  '  ${l10n.avgPerVolume(MileageCalculator.fuelVolumeLabel(unit, l10n))}',
                  mFuel > 0
                      ? cm.formatCurrency(mAvgPrice, currencyCode)
                      : '-',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlySubHeader(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
          label,
          style:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
    );
  }
}

class _TripData {
  int distance;
  double fuel;
  double cost;

  _TripData({required this.distance, required this.fuel, required this.cost});
}
