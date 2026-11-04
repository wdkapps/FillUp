import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('ru'),
    Locale('tr'),
  ];

  /// The application title
  ///
  /// In en, this message translates to:
  /// **'FillUp'**
  String get appTitle;

  /// Label for vehicle name field
  ///
  /// In en, this message translates to:
  /// **'Vehicle Name'**
  String get vehicleName;

  /// Label for tank size field
  ///
  /// In en, this message translates to:
  /// **'Tank Size'**
  String get tankSize;

  /// Button to add a new vehicle
  ///
  /// In en, this message translates to:
  /// **'Add Vehicle'**
  String get addVehicle;

  /// Button to edit vehicle
  ///
  /// In en, this message translates to:
  /// **'Edit Vehicle'**
  String get editVehicle;

  /// Button to delete vehicle
  ///
  /// In en, this message translates to:
  /// **'Delete Vehicle'**
  String get deleteVehicle;

  /// Label for date field
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// Label for odometer field
  ///
  /// In en, this message translates to:
  /// **'Odometer'**
  String get odometer;

  /// Label for gallons field
  ///
  /// In en, this message translates to:
  /// **'Gallons'**
  String get gallons;

  /// Label for cost field
  ///
  /// In en, this message translates to:
  /// **'Cost'**
  String get cost;

  /// Label for full tank checkbox
  ///
  /// In en, this message translates to:
  /// **'Full Tank'**
  String get fullTank;

  /// Label for notes field
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// Button to add fuel record
  ///
  /// In en, this message translates to:
  /// **'Add Record'**
  String get addRecord;

  /// Button to edit fuel record
  ///
  /// In en, this message translates to:
  /// **'Edit Record'**
  String get editRecord;

  /// Button to delete fuel record
  ///
  /// In en, this message translates to:
  /// **'Delete Record'**
  String get deleteRecord;

  /// Label for mileage
  ///
  /// In en, this message translates to:
  /// **'Mileage'**
  String get mileage;

  /// Miles per gallon
  ///
  /// In en, this message translates to:
  /// **'MPG'**
  String get mpg;

  /// Kilometers per liter
  ///
  /// In en, this message translates to:
  /// **'KM/L'**
  String get kml;

  /// Liters per 100 kilometers
  ///
  /// In en, this message translates to:
  /// **'L/100KM'**
  String get l100km;

  /// UK miles per gallon
  ///
  /// In en, this message translates to:
  /// **'UK MPG'**
  String get ukmpg;

  /// Kilometers per gallon
  ///
  /// In en, this message translates to:
  /// **'KPG'**
  String get kpg;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Label for units setting
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get units;

  /// Label for language setting
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Label for theme setting
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Light theme
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Dark theme
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// System theme
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// Statistics screen title
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// Charts screen title
  ///
  /// In en, this message translates to:
  /// **'Charts'**
  String get charts;

  /// Import data
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// Export data
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Save button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Delete button
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Confirm button
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Yes button
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No button
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// OK button
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Error message
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Success message
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// Loading indicator
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Message when no vehicles exist
  ///
  /// In en, this message translates to:
  /// **'No vehicles added yet'**
  String get noVehicles;

  /// Message when no fuel records exist
  ///
  /// In en, this message translates to:
  /// **'No fuel records yet'**
  String get noRecords;

  /// Prompt to select a vehicle
  ///
  /// In en, this message translates to:
  /// **'Select Vehicle'**
  String get selectVehicle;

  /// Title for fuel records list
  ///
  /// In en, this message translates to:
  /// **'Fuel Records'**
  String get fuelRecords;

  /// Plot screen title
  ///
  /// In en, this message translates to:
  /// **'Plot'**
  String get plot;

  /// Mileage chart title
  ///
  /// In en, this message translates to:
  /// **'Mileage Plot'**
  String get mileagePlot;

  /// Odometer chart title
  ///
  /// In en, this message translates to:
  /// **'Odometer Plot'**
  String get odometerPlot;

  /// Gallons chart title
  ///
  /// In en, this message translates to:
  /// **'Gallons Plot'**
  String get gallonsPlot;

  /// Cost chart title
  ///
  /// In en, this message translates to:
  /// **'Cost Plot'**
  String get costPlot;

  /// Price chart title
  ///
  /// In en, this message translates to:
  /// **'Price Plot'**
  String get pricePlot;

  /// Start date for date range
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// End date for date range
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// Apply button
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// Reset button
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// Share button
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// About screen
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Help screen
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// App version
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Import/Export screen title
  ///
  /// In en, this message translates to:
  /// **'Import/Export'**
  String get importExport;

  /// Validator: vehicle name empty
  ///
  /// In en, this message translates to:
  /// **'Please enter a name'**
  String get pleaseEnterName;

  /// Validator: tank size empty
  ///
  /// In en, this message translates to:
  /// **'Please enter tank size'**
  String get pleaseEnterTankSize;

  /// Validator: odometer empty
  ///
  /// In en, this message translates to:
  /// **'Please enter odometer'**
  String get pleaseEnterOdometer;

  /// Validator: cost empty
  ///
  /// In en, this message translates to:
  /// **'Please enter cost'**
  String get pleaseEnterCost;

  /// Validator: fuel amount empty
  ///
  /// In en, this message translates to:
  /// **'Please enter {unitLabel}'**
  String pleaseEnterFuel(String unitLabel);

  /// Full tank switch subtitle
  ///
  /// In en, this message translates to:
  /// **'Was the tank filled completely?'**
  String get fullTankSubtitle;

  /// Delete record confirmation
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this record?'**
  String get confirmDeleteRecord;

  /// Delete vehicle confirmation
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {name}?'**
  String confirmDeleteVehicle(String name);

  /// Export list tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Export fuel records to CSV file'**
  String get exportSubtitle;

  /// Import list tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Import fuel records from CSV file'**
  String get importSubtitle;

  /// Share list tile title
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareTitle;

  /// Share list tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Share CSV file'**
  String get shareSubtitle;

  /// Export success snackbar
  ///
  /// In en, this message translates to:
  /// **'Export successful'**
  String get exportSuccess;

  /// Export failure snackbar
  ///
  /// In en, this message translates to:
  /// **'Export failed'**
  String get exportFailed;

  /// Import with zero valid rows
  ///
  /// In en, this message translates to:
  /// **'No valid records found'**
  String get noValidRecords;

  /// Import success snackbar
  ///
  /// In en, this message translates to:
  /// **'Imported {count} records'**
  String importedRecords(int count);

  /// Share sheet text
  ///
  /// In en, this message translates to:
  /// **'Fuel records for {name}'**
  String shareRecords(String name);

  /// Currency section / list tile
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// Display options section
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get display;

  /// Require cost switch
  ///
  /// In en, this message translates to:
  /// **'Require Cost'**
  String get requireCost;

  /// Require cost switch subtitle
  ///
  /// In en, this message translates to:
  /// **'When entering fuel purchase'**
  String get requireCostSubtitle;

  /// Display cost switch
  ///
  /// In en, this message translates to:
  /// **'Display Cost in Log'**
  String get displayCost;

  /// Display notes switch
  ///
  /// In en, this message translates to:
  /// **'Display Notes in Log'**
  String get displayNotes;

  /// Database section
  ///
  /// In en, this message translates to:
  /// **'Database'**
  String get database;

  /// Backup database list tile
  ///
  /// In en, this message translates to:
  /// **'Backup Database'**
  String get backupDatabase;

  /// Backup database subtitle
  ///
  /// In en, this message translates to:
  /// **'Backup entire database to file'**
  String get backupDatabaseSubtitle;

  /// Restore database list tile
  ///
  /// In en, this message translates to:
  /// **'Restore Database'**
  String get restoreDatabase;

  /// Restore database subtitle
  ///
  /// In en, this message translates to:
  /// **'Restore database from backup file'**
  String get restoreDatabaseSubtitle;

  /// Help list tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Display application help information'**
  String get helpSubtitle;

  /// About list tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Display application version information'**
  String get aboutSubtitle;

  /// License list tile
  ///
  /// In en, this message translates to:
  /// **'License'**
  String get license;

  /// License list tile subtitle
  ///
  /// In en, this message translates to:
  /// **'Display the software license'**
  String get licenseSubtitle;

  /// Dialog close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Statistics summary card header
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// Statistics records row label
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get recordsLabel;

  /// Statistics avg row label
  ///
  /// In en, this message translates to:
  /// **'Avg'**
  String get avg;

  /// Statistics min row label
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get min;

  /// Statistics max row label
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get max;

  /// Statistics total row label
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Statistics per-month average
  ///
  /// In en, this message translates to:
  /// **'Avg/month'**
  String get avgMonth;

  /// Cost per distance unit
  ///
  /// In en, this message translates to:
  /// **'Per {unit}'**
  String perDistance(String unit);

  /// Average price per liquid unit
  ///
  /// In en, this message translates to:
  /// **'Avg/{unit}'**
  String avgPerVolume(String unit);

  /// Statistics distance section
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distanceSection;

  /// Statistics fuel section
  ///
  /// In en, this message translates to:
  /// **'Fuel'**
  String get fuelSection;

  /// Statistics cost section
  ///
  /// In en, this message translates to:
  /// **'Cost'**
  String get costSection;

  /// Statistics price section
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get priceSection;

  /// Statistics monthly section title
  ///
  /// In en, this message translates to:
  /// **'Monthly Breakdown'**
  String get monthlyBreakdown;

  /// Statistics share tooltip
  ///
  /// In en, this message translates to:
  /// **'Share Report'**
  String get shareReport;

  /// Share report error snackbar
  ///
  /// In en, this message translates to:
  /// **'Failed to share report: {error}'**
  String shareReportError(String error);

  /// Units section: US
  ///
  /// In en, this message translates to:
  /// **'US'**
  String get usSection;

  /// US section subtitle
  ///
  /// In en, this message translates to:
  /// **'Miles, Gallons'**
  String get usSubtitle;

  /// Units section: Metric
  ///
  /// In en, this message translates to:
  /// **'Metric'**
  String get metricSection;

  /// Metric section subtitle
  ///
  /// In en, this message translates to:
  /// **'Kilometers, Liters'**
  String get metricSubtitle;

  /// Units section: UK
  ///
  /// In en, this message translates to:
  /// **'UK'**
  String get ukSection;

  /// UK section subtitle
  ///
  /// In en, this message translates to:
  /// **'Miles, Imperial Gallons'**
  String get ukSubtitle;

  /// MPG unit option
  ///
  /// In en, this message translates to:
  /// **'MPG (miles per gallon)'**
  String get mpgLabel;

  /// KM/L unit option
  ///
  /// In en, this message translates to:
  /// **'KM/L (kilometers per liter)'**
  String get kmlLabel;

  /// L/100KM unit option
  ///
  /// In en, this message translates to:
  /// **'L/100KM (liters per 100 km)'**
  String get l100kmLabel;

  /// UK MPG unit option
  ///
  /// In en, this message translates to:
  /// **'UK MPG (miles per imperial gallon)'**
  String get ukmpgLabel;

  /// KPG unit option
  ///
  /// In en, this message translates to:
  /// **'KPG (kilometers per gallon)'**
  String get kpgLabel;

  /// Fuel volume unit label (imperial)
  ///
  /// In en, this message translates to:
  /// **'gallons'**
  String get gallonsUnit;

  /// Fuel volume unit label (metric)
  ///
  /// In en, this message translates to:
  /// **'liters'**
  String get litersUnit;

  /// Distance unit label (imperial)
  ///
  /// In en, this message translates to:
  /// **'miles'**
  String get milesUnit;

  /// Distance unit label (metric)
  ///
  /// In en, this message translates to:
  /// **'kilometers'**
  String get kilometersUnit;

  /// Edit menu item
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Vehicle list subtitle with stats
  ///
  /// In en, this message translates to:
  /// **'{count} records | {odometer} {unitDistance} | {mileage}'**
  String recordsLabelShort(
    int count,
    String odometer,
    String unitDistance,
    String mileage,
  );

  /// Vehicle list subtitle for empty vehicle
  ///
  /// In en, this message translates to:
  /// **'{tankSize} {unit}'**
  String tankSizeOnly(String tankSize, String unit);

  /// Monthly card subtitle
  ///
  /// In en, this message translates to:
  /// **'{odometer} {unitDistance} | {fuel} {unitVolume}'**
  String recordsSubtitle(
    String odometer,
    String unitDistance,
    String fuel,
    String unitVolume,
  );

  /// About row: app version
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  /// About row: build date
  ///
  /// In en, this message translates to:
  /// **'Build Date'**
  String get buildDate;

  /// About row: db version
  ///
  /// In en, this message translates to:
  /// **'Database Version'**
  String get databaseVersion;

  /// About subtitle
  ///
  /// In en, this message translates to:
  /// **'Gas Mileage Log'**
  String get gasMileageLog;

  /// Currency dialog title
  ///
  /// In en, this message translates to:
  /// **'Select Currency'**
  String get selectCurrency;

  /// Currency search hint
  ///
  /// In en, this message translates to:
  /// **'Search currencies...'**
  String get searchCurrenciesHint;

  /// Backup success snackbar
  ///
  /// In en, this message translates to:
  /// **'Database backup created successfully'**
  String get backupSuccess;

  /// Backup failure snackbar
  ///
  /// In en, this message translates to:
  /// **'Backup failed: {error}'**
  String backupFailed(String error);

  /// Restore success snackbar
  ///
  /// In en, this message translates to:
  /// **'Database restored successfully. Please restart the app.'**
  String get restoreSuccess;

  /// Restore failure snackbar
  ///
  /// In en, this message translates to:
  /// **'Restore failed: {error}'**
  String restoreFailed(String error);

  /// Restore confirmation dialog content
  ///
  /// In en, this message translates to:
  /// **'This will replace your current database with the backup. This action cannot be undone. Continue?'**
  String get restoreConfirm;

  /// Help dialog FAQ header
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions (FAQ)'**
  String get faqs;

  /// FAQ question 1
  ///
  /// In en, this message translates to:
  /// **'Why isn\'t FillUp calculating my mileage?'**
  String get helpQ1;

  /// FAQ answer 1
  ///
  /// In en, this message translates to:
  /// **'You need to fill your tank once to establish a starting point, and then continue recording all of your fuel purchases. Each time you fill your tank after the starting point, FillUp will calculate your mileage by determining the distance driven and fuel used since the previous full tank.\n\nTIP: In the Add Fuel screen, put a check mark in the \"Tank Full\" box to indicate when the tank has been filled, otherwise FillUp will never calculate mileage.'**
  String get helpA1;

  /// FAQ question 2
  ///
  /// In en, this message translates to:
  /// **'Why does FillUp only estimate my mileage?'**
  String get helpQ2;

  /// FAQ answer 2
  ///
  /// In en, this message translates to:
  /// **'A full tank is needed to accurately calculate how much fuel was used since the previous full tank. When you get fuel and the tank is not full, FillUp cannot calculate mileage exactly. Instead it will allow you to estimate mileage.'**
  String get helpA2;

  /// FAQ question 3
  ///
  /// In en, this message translates to:
  /// **'What if I forget to record a fuel purchase?'**
  String get helpQ3;

  /// FAQ answer 3
  ///
  /// In en, this message translates to:
  /// **'The next time you fill your tank, the mileage calculation will be wrong (too high). You can hide this value by selecting it in the Log and clicking \"Hide Calculation\".'**
  String get helpA3;

  /// FAQ question 4
  ///
  /// In en, this message translates to:
  /// **'How do I backup/restore my data?'**
  String get helpQ4;

  /// FAQ answer 4
  ///
  /// In en, this message translates to:
  /// **'FillUp Log data is stored in a database on your device. Use Export to save Log data to a CSV file, and Import to restore it.'**
  String get helpA4;

  /// Apache 2.0 license text
  ///
  /// In en, this message translates to:
  /// **'Licensed under the Apache License, Version 2.0 (the \"License\"); you may not use this software except in compliance with the License. You may obtain a copy of the License at:\n\nhttp://www.apache.org/licenses/LICENSE-2.0\n\nUnless required by applicable law or agreed to in writing, software distributed under the License is distributed on an \"AS IS\" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.\n\nUse of this software constitutes acceptance of this license.'**
  String get licenseText;

  /// Copyright line
  ///
  /// In en, this message translates to:
  /// **'Copyright © 2013,2014 William D. Kraemer - Rewritten by Muhammad Bashir Al-Noimi on 2026-08-31'**
  String get copyright;

  /// Share sheet text for statistics report
  ///
  /// In en, this message translates to:
  /// **'Statistics for {name}'**
  String shareStatistics(String name);

  /// Monthly card subtitle: distance | fuel
  ///
  /// In en, this message translates to:
  /// **'{odometer} {unitDistance} | {fuel} {unitVolume}'**
  String recordsSummary(
    String odometer,
    String unitDistance,
    String fuel,
    String unitVolume,
  );

  /// Statistics summary header
  ///
  /// In en, this message translates to:
  /// **'All data'**
  String get allData;

  /// Statistics summary date range label
  ///
  /// In en, this message translates to:
  /// **'Date Range'**
  String get dateRange;

  /// Plural month count
  ///
  /// In en, this message translates to:
  /// **'months'**
  String get months;

  /// Fuel economy label with metric
  ///
  /// In en, this message translates to:
  /// **'Fuel Economy ({metric})'**
  String fuelEconomy(String metric);

  /// Distance driven label
  ///
  /// In en, this message translates to:
  /// **'Distance Driven'**
  String get distanceDriven;

  /// Fuel purchased label
  ///
  /// In en, this message translates to:
  /// **'Fuel Purchased'**
  String get fuelPurchased;

  /// Fuel cost label
  ///
  /// In en, this message translates to:
  /// **'Fuel Cost'**
  String get fuelCost;

  /// Fuel price label
  ///
  /// In en, this message translates to:
  /// **'Fuel Price (avg)'**
  String get fuelPrice;

  /// Per month suffix
  ///
  /// In en, this message translates to:
  /// **'per month'**
  String get perMonth;

  /// Per unit suffix
  ///
  /// In en, this message translates to:
  /// **'per {unit}'**
  String per(String unit);

  /// Gallons field label (unit-aware via liquidVolumeLabel)
  ///
  /// In en, this message translates to:
  /// **'Fuel Amount'**
  String get fuelAmount;

  /// Record list subtitle: odometer | fuel | mileage
  ///
  /// In en, this message translates to:
  /// **'{odometer} {unitDistance} | {fuel} {unitVolume}{mileagePart}'**
  String recordSummary(
    String odometer,
    String unitDistance,
    String fuel,
    String unitVolume,
    String mileagePart,
  );

  /// Mileage unit label with short unit code
  ///
  /// In en, this message translates to:
  /// **'Mileage ({unit})'**
  String mileageUnitLabel(String unit);

  /// File picker returned no file
  ///
  /// In en, this message translates to:
  /// **'No file selected'**
  String get noFileSelected;

  /// No description provided for @searchLanguagesHint.
  ///
  /// In en, this message translates to:
  /// **'Search languages...'**
  String get searchLanguagesHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'pt',
    'ru',
    'tr',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
