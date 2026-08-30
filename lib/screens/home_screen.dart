import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../l10n/generated/app_localizations.dart';
import '../controllers/vehicle_controller.dart';
import '../controllers/settings_controller.dart';
import '../models/vehicle.dart';
import '../models/units.dart';
import '../models/mileage_calculation.dart';
import '../constants/app_icons.dart';
import '../widgets/vehicle_brand_widget.dart';
import 'gas_record_screen.dart';
import 'gas_log_list_screen.dart';
import 'plot_screen.dart';
import 'statistics_screen.dart';
import 'import_export_screen.dart';
import 'settings_screen.dart';

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

    return Obx(() {
      final hasVehicles = vehicleController.vehicles.isNotEmpty;

      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)?.appTitle ?? 'FillUp'),
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
                      Text(AppLocalizations.of(context)?.settings ?? 'Settings'),
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
                ? _buildVehicleList(context, vehicleController)
                : _buildEmptyState(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddVehicleDialog(context),
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

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.directions_car, size: 80),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)?.noVehicles ?? 'No vehicles added yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => _showAddVehicleDialog(context),
            icon: const Icon(Icons.add),
            label: Text(AppLocalizations.of(context)?.addVehicle ?? 'Add Vehicle'),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleList(BuildContext context, VehicleController controller) {
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
          subtitle = '${vehicle.tankSize} ${unit.liquidVolumeLabel}';
        } else {
          final odoStr = odo != null ? NumberFormat('#,###').format(odo) : '-';
          final avgStr = avgMileage != null
              ? '${avgMileage.toStringAsFixed(2)} ${unit.mileageLabel}'
              : '-';
          subtitle = '$recordCount records | $odoStr ${unit.distanceLabel} | $avgStr';
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
                  onPressed: () => _showEditVehicleDialog(context, vehicle),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _showDeleteVehicleDialog(context, vehicle),
                ),
              ],
            ),
            onTap: () {
              controller.selectVehicle(vehicle);
              _showVehicleMenu(context, vehicle);
            },
          ),
        );
      },
    );
  }

  void _showVehicleMenu(BuildContext context, Vehicle vehicle) {
    final settingsController = Get.find<SettingsController>();
    final unitLabel = settingsController.unit.liquidVolumeLabel;
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
              title: Text(AppLocalizations.of(context)?.addRecord ?? 'Add Record'),
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
              title: Text(AppLocalizations.of(context)?.fuelRecords ?? 'Fuel Records'),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => GasLogListScreen(vehicle: vehicle));
              },
            ),
            ListTile(
              leading: AppIcons.getPlotIcon(size: 24),
              title: Text(AppLocalizations.of(context)?.plot ?? 'Plot'),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => PlotScreen(vehicle: vehicle));
              },
            ),
            ListTile(
              leading: AppIcons.getStatsIcon(size: 24),
              title: Text(AppLocalizations.of(context)?.statistics ?? 'Statistics'),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => StatisticsScreen(vehicle: vehicle));
              },
            ),
            ListTile(
              leading: const Icon(AppIcons.importFile),
              title: const Text('Import/Export'),
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

  void _showAddVehicleDialog(BuildContext context) {
    final nameController = TextEditingController();
    final tankSizeController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final settingsController = Get.find<SettingsController>();
    final unitLabel = settingsController.unit.liquidVolumeLabel;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.addVehicle ?? 'Add Vehicle'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.vehicleName ?? 'Vehicle Name',
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
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
                  labelText: '${AppLocalizations.of(context)?.tankSize ?? 'Tank Size'} ($unitLabel)',
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter tank size';
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
            child: Text(AppLocalizations.of(context)?.cancel ?? 'Cancel'),
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
            child: Text(AppLocalizations.of(context)?.save ?? 'Save'),
          ),
        ],
      ),
    );
  }

  void _showEditVehicleDialog(BuildContext context, Vehicle vehicle) {
    final nameController = TextEditingController(text: vehicle.name);
    final tankSizeController = TextEditingController(text: vehicle.tankSize.toString());
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.editVehicle ?? 'Edit Vehicle'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.vehicleName ?? 'Vehicle Name',
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
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
                  labelText: AppLocalizations.of(context)?.tankSize ?? 'Tank Size',
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter tank size';
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
            child: Text(AppLocalizations.of(context)?.cancel ?? 'Cancel'),
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
            child: Text(AppLocalizations.of(context)?.save ?? 'Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteVehicleDialog(BuildContext context, Vehicle vehicle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.deleteVehicle ?? 'Delete Vehicle'),
        content: Text('Are you sure you want to delete ${vehicle.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)?.cancel ?? 'Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              await Get.find<VehicleController>().deleteVehicle(vehicle.id!);
              if (context.mounted) Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)?.delete ?? 'Delete'),
          ),
        ],
      ),
    );
  }
}
