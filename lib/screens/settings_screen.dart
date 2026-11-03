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
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Units section
            _buildSectionTitle(context, l10n.units),
            RadioGroup<Units>(
              groupValue: controller.unit,
              onChanged: (value) {
                if (value != null) controller.setUnit(value);
              },
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        l10n.usSection,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(l10n.usSubtitle),
                    ),
                    RadioListTile<Units>(
                      title: Text(l10n.mpgLabel),
                      value: Units.mpg,
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: Text(
                        l10n.metricSection,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(l10n.metricSubtitle),
                    ),
                    RadioListTile<Units>(
                      title: Text(l10n.kmlLabel),
                      value: Units.kml,
                    ),
                    RadioListTile<Units>(
                      title: Text(l10n.l100kmLabel),
                      value: Units.l100km,
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: Text(
                        l10n.ukSection,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(l10n.ukSubtitle),
                    ),
                    RadioListTile<Units>(
                      title: Text(l10n.ukmpgLabel),
                      value: Units.ukmpg,
                    ),
                    RadioListTile<Units>(
                      title: Text(l10n.kpgLabel),
                      value: Units.kpg,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Language section
            _buildSectionTitle(context, l10n.language),
            SegmentedButton<String>(
              segments: [
                ButtonSegment(value: 'en', label: Text('English')),
                ButtonSegment(value: 'de', label: Text('Deutsch')),
                ButtonSegment(value: 'es', label: Text('Español')),
                ButtonSegment(value: 'fr', label: Text('Français')),
                ButtonSegment(value: 'pt-BR', label: Text('Português (BR)')),
                ButtonSegment(value: 'ru', label: Text('Русский')),
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
            _buildSectionTitle(context, l10n.theme),
            SegmentedButton<ThemeMode>(
              segments: [
                ButtonSegment(value: ThemeMode.light, label: Text(l10n.light)),
                ButtonSegment(value: ThemeMode.dark, label: Text(l10n.dark)),
                ButtonSegment(value: ThemeMode.system, label: Text(l10n.system)),
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
            _buildSectionTitle(context, l10n.currency),
            Card(
              child: ListTile(
                leading: const Icon(Icons.attach_money),
                title: Text(l10n.currency),
                subtitle: Text(controller.currency),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showCurrencyDialog(context, controller, l10n),
              ),
            ),
            const SizedBox(height: 24),

            // Display options
            _buildSectionTitle(context, l10n.display),
            SwitchListTile(
              title: Text(l10n.requireCost),
              subtitle: Text(l10n.requireCostSubtitle),
              value: controller.requireCost.value,
              onChanged: (value) => controller.setRequireCost(value),
            ),
            SwitchListTile(
              title: Text(l10n.displayCost),
              value: controller.displayCost.value,
              onChanged: (value) => controller.setDisplayCost(value),
            ),
            SwitchListTile(
              title: Text(l10n.displayNotes),
              value: controller.displayNotes.value,
              onChanged: (value) => controller.setDisplayNotes(value),
            ),
            const SizedBox(height: 24),

            // Database section
            _buildSectionTitle(context, l10n.database),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.backup),
                    title: Text(l10n.backupDatabase),
                    subtitle: Text(l10n.backupDatabaseSubtitle),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _backupDatabase(context, l10n),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.restore),
                    title: Text(l10n.restoreDatabase),
                    subtitle: Text(l10n.restoreDatabaseSubtitle),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _restoreDatabase(context, l10n),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Help section
            Card(
              child: ListTile(
                leading: const Icon(Icons.help_outline),
                title: Text(l10n.help),
                subtitle: Text(l10n.helpSubtitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showHelpDialog(context, l10n),
              ),
            ),
            const SizedBox(height: 8),

            // About section
            Card(
              child: ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(l10n.about),
                subtitle: Text(l10n.aboutSubtitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showAboutScreen(context, l10n),
              ),
            ),
            const SizedBox(height: 8),

            // License section
            Card(
              child: ListTile(
                leading: const Icon(Icons.description_outlined),
                title: Text(l10n.license),
                subtitle: Text(l10n.licenseSubtitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showLicenseScreen(context, l10n),
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

  void _showHelpDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.help),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.faqs,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 16),
              _HelpSection(title: l10n.helpQ1, content: l10n.helpA1),
              _HelpSection(title: l10n.helpQ2, content: l10n.helpA2),
              _HelpSection(title: l10n.helpQ3, content: l10n.helpA3),
              _HelpSection(title: l10n.helpQ4, content: l10n.helpA4),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.close),
          ),
        ],
      ),
    );
  }

  void _showAboutScreen(BuildContext context, AppLocalizations l10n) async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.about),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.appTitle,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(l10n.gasMileageLog),
                    ],
                  ),
                ],
              ),
              const Divider(height: 32),
              _AboutRow(title: l10n.appVersion, value: packageInfo.version),
              _AboutRow(title: l10n.buildDate, value: _formatBuildDate()),
              _AboutRow(
                title: l10n.databaseVersion,
                value: '${AppConstants.dbVersion}',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.close),
          ),
        ],
      ),
    );
  }

  void _showLicenseScreen(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.license),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.copyright,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(l10n.licenseText),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.close),
          ),
        ],
      ),
    );
  }

  String _formatBuildDate() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  Future<void> _backupDatabase(BuildContext context, AppLocalizations l10n) async {
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
        ShareParams(files: [XFile(backupPath)], text: l10n.backupDatabase),
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.backupSuccess),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.backupFailed('$e')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _restoreDatabase(BuildContext context, AppLocalizations l10n) async {
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
            title: Text(l10n.restoreDatabase),
            content: Text(l10n.restoreConfirm),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(l10n.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                child: Text(l10n.restoreDatabase),
              ),
            ],
          ),
        );

        if (confirmed == true) {
          final filePath = files.first.path;
          if (filePath == null) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.restoreFailed('No file selected')), backgroundColor: Colors.red),
              );
            }
            return;
          }
          final dbHelper = DatabaseHelper.instance;
          final db = await dbHelper.database;
          final dbPath = db.path;

          await dbHelper.close();

          final backupFile = File(filePath);
          await backupFile.copy(dbPath);

          final backupWal = File('$filePath-wal');
          final backupShm = File('$filePath-shm');

          if (await backupWal.exists()) {
            await backupWal.copy('$dbPath-wal');
          }
          if (await backupShm.exists()) {
            await backupShm.copy('$dbPath-shm');
          }

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.restoreSuccess),
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
            content: Text(l10n.restoreFailed('$e')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showCurrencyDialog(
    BuildContext context,
    SettingsController controller,
    AppLocalizations l10n,
  ) {
    final currencies = CurrencyManager.instance.getAvailableCurrencies();
    final searchController = TextEditingController();
    var filtered = List.of(currencies);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(l10n.selectCurrency),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: l10n.searchCurrenciesHint,
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(),
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
              child: Text(l10n.cancel),
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
