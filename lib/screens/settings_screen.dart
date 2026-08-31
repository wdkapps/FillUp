import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../l10n/generated/app_localizations.dart';
import '../controllers/settings_controller.dart';
import '../models/units.dart';
import '../constants/app_constants.dart';
import '../database/database_helper.dart';
import '../utils/currency_manager.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.settings ?? 'Settings'),
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Units section
            _buildSectionTitle(
              context,
              AppLocalizations.of(context)?.units ?? 'Units',
            ),
            RadioGroup<Units>(
              groupValue: controller.unit,
              onChanged: (value) {
                if (value != null) controller.setUnit(value);
              },
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(
                        'US',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text('Miles, Gallons'),
                    ),
                    const RadioListTile<Units>(
                      title: Text('MPG (miles per gallon)'),
                      value: Units.mpg,
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text(
                        'Metric',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text('Kilometers, Liters'),
                    ),
                    const RadioListTile<Units>(
                      title: Text('KM/L (kilometers per liter)'),
                      value: Units.kml,
                    ),
                    const RadioListTile<Units>(
                      title: Text('L/100KM (liters per 100 km)'),
                      value: Units.l100km,
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text(
                        'UK',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text('Miles, Imperial Gallons'),
                    ),
                    const RadioListTile<Units>(
                      title: Text('UK MPG (miles per imperial gallon)'),
                      value: Units.ukmpg,
                    ),
                    const RadioListTile<Units>(
                      title: Text('KPG (kilometers per gallon)'),
                      value: Units.kpg,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Language section
            _buildSectionTitle(
              context,
              AppLocalizations.of(context)?.language ?? 'Language',
            ),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'en', label: Text('English')),
                ButtonSegment(value: 'ar', label: Text('العربية')),
                ButtonSegment(value: 'tr', label: Text('Türkçe')),
              ],
              selected: {controller.language},
              onSelectionChanged: (Set<String> selected) {
                if (selected.isNotEmpty) {
                  controller.setLanguage(selected.first);
                }
              },
            ),
            const SizedBox(height: 24),

            // Theme section
            _buildSectionTitle(
              context,
              AppLocalizations.of(context)?.theme ?? 'Theme',
            ),
            SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(value: ThemeMode.light, label: Text('Light')),
                ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
                ButtonSegment(value: ThemeMode.system, label: Text('System')),
              ],
              selected: {controller.themeMode},
              onSelectionChanged: (Set<ThemeMode> selected) {
                if (selected.isNotEmpty) {
                  controller.setThemeMode(selected.first);
                }
              },
            ),
            const SizedBox(height: 24),

            // Currency section
            _buildSectionTitle(context, 'Currency'),
            Card(
              child: ListTile(
                leading: const Icon(Icons.attach_money),
                title: const Text('Currency'),
                subtitle: Text(controller.currency),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showCurrencyDialog(context, controller),
              ),
            ),
            const SizedBox(height: 24),

            // Display options
            _buildSectionTitle(context, 'Display'),
            SwitchListTile(
              title: const Text('Require Cost'),
              subtitle: const Text('When entering fuel purchase'),
              value: controller.requireCost.value,
              onChanged: (value) => controller.setRequireCost(value),
            ),
            SwitchListTile(
              title: const Text('Display Cost in Log'),
              value: controller.displayCost.value,
              onChanged: (value) => controller.setDisplayCost(value),
            ),
            SwitchListTile(
              title: const Text('Display Notes in Log'),
              value: controller.displayNotes.value,
              onChanged: (value) => controller.setDisplayNotes(value),
            ),
            const SizedBox(height: 24),

            // Database section
            _buildSectionTitle(context, 'Database'),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.backup),
                    title: const Text('Backup Database'),
                    subtitle: const Text('Backup entire database to file'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _backupDatabase(context),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.restore),
                    title: const Text('Restore Database'),
                    subtitle: const Text('Restore database from backup file'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _restoreDatabase(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Help section
            Card(
              child: ListTile(
                leading: const Icon(Icons.help_outline),
                title: Text(AppLocalizations.of(context)?.help ?? 'Help'),
                subtitle: const Text('Display application help information'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showHelpDialog(context),
              ),
            ),
            const SizedBox(height: 8),

            // About section
            Card(
              child: ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(AppLocalizations.of(context)?.about ?? 'About'),
                subtitle: const Text('Display application version information'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showAboutScreen(context),
              ),
            ),
            const SizedBox(height: 8),

            // License section
            Card(
              child: ListTile(
                leading: const Icon(Icons.description_outlined),
                title: const Text('License'),
                subtitle: const Text('Display the software license'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showLicenseScreen(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Frequently Asked Questions (FAQ)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 16),
              _HelpSection(
                title: 'Why isn\'t FillUp calculating my mileage?',
                content:
                    'You need to fill your tank once to establish a starting point, and then continue recording all of your fuel purchases. Each time you fill your tank after the starting point, FillUp will calculate your mileage by determining the distance driven and fuel used since the previous full tank.\n\nTIP: In the Add Fuel screen, put a check mark in the "Tank Full" box to indicate when the tank has been filled, otherwise FillUp will never calculate mileage.',
              ),
              _HelpSection(
                title: 'Why does FillUp only estimate my mileage?',
                content:
                    'A full tank is needed to accurately calculate how much fuel was used since the previous full tank. When you get fuel and the tank is not full, FillUp cannot calculate mileage exactly. Instead it will allow you to estimate mileage.',
              ),
              _HelpSection(
                title: 'What if I forget to record a fuel purchase?',
                content:
                    'The next time you fill your tank, the mileage calculation will be wrong (too high). You can hide this value by selecting it in the Log and clicking "Hide Calculation".',
              ),
              _HelpSection(
                title: 'How do I backup/restore my data?',
                content:
                    'FillUp Log data is stored in a database on your device. Use Export to save Log data to a CSV file, and Import to restore it.',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAboutScreen(BuildContext context) async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.local_gas_station,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FillUp',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Gas Mileage Log'),
                    ],
                  ),
                ],
              ),
              const Divider(height: 32),
              _AboutRow(title: 'Package Name', value: packageInfo.packageName),
              _AboutRow(title: 'Package Version', value: packageInfo.version),
              _AboutRow(title: 'Build Date', value: _formatBuildDate()),
              _AboutRow(
                title: 'Database Version',
                value: '${AppConstants.dbVersion}',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLicenseScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('License'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Copyright © 2013,2014 William D. Kraemer - Rewritten by Muhammad Bashir Al-Noimi',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Licensed under the Apache License, Version 2.0 (the "License"); '
                'you may not use this software except in compliance with the License. '
                'You may obtain a copy of the License at:',
              ),
              SizedBox(height: 8),
              Text(
                'http://www.apache.org/licenses/LICENSE-2.0',
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(height: 16),
              Text(
                'Unless required by applicable law or agreed to in writing, software '
                'distributed under the License is distributed on an "AS IS" BASIS, '
                'WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. '
                'See the License for the specific language governing permissions and '
                'limitations under the License.',
              ),
              SizedBox(height: 16),
              Text(
                'Use of this software constitutes acceptance of this license.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  String _formatBuildDate() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  Future<void> _backupDatabase(BuildContext context) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final db = await dbHelper.database;
      final dbPath = db.path;

      final directory = await getApplicationDocumentsDirectory();
      final backupPath =
          '${directory.path}/fillup_backup_${DateTime.now().millisecondsSinceEpoch}.db';

      final dbFile = File(dbPath);

      await dbFile.copy(backupPath);

      final walFile = File('$dbPath-wal');
      final shmFile = File('$dbPath-shm');

      if (await walFile.exists()) {
        await walFile.copy('$backupPath-wal');
      }
      if (await shmFile.exists()) {
        await shmFile.copy('$backupPath-shm');
      }

      await SharePlus.instance.share(
        ShareParams(files: [XFile(backupPath)], text: 'FillUp Database Backup'),
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Database backup created successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Backup failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _restoreDatabase(BuildContext context) async {
    try {
      final files = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['db'],
      );

      if (files.isNotEmpty) {
        if (!context.mounted) return;
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Restore Database'),
            content: const Text(
              'This will replace your current database with the backup. '
              'This action cannot be undone. Continue?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Restore'),
              ),
            ],
          ),
        );

        if (confirmed == true) {
          final dbHelper = DatabaseHelper.instance;
          final db = await dbHelper.database;
          final dbPath = db.path;

          await dbHelper.close();

          final backupFile = File(files.first.path!);
          await backupFile.copy(dbPath);

          final backupWal = File('${files.first.path!}-wal');
          final backupShm = File('${files.first.path!}-shm');

          if (await backupWal.exists()) {
            await backupWal.copy('$dbPath-wal');
          }
          if (await backupShm.exists()) {
            await backupShm.copy('$dbPath-shm');
          }

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Database restored successfully. Please restart the app.',
                ),
                backgroundColor: Colors.green,
              ),
            );
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Restore failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showCurrencyDialog(
    BuildContext context,
    SettingsController controller,
  ) {
    final currencies = CurrencyManager.instance.getAvailableCurrencies();
    final searchController = TextEditingController();
    var filtered = List.of(currencies);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Select Currency'),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search currencies...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      filtered = currencies
                          .where(
                            (c) =>
                                c.code.toLowerCase().contains(
                                  value.toLowerCase(),
                                ) ||
                                c.name.toLowerCase().contains(
                                  value.toLowerCase(),
                                ) ||
                                c.localName.toLowerCase().contains(
                                  value.toLowerCase(),
                                ),
                          )
                          .toList();
                    });
                  },
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final currency = filtered[index];
                      final isSelected = controller.currency == currency.code;
                      return ListTile(
                        leading: Text(
                          currency.symbol,
                          style: const TextStyle(fontSize: 20),
                        ),
                        title: Text('${currency.localName} ${currency.symbol}'),
                        subtitle: Text('${currency.code} - ${currency.name}'),
                        trailing: isSelected ? const Icon(Icons.check) : null,
                        selected: isSelected,
                        onTap: () {
                          controller.setCurrency(currency.code);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutRow extends StatelessWidget {
  final String title;
  final String value;

  const _AboutRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }
}

class _HelpSection extends StatelessWidget {
  final String title;
  final String content;

  const _HelpSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(content),
        ],
      ),
    );
  }
}
