import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/vehicle.dart';
import '../models/gas_record.dart';
import '../controllers/gas_record_controller.dart';
import '../controllers/settings_controller.dart';
import '../constants/app_icons.dart';
import 'gas_record_screen.dart';

class GasLogListScreen extends StatefulWidget {
  final Vehicle vehicle;

  const GasLogListScreen({super.key, required this.vehicle});

  @override
  State<GasLogListScreen> createState() => _GasLogListScreenState();
}

class _GasLogListScreenState extends State<GasLogListScreen> {
  late GasRecordController _controller;

  int? get _vehicleId => widget.vehicle.id;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(GasRecordController());
    final id = _vehicleId;
    if (id != null) _controller.loadRecords(id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = _vehicleId;
    if (id != null) _controller.loadRecords(id);
  }

  Future<void> _refreshRecords() async {
    final id = _vehicleId;
    if (id != null) _controller.loadRecords(id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.fuelRecords),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result =
                  await Get.to(() => GasRecordScreen(vehicle: widget.vehicle));
              if (result == true) {
                _refreshRecords();
              }
            },
          ),
        ],
      ),
      body: Obx(() {
        if (_controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.records.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppIcons.getGasCanIcon(size: 80),
                const SizedBox(height: 24),
                Text(
                  l10n.noRecords,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () async {
                    final result =
                        await Get.to(() => GasRecordScreen(vehicle: widget.vehicle));
                    if (result == true) {
                      _refreshRecords();
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: Text(l10n.addRecord),
                ),
              ],
            ),
          );
        }

        return _buildRecordList(context, l10n);
      }),
    );
  }

  Widget _buildRecordList(BuildContext context, AppLocalizations l10n) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _controller.records.length,
      itemBuilder: (context, index) {
        final record = _controller.records[index];
        return _buildRecordCard(context, record, l10n);
      },
    );
  }

  Widget _buildRecordCard(
      BuildContext context,
      GasRecord record,
      AppLocalizations l10n) {
    final settingsController = Get.find<SettingsController>();
    final unitLabel = settingsController.unit.liquidVolumeLabel;
    final mileageLabel = settingsController.unit.mileageLabel;
    final distanceLabel = settingsController.unit.distanceLabel;
    final calc = record.hasCalculation ? record.calculation : null;
    final mileageStr =
        calc != null ? '${calc.getMileageString()} $mileageLabel' : '';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: record.fullTank
            ? AppIcons.getGasCanIcon(size: 32)
            : Icon(Icons.local_gas_station_outlined, size: 32),
        title: Text(DateFormat.yMMMd().format(record.date)),
        subtitle: Text(
          l10n.recordSummary(
            record.odometer.toString(),
            distanceLabel,
            record.gallons.toStringAsFixed(3),
            unitLabel,
            mileageStr.isNotEmpty ? ' | $mileageStr' : '',
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PopupMenuButton<String>(
              onSelected: (value) async {
                switch (value) {
                  case 'edit':
                    final result = await Get.to(
                        () => GasRecordScreen(vehicle: widget.vehicle, record: record));
                    if (result == true) {
                      _refreshRecords();
                    }
                    break;
                  case 'delete':
                    _showDeleteDialog(record, l10n);
                    break;
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Text(l10n.edit),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text(l10n.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(GasRecord record, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteRecord),
        content: Text(l10n.confirmDeleteRecord),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              final recordId = record.id;
              final vehicleId = record.vehicleId;
              if (recordId != null && vehicleId != null) {
                _controller.deleteRecord(recordId, vehicleId);
              }
              Navigator.pop(context);
            },
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}
