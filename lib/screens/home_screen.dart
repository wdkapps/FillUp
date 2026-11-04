import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../l10n/generated/app_localizations.dart';
import '../controllers/vehicle_controller.dart';
import '../controllers/settings_controller.dart';
import '../models/vehicle.dart';
import '../constants/app_icons.dart';
import '../widgets/vehicle_brand_widget.dart';
import 'gas_record_screen.dart';
import 'gas_log_list_screen.dart';
import 'plot_screen.dart';
import 'statistics_screen.dart';
import 'import_export_screen.dart';
import 'settings_screen.dart';
import '../utils/mileage_calculator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<int, Map<String, dynamic>>? _vehicleStats;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final controller = Get.find<VehicleController>();
    final stats = await controller.getAllVehicleStats();
    if (mounted) setState(() { _vehicleStats = stats; });
  }

  @override
  Widget build(BuildContext context) {
    final vehicleController = Get.put(VehicleController());
    final l10n = AppLocalizations.of(context);

    return Obx(() {
      final hasVehicles = vehicleController.vehicles.isNotEmpty;

      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.appTitle),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'settings':
                    Get.to(() => const SettingsScreen());
                    break;
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'settings',
                  child: Row(
                    children: [
                      const Icon(Icons.settings),
                      const SizedBox(width: 8),
                      Text(l10n.settings),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: vehicleController.isLoading
            ? const Center(child: CircularProgressIndicator())
            : hasVehicles
                ? _buildVehicleList(context, vehicleController, l10n)
                : _buildEmptyState(context, l10n),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddVehicleDialog(context, l10n),
          child: const Icon(Icons.add),
        ),
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadStats();
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.directions_car, size: 80),
          const SizedBox(height: 24),
          Text(
            l10n.noVehicles,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => _showAddVehicleDialog(context, l10n),
            icon: const Icon(Icons.add),
            label: Text(l10n.addVehicle),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleList(
      BuildContext context,
      VehicleController controller,
      AppLocalizations l10n) {
    final settingsController = Get.find<SettingsController>();
    final unit = settingsController.unit;
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: controller.vehicles.length,
      itemBuilder: (context, index) {
        final vehicle = controller.vehicles[index];
        final isSelected = controller.currentVehicle?.id == vehicle.id;
        final stats = _vehicleStats?[vehicle.id];
        final odo = stats?['odometer'] as int?;
        final avgMileage = stats?['avgMileage'] as double?;
        final recordCount = stats?['recordCount'] as int? ?? 0;

        String subtitle;
        if (recordCount == 0) {
          subtitle = l10n.tankSizeOnly(
              vehicle.tankSize.toString(),
              MileageCalculator.fuelVolumeLabel(unit, l10n));
        } else {
          final odoStr = odo != null ? NumberFormat('#,###').format(odo) : '-';
          final avgStr = avgMileage != null
              ? '${avgMileage.toStringAsFixed(2)} ${MileageCalculator.getUnitLabel(unit, l10n)}'
              : '-';
          subtitle = l10n.recordsLabelShort(
            recordCount,
            odoStr,
            MileageCalculator.distanceLabel(unit, l10n),
            avgStr,
          );
        }

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: VehicleBrandWidget(
              vehicleName: vehicle.name,
              size: 36,
            ),
            title: Text(vehicle.name),
            subtitle: Text(subtitle),
            selected: isSelected,
            selectedTileColor: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showEditVehicleDialog(context, vehicle, l10n),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _showDeleteVehicleDialog(context, vehicle, l10n),
                ),
              ],
            ),
            onTap: () {
              controller.selectVehicle(vehicle);
              _showVehicleMenu(context, vehicle, l10n);
            },
          ),
        );
      },
    );
  }

  void _showVehicleMenu(
      BuildContext context,
      Vehicle vehicle,
      AppLocalizations l10n) {
    final settingsController = Get.find<SettingsController>();
    final unitLabel = MileageCalculator.fuelVolumeLabel(settingsController.unit, l10n);
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: VehicleBrandWidget(
                vehicleName: vehicle.name,
                size: 32,
              ),
              title: Text(vehicle.name),
              subtitle: Text('${vehicle.tankSize} $unitLabel'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(AppIcons.add),
              title: Text(l10n.addRecord),
              onTap: () async {
                Navigator.pop(context);
                final result = await Get.to(() => GasRecordScreen(vehicle: vehicle));
                if (result == true) {
                  _loadStats();
                }
              },
            ),
            ListTile(
              leading: const Icon(AppIcons.notepad),
              title: Text(l10n.fuelRecords),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => GasLogListScreen(vehicle: vehicle));
              },
            ),
            ListTile(
              leading: AppIcons.getPlotIcon(size: 24),
              title: Text(l10n.plot),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => PlotScreen(vehicle: vehicle));
              },
            ),
            ListTile(
              leading: AppIcons.getStatsIcon(size: 24),
              title: Text(l10n.statistics),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => StatisticsScreen(vehicle: vehicle));
              },
            ),
            ListTile(
              leading: const Icon(AppIcons.importFile),
              title: Text(l10n.importExport),
              onTap: () async {
                Navigator.pop(context);
                final result = await Get.to(() => ImportExportScreen(vehicle: vehicle));
                if (result == true) {
                  _loadStats();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddVehicleDialog(BuildContext context, AppLocalizations l10n) {
    final nameController = TextEditingController();
    final tankSizeController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final settingsController = Get.find<SettingsController>();
    final unitLabel = MileageCalculator.fuelVolumeLabel(settingsController.unit, l10n);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.addVehicle),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: l10n.vehicleName,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.pleaseEnterName;
                  }
                  try {
                    Vehicle.validateName(value);
                    return null;
                  } catch (e) {
                    return e.toString();
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: tankSizeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '${l10n.tankSize} ($unitLabel)',
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.pleaseEnterTankSize;
                  }
                  try {
                    Vehicle.validateTankSize(double.parse(value));
                    return null;
                  } catch (e) {
                    return e.toString();
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final vehicle = Vehicle(
                  name: nameController.text,
                  tankSize: double.parse(tankSizeController.text),
                );
                await Get.find<VehicleController>().addVehicle(vehicle);
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  void _showEditVehicleDialog(
      BuildContext context,
      Vehicle vehicle,
      AppLocalizations l10n) {
    final nameController = TextEditingController(text: vehicle.name);
    final tankSizeController =
        TextEditingController(text: vehicle.tankSize.toString());
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.editVehicle),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: l10n.vehicleName,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.pleaseEnterName;
                  }
                  try {
                    Vehicle.validateName(value);
                    return null;
                  } catch (e) {
                    return e.toString();
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: tankSizeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: l10n.tankSize,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.pleaseEnterTankSize;
                  }
                  try {
                    Vehicle.validateTankSize(double.parse(value));
                    return null;
                  } catch (e) {
                    return e.toString();
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final updatedVehicle = vehicle.copyWith(
                  name: nameController.text,
                  tankSize: double.parse(tankSizeController.text),
                );
                await Get.find<VehicleController>().updateVehicle(updatedVehicle);
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  void _showDeleteVehicleDialog(
      BuildContext context,
      Vehicle vehicle,
      AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteVehicle),
        content: Text(l10n.confirmDeleteVehicle(vehicle.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () async {
              final id = vehicle.id;
              if (id == null) return;
              await Get.find<VehicleController>().deleteVehicle(id);
              if (context.mounted) Navigator.pop(context);
            },
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}
