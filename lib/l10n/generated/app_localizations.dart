import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('en'),
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
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
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
