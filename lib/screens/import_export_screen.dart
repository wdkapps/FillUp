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
    final l10n = AppLocalizations.of(context);
    final controller = Get.put(GasRecordController());

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.importExport),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // CSV Export
          Card(
            child: ListTile(
              leading: const Icon(Icons.upload_file),
              title: Text(l10n.export),
              subtitle: Text(l10n.exportSubtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final id = vehicle.id;
                if (id == null) return;
                await controller.loadRecords(id);
                final success = await CsvHandler.exportToCsv(
                  controller.records,
                  vehicle.name,
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        success ? l10n.exportSuccess : l10n.exportFailed,
                      ),
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
              title: Text(l10n.import),
              subtitle: Text(l10n.importSubtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final files = await FilePicker.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['csv'],
                );
                if (files.isNotEmpty) {
                  final filePath = files.first.path;
                  if (filePath == null) return;
                  final records = await CsvHandler.importFromCsv(filePath);
                  if (records.isNotEmpty) {
                    for (final record in records) {
                      await controller
                          .addRecord(record.copyWith(vehicleId: vehicle.id));
                    }
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            l10n.importedRecords(records.length),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context, true);
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.noValidRecords),
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
              title: Text(l10n.shareTitle),
              subtitle: Text(l10n.shareSubtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final id = vehicle.id;
                if (id == null) return;
                await controller.loadRecords(id);
                final success = await CsvHandler.exportToCsv(
                  controller.records,
                  vehicle.name,
                );
                if (success) {
                  final path = await CsvHandler.getExportPath();
                  await SharePlus.instance.share(
                    ShareParams(
                      files: [XFile(path)],
                      text: l10n.shareRecords(vehicle.name),
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
