import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/gas_record.dart';
import '../models/units.dart';
import '../utils/mileage_calculator.dart';

class MileagePlotWidget extends StatelessWidget {
  final List<GasRecord> records;
  final Units unit;

  const MileagePlotWidget({
    super.key,
    required this.records,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final recordsWithMileage = records
        .where((r) => r.hasCalculation && r.calculation!.getMileage() > 0)
        .toList();

    if (recordsWithMileage.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)?.noRecords ?? 'No data available',
        ),
      );
    }

    final spots = <FlSpot>[];
    for (int i = 0; i < recordsWithMileage.length; i++) {
      spots.add(FlSpot(i.toDouble(), recordsWithMileage[i].calculation!.getMileage()));
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)?.mileagePlot ?? 'Mileage Plot',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            MileageCalculator.getUnitLabel(unit),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
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
                        if (index >= 0 && index < recordsWithMileage.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              DateFormat.Md().format(recordsWithMileage[index].date),
                              style: const TextStyle(fontSize: 9),
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
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: Theme.of(context).colorScheme.primary,
                    barWidth: 2,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
