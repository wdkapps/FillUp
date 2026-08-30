import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/vehicle.dart';
import '../controllers/gas_record_controller.dart';
import '../utils/csv_handler.dart';

class ImportExportScreen extends StatelessWidget {
  final Vehicle vehicle;

  const ImportExportScreen({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GasRecordController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Import/Export'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // CSV Export
          Card(
            child: ListTile(
              leading: const Icon(Icons.upload_file),
              title: Text(AppLocalizations.of(context)?.export ?? 'Export'),
              subtitle: const Text('Export fuel records to CSV file'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                await controller.loadRecords(vehicle.id!);
                final success = await CsvHandler.exportToCsv(
                  controller.records,
                  vehicle.name,
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(success ? 'Export successful' : 'Export failed'),
                      backgroundColor: success ? Colors.green : Colors.red,
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 8),

          // CSV Import
          Card(
            child: ListTile(
              leading: const Icon(Icons.download),
              title: Text(AppLocalizations.of(context)?.import ?? 'Import'),
              subtitle: const Text('Import fuel records from CSV file'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final files = await FilePicker.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['csv'],
                );
                if (files.isNotEmpty) {
                  final records = await CsvHandler.importFromCsv(
                    files.first.path!,
                  );
                  if (records.isNotEmpty) {
                    for (final record in records) {
                      await controller.addRecord(record.copyWith(vehicleId: vehicle.id));
                    }
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Imported ${records.length} records'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context, true);
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No valid records found'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                }
              },
            ),
          ),
          const SizedBox(height: 8),

          // Share CSV
          Card(
            child: ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              subtitle: const Text('Share CSV file'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                await controller.loadRecords(vehicle.id!);
                final success = await CsvHandler.exportToCsv(
                  controller.records,
                  vehicle.name,
                );
                if (success) {
                  final path = await CsvHandler.getExportPath();
                  await SharePlus.instance.share(
                    ShareParams(
                      files: [XFile(path)],
                      text: 'Fuel records for ${vehicle.name}',
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
