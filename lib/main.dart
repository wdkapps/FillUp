import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'app.dart';
import 'utils/seed_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.macOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  const fillDemo = String.fromEnvironment('FILL_DEMO', defaultValue: '');
  const resetDemo = String.fromEnvironment('RESET_DEMO', defaultValue: '');
  const statusDemo = String.fromEnvironment('STATUS_DEMO', defaultValue: '');

  if (fillDemo == 'true') {
    await SeedData.fill();
    final v = await SeedData.getVehicleCount();
    final r = await SeedData.getRecordCount();
    debugPrint('DEMO_FILL: $v vehicles, $r records');
    runApp(const FillUpApp());
    return;
  }

  if (resetDemo == 'true') {
    final v = await SeedData.getVehicleCount();
    final r = await SeedData.getRecordCount();
    await SeedData.reset();
    debugPrint('DEMO_RESET: removed $v vehicles, $r records');
    runApp(const FillUpApp());
    return;
  }

  if (statusDemo == 'true') {
    final v = await SeedData.getVehicleCount();
    final r = await SeedData.getRecordCount();
    debugPrint('DEMO_STATUS: $v vehicles, $r records');
    runApp(const FillUpApp());
    return;
  }

  await SeedData.seed();

  runApp(const FillUpApp());
}
