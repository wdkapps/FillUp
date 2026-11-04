import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/vehicle.dart';
import '../models/gas_record.dart';
import '../controllers/gas_record_controller.dart';
import '../controllers/settings_controller.dart';

class GasRecordScreen extends StatefulWidget {
  final Vehicle vehicle;
  final GasRecord? record;

  const GasRecordScreen({super.key, required this.vehicle, this.record});

  @override
  State<GasRecordScreen> createState() => _GasRecordScreenState();
}

class _GasRecordScreenState extends State<GasRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _date;
  late TextEditingController _odometerController;
  late TextEditingController _gallonsController;
  late TextEditingController _costController;
  late TextEditingController _notesController;
  late bool _fullTank;

  @override
  void initState() {
    super.initState();
    _date = widget.record?.date ?? DateTime.now();
    _odometerController = TextEditingController(
      text: widget.record?.odometer.toString() ?? '',
    );
    _gallonsController = TextEditingController(
      text: widget.record?.gallons.toString() ?? '',
    );
    _costController = TextEditingController(
      text: widget.record?.cost.toString() ?? '',
    );
    _notesController = TextEditingController(
      text: widget.record?.notes ?? '',
    );
    _fullTank = widget.record?.fullTank ?? false;
  }

  @override
  void dispose() {
    _odometerController.dispose();
    _gallonsController.dispose();
    _costController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final settings = Get.find<SettingsController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.record != null ? l10n.editRecord : l10n.addRecord,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Date picker
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(l10n.date),
              subtitle: Text(DateFormat.yMMMd().format(_date)),
              onTap: _selectDate,
            ),
            const Divider(),

            // Odometer
            TextFormField(
              controller: _odometerController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: l10n.odometer,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.speed),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.pleaseEnterOdometer;
                }
                try {
                  GasRecord.validateOdometer(int.parse(value));
                  return null;
                } catch (e) {
                  return e.toString();
                }
              },
            ),
            const SizedBox(height: 16),

            // Gallons/Liters
            TextFormField(
              controller: _gallonsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '${l10n.fuelAmount} (${settings.unit.isImperial ? l10n.gallonsUnit : l10n.litersUnit})',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.local_gas_station),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.pleaseEnterFuel(settings.unit.isImperial ? l10n.gallonsUnit : l10n.litersUnit);
                }
                try {
                  GasRecord.validateGallons(double.parse(value));
                  return null;
                } catch (e) {
                  return e.toString();
                }
              },
            ),
            const SizedBox(height: 16),

            // Cost
            TextFormField(
              controller: _costController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: l10n.cost,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.attach_money),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.pleaseEnterCost;
                }
                try {
                  GasRecord.validateCost(double.parse(value));
                  return null;
                } catch (e) {
                  return e.toString();
                }
              },
            ),
            const SizedBox(height: 16),

            // Full tank checkbox
            SwitchListTile(
              title: Text(l10n.fullTank),
              subtitle: Text(l10n.fullTankSubtitle),
              value: _fullTank,
              onChanged: (value) {
                setState(() {
                  _fullTank = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Notes
            TextFormField(
              controller: _notesController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: l10n.notes,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.notes),
              ),
            ),
            const SizedBox(height: 24),

            // Save button
            FilledButton.icon(
              onPressed: _saveRecord,
              icon: const Icon(Icons.save),
              label: Text(l10n.save),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  Future<void> _saveRecord() async {
    if (_formKey.currentState!.validate()) {
      final record = GasRecord(
        id: widget.record?.id,
        vehicleId: widget.record?.vehicleId ?? widget.vehicle.id,
        date: _date,
        odometer: int.parse(_odometerController.text),
        gallons: double.parse(_gallonsController.text),
        cost: double.parse(_costController.text),
        notes: _notesController.text,
        fullTank: _fullTank,
        hidden: widget.record?.hidden ?? false,
        price: GasRecord.calculatePrice(
          double.parse(_costController.text),
          double.parse(_gallonsController.text),
        ),
      );

      final controller = Get.find<GasRecordController>();
      bool saved;
      if (widget.record != null) {
        saved = await controller.updateRecord(record);
      } else {
        saved = await controller.addRecord(record);
      }

      if (saved) {
        Navigator.pop(context, true);
      }
    }
  }
}
