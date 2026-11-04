// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'FillUp';

  @override
  String get vehicleName => 'Vehicle Name';

  @override
  String get tankSize => 'Tank Size';

  @override
  String get addVehicle => 'Add Vehicle';

  @override
  String get editVehicle => 'Edit Vehicle';

  @override
  String get deleteVehicle => 'Delete Vehicle';

  @override
  String get date => 'Date';

  @override
  String get odometer => 'Odometer';

  @override
  String get gallons => 'Gallons';

  @override
  String get cost => 'Cost';

  @override
  String get fullTank => 'Full Tank';

  @override
  String get notes => 'Notes';

  @override
  String get addRecord => 'Add Record';

  @override
  String get editRecord => 'Edit Record';

  @override
  String get deleteRecord => 'Delete Record';

  @override
  String get mileage => 'Mileage';

  @override
  String get mpg => 'MPG';

  @override
  String get kml => 'KM/L';

  @override
  String get l100km => 'L/100KM';

  @override
  String get ukmpg => 'UK MPG';

  @override
  String get kpg => 'KPG';

  @override
  String get settings => 'Settings';

  @override
  String get units => 'Units';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get system => 'System';

  @override
  String get statistics => 'Statistics';

  @override
  String get charts => 'Charts';

  @override
  String get import => 'Import';

  @override
  String get export => 'Export';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get confirm => 'Confirm';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get ok => 'OK';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get loading => 'Loading...';

  @override
  String get noVehicles => 'No vehicles added yet';

  @override
  String get noRecords => 'No fuel records yet';

  @override
  String get selectVehicle => 'Select Vehicle';

  @override
  String get fuelRecords => 'Fuel Records';

  @override
  String get plot => 'Plot';

  @override
  String get mileagePlot => 'Mileage Plot';

  @override
  String get odometerPlot => 'Odometer Plot';

  @override
  String get gallonsPlot => 'Gallons Plot';

  @override
  String get costPlot => 'Cost Plot';

  @override
  String get pricePlot => 'Price Plot';

  @override
  String get startDate => 'Start Date';

  @override
  String get endDate => 'End Date';

  @override
  String get apply => 'Apply';

  @override
  String get reset => 'Reset';

  @override
  String get share => 'Share';

  @override
  String get about => 'About';

  @override
  String get help => 'Help';

  @override
  String get version => 'Version';

  @override
  String get importExport => 'Import/Export';

  @override
  String get pleaseEnterName => 'Please enter a name';

  @override
  String get pleaseEnterTankSize => 'Please enter tank size';

  @override
  String get pleaseEnterOdometer => 'Please enter odometer';

  @override
  String get pleaseEnterCost => 'Please enter cost';

  @override
  String pleaseEnterFuel(String unitLabel) {
    return 'Please enter $unitLabel';
  }

  @override
  String get fullTankSubtitle => 'Was the tank filled completely?';

  @override
  String get confirmDeleteRecord =>
      'Are you sure you want to delete this record?';

  @override
  String confirmDeleteVehicle(String name) {
    return 'Are you sure you want to delete $name?';
  }

  @override
  String get exportSubtitle => 'Export fuel records to CSV file';

  @override
  String get importSubtitle => 'Import fuel records from CSV file';

  @override
  String get shareTitle => 'Share';

  @override
  String get shareSubtitle => 'Share CSV file';

  @override
  String get exportSuccess => 'Export successful';

  @override
  String get exportFailed => 'Export failed';

  @override
  String get noValidRecords => 'No valid records found';

  @override
  String importedRecords(int count) {
    return 'Imported $count records';
  }

  @override
  String shareRecords(String name) {
    return 'Fuel records for $name';
  }

  @override
  String get currency => 'Currency';

  @override
  String get display => 'Display';

  @override
  String get requireCost => 'Require Cost';

  @override
  String get requireCostSubtitle => 'When entering fuel purchase';

  @override
  String get displayCost => 'Display Cost in Log';

  @override
  String get displayNotes => 'Display Notes in Log';

  @override
  String get database => 'Database';

  @override
  String get backupDatabase => 'Backup Database';

  @override
  String get backupDatabaseSubtitle => 'Backup entire database to file';

  @override
  String get restoreDatabase => 'Restore Database';

  @override
  String get restoreDatabaseSubtitle => 'Restore database from backup file';

  @override
  String get helpSubtitle => 'Display application help information';

  @override
  String get aboutSubtitle => 'Display application version information';

  @override
  String get license => 'License';

  @override
  String get licenseSubtitle => 'Display the software license';

  @override
  String get close => 'Close';

  @override
  String get summary => 'Summary';

  @override
  String get recordsLabel => 'Records';

  @override
  String get avg => 'Avg';

  @override
  String get min => 'Min';

  @override
  String get max => 'Max';

  @override
  String get total => 'Total';

  @override
  String get avgMonth => 'Avg/month';

  @override
  String perDistance(String unit) {
    return 'Per $unit';
  }

  @override
  String avgPerVolume(String unit) {
    return 'Avg/$unit';
  }

  @override
  String get distanceSection => 'Distance';

  @override
  String get fuelSection => 'Fuel';

  @override
  String get costSection => 'Cost';

  @override
  String get priceSection => 'Price';

  @override
  String get monthlyBreakdown => 'Monthly Breakdown';

  @override
  String get shareReport => 'Share Report';

  @override
  String shareReportError(String error) {
    return 'Failed to share report: $error';
  }

  @override
  String get usSection => 'US';

  @override
  String get usSubtitle => 'Miles, Gallons';

  @override
  String get metricSection => 'Metric';

  @override
  String get metricSubtitle => 'Kilometers, Liters';

  @override
  String get ukSection => 'UK';

  @override
  String get ukSubtitle => 'Miles, Imperial Gallons';

  @override
  String get mpgLabel => 'MPG (miles per gallon)';

  @override
  String get kmlLabel => 'KM/L (kilometers per liter)';

  @override
  String get l100kmLabel => 'L/100KM (liters per 100 km)';

  @override
  String get ukmpgLabel => 'UK MPG (miles per imperial gallon)';

  @override
  String get kpgLabel => 'KPG (kilometers per gallon)';

  @override
  String get gallonsUnit => 'gallons';

  @override
  String get litersUnit => 'liters';

  @override
  String get milesUnit => 'miles';

  @override
  String get kilometersUnit => 'kilometers';

  @override
  String get edit => 'Edit';

  @override
  String recordsLabelShort(
    int count,
    String odometer,
    String unitDistance,
    String mileage,
  ) {
    return '$count records | $odometer $unitDistance | $mileage';
  }

  @override
  String tankSizeOnly(String tankSize, String unit) {
    return '$tankSize $unit';
  }

  @override
  String recordsSubtitle(
    String odometer,
    String unitDistance,
    String fuel,
    String unitVolume,
  ) {
    return '$odometer $unitDistance | $fuel $unitVolume';
  }

  @override
  String get appVersion => 'App Version';

  @override
  String get buildDate => 'Build Date';

  @override
  String get databaseVersion => 'Database Version';

  @override
  String get gasMileageLog => 'Gas Mileage Log';

  @override
  String get selectCurrency => 'Select Currency';

  @override
  String get searchCurrenciesHint => 'Search currencies...';

  @override
  String get backupSuccess => 'Database backup created successfully';

  @override
  String backupFailed(String error) {
    return 'Backup failed: $error';
  }

  @override
  String get restoreSuccess =>
      'Database restored successfully. Please restart the app.';

  @override
  String restoreFailed(String error) {
    return 'Restore failed: $error';
  }

  @override
  String get restoreConfirm =>
      'This will replace your current database with the backup. This action cannot be undone. Continue?';

  @override
  String get faqs => 'Frequently Asked Questions (FAQ)';

  @override
  String get helpQ1 => 'Why isn\'t FillUp calculating my mileage?';

  @override
  String get helpA1 =>
      'You need to fill your tank once to establish a starting point, and then continue recording all of your fuel purchases. Each time you fill your tank after the starting point, FillUp will calculate your mileage by determining the distance driven and fuel used since the previous full tank.\n\nTIP: In the Add Fuel screen, put a check mark in the \"Tank Full\" box to indicate when the tank has been filled, otherwise FillUp will never calculate mileage.';

  @override
  String get helpQ2 => 'Why does FillUp only estimate my mileage?';

  @override
  String get helpA2 =>
      'A full tank is needed to accurately calculate how much fuel was used since the previous full tank. When you get fuel and the tank is not full, FillUp cannot calculate mileage exactly. Instead it will allow you to estimate mileage.';

  @override
  String get helpQ3 => 'What if I forget to record a fuel purchase?';

  @override
  String get helpA3 =>
      'The next time you fill your tank, the mileage calculation will be wrong (too high). You can hide this value by selecting it in the Log and clicking \"Hide Calculation\".';

  @override
  String get helpQ4 => 'How do I backup/restore my data?';

  @override
  String get helpA4 =>
      'FillUp Log data is stored in a database on your device. Use Export to save Log data to a CSV file, and Import to restore it.';

  @override
  String get licenseText =>
      'Licensed under the Apache License, Version 2.0 (the \"License\"); you may not use this software except in compliance with the License. You may obtain a copy of the License at:\n\nhttp://www.apache.org/licenses/LICENSE-2.0\n\nUnless required by applicable law or agreed to in writing, software distributed under the License is distributed on an \"AS IS\" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.\n\nUse of this software constitutes acceptance of this license.';

  @override
  String get copyright =>
      'Copyright © 2013,2014 William D. Kraemer - Rewritten by Muhammad Bashir Al-Noimi on 2026-08-31';

  @override
  String shareStatistics(String name) {
    return 'Statistics for $name';
  }

  @override
  String recordsSummary(
    String odometer,
    String unitDistance,
    String fuel,
    String unitVolume,
  ) {
    return '$odometer $unitDistance | $fuel $unitVolume';
  }

  @override
  String get allData => 'All data';

  @override
  String get dateRange => 'Date Range';

  @override
  String get months => 'months';

  @override
  String fuelEconomy(String metric) {
    return 'Fuel Economy ($metric)';
  }

  @override
  String get distanceDriven => 'Distance Driven';

  @override
  String get fuelPurchased => 'Fuel Purchased';

  @override
  String get fuelCost => 'Fuel Cost';

  @override
  String get fuelPrice => 'Fuel Price (avg)';

  @override
  String get perMonth => 'per month';

  @override
  String per(String unit) {
    return 'per $unit';
  }

  @override
  String get fuelAmount => 'Fuel Amount';

  @override
  String recordSummary(
    String odometer,
    String unitDistance,
    String fuel,
    String unitVolume,
    String mileagePart,
  ) {
    return '$odometer $unitDistance | $fuel $unitVolume$mileagePart';
  }

  @override
  String mileageUnitLabel(String unit) {
    return 'Mileage ($unit)';
  }

  @override
  String get noFileSelected => 'No file selected';

  @override
  String get searchLanguagesHint => 'Search languages...';
}
