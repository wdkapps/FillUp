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

  @override
  void initState() {
    super.initState();
    _controller = Get.put(GasRecordController());
    _controller.loadRecords(widget.vehicle.id!);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.loadRecords(widget.vehicle.id!);
  }

  Future<void> _refreshRecords() async {
    _controller.loadRecords(widget.vehicle.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.fuelRecords ?? 'Fuel Records'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Get.to(() => GasRecordScreen(vehicle: widget.vehicle));
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
                  AppLocalizations.of(context)?.noRecords ?? 'No fuel records yet',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () async {
                    final result = await Get.to(() => GasRecordScreen(vehicle: widget.vehicle));
                    if (result == true) {
                      _refreshRecords();
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: Text(AppLocalizations.of(context)?.addRecord ?? 'Add Record'),
                ),
              ],
            ),
          );
        }

        return _buildRecordList();
      }),
    );
  }

  Widget _buildRecordList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _controller.records.length,
      itemBuilder: (context, index) {
        final record = _controller.records[index];
        return _buildRecordCard(record);
      },
    );
  }

  Widget _buildRecordCard(GasRecord record) {
    final settingsController = Get.find<SettingsController>();
    final unitLabel = settingsController.unit.liquidVolumeLabel;
    final mileageLabel = settingsController.unit.mileageLabel;
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: record.fullTank
            ? AppIcons.getGasCanIcon(size: 32)
            : Icon(Icons.local_gas_station_outlined, size: 32),
        title: Text(DateFormat.yMMMd().format(record.date)),
        subtitle: Text(
          '${record.odometer} ${settingsController.unit.distanceLabel} | ${record.gallons.toStringAsFixed(3)} $unitLabel',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (record.hasCalculation)
              Chip(
                label: Text('${record.calculation?.getMileageString()} $mileageLabel'),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
            PopupMenuButton<String>(
              onSelected: (value) async {
                switch (value) {
                  case 'edit':
                    final result = await Get.to(() => GasRecordScreen(
                          vehicle: widget.vehicle,
                          record: record,
                        ));
                    if (result == true) {
                      _refreshRecords();
                    }
                    break;
                  case 'delete':
                    _showDeleteDialog(record);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(GasRecord record) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.deleteRecord ?? 'Delete Record'),
        content: const Text('Are you sure you want to delete this record?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)?.cancel ?? 'Cancel'),
          ),
          FilledButton(
            onPressed: () {
              _controller.deleteRecord(record.id!, record.vehicleId!);
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)?.delete ?? 'Delete'),
          ),
        ],
      ),
    );
  }
}
