import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/gas_record.dart';
import '../controllers/settings_controller.dart';
import '../utils/mileage_calculator.dart';

class GallonsPlotWidget extends StatelessWidget {
  final List<GasRecord> records;

  const GallonsPlotWidget({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (records.isEmpty) {
      return Center(
        child: Text(l10n.noRecords),
      );
    }

    final sorted = List<GasRecord>.from(records)
      ..sort((a, b) => a.odometer.compareTo(b.odometer));

    final bars = <BarChartGroupData>[];
    for (int i = 0; i < sorted.length; i++) {
      bars.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: sorted[i].gallons,
            color: Theme.of(context).colorScheme.secondary,
            width: sorted.length > 20 ? 4 : 8,
          ),
        ],
      ));
    }

    final settingsController = Get.find<SettingsController>();
    final unitLabel = MileageCalculator.fuelVolumeLabel(settingsController.unit, l10n);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            '$unitLabel ${l10n.gallonsPlot}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: sorted.map((r) => r.gallons).reduce((a, b) => a > b ? a : b) * 1.2,
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < sorted.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              DateFormat.Md().format(sorted[index].date),
                              style: const TextStyle(fontSize: 8),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: const FlGridData(show: true),
                borderData: FlBorderData(show: true),
                barGroups: bars,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
