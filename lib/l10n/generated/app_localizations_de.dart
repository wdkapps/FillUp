// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'FillUp';

  @override
  String get vehicleName => 'Fahrzeugname';

  @override
  String get tankSize => 'Tankgröße';

  @override
  String get addVehicle => 'Fahrzeug hinzufügen';

  @override
  String get editVehicle => 'Fahrzeug bearbeiten';

  @override
  String get deleteVehicle => 'Fahrzeug löschen';

  @override
  String get date => 'Datum';

  @override
  String get odometer => 'Tacho';

  @override
  String get gallons => 'Gallonen';

  @override
  String get cost => 'Kosten';

  @override
  String get fullTank => 'Voller Tank';

  @override
  String get notes => 'Notizen';

  @override
  String get addRecord => 'Eintrag hinzufügen';

  @override
  String get editRecord => 'Eintrag bearbeiten';

  @override
  String get deleteRecord => 'Eintrag löschen';

  @override
  String get mileage => 'Verbrauch';

  @override
  String get mpg => 'Meilen/Gal';

  @override
  String get kml => 'KM/L';

  @override
  String get l100km => 'L/100KM';

  @override
  String get ukmpg => 'UK Meilen/Gal';

  @override
  String get kpg => 'KM/Gal';

  @override
  String get settings => 'Einstellungen';

  @override
  String get units => 'Einheiten';

  @override
  String get language => 'Sprache';

  @override
  String get theme => 'Design';

  @override
  String get light => 'Hell';

  @override
  String get dark => 'Dunkel';

  @override
  String get system => 'System';

  @override
  String get statistics => 'Statistiken';

  @override
  String get charts => 'Diagramme';

  @override
  String get import => 'Importieren';

  @override
  String get export => 'Exportieren';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get save => 'Speichern';

  @override
  String get delete => 'Löschen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nein';

  @override
  String get ok => 'OK';

  @override
  String get error => 'Fehler';

  @override
  String get success => 'Erfolg';

  @override
  String get loading => 'Wird geladen...';

  @override
  String get noVehicles => 'Noch keine Fahrzeuge hinzugefügt';

  @override
  String get noRecords => 'Noch keine Kraftstoffeinträge';

  @override
  String get selectVehicle => 'Fahrzeug auswählen';

  @override
  String get fuelRecords => 'Kraftstoffeinträge';

  @override
  String get plot => 'Diagramm';

  @override
  String get mileagePlot => 'Verbrauchsdiagramm';

  @override
  String get odometerPlot => 'Tacho-Diagramm';

  @override
  String get gallonsPlot => 'Gallonen-Diagramm';

  @override
  String get costPlot => 'Kosten-Diagramm';

  @override
  String get pricePlot => 'Preis-Diagramm';

  @override
  String get startDate => 'Startdatum';

  @override
  String get endDate => 'Enddatum';

  @override
  String get apply => 'Anwenden';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get share => 'Teilen';

  @override
  String get about => 'Über';

  @override
  String get help => 'Hilfe';

  @override
  String get version => 'Version';

  @override
  String get importExport => 'Import/Export';

  @override
  String get pleaseEnterName => 'Bitte einen Namen eingeben';

  @override
  String get pleaseEnterTankSize => 'Bitte die Tankgröße eingeben';

  @override
  String get pleaseEnterOdometer => 'Bitte den Tacho eingeben';

  @override
  String get pleaseEnterCost => 'Bitte die Kosten eingeben';

  @override
  String pleaseEnterFuel(String unitLabel) {
    return 'Bitte $unitLabel eingeben';
  }

  @override
  String get fullTankSubtitle => 'War der Tank vollständig gefüllt?';

  @override
  String get confirmDeleteRecord =>
      'Möchten Sie diesen Eintrag wirklich löschen?';

  @override
  String confirmDeleteVehicle(String name) {
    return 'Möchten Sie $name wirklich löschen?';
  }

  @override
  String get exportSubtitle => 'Kraftstoffeinträge als CSV-Datei exportieren';

  @override
  String get importSubtitle => 'Kraftstoffeinträge aus CSV-Datei importieren';

  @override
  String get shareTitle => 'Teilen';

  @override
  String get shareSubtitle => 'CSV-Datei teilen';

  @override
  String get exportSuccess => 'Export erfolgreich';

  @override
  String get exportFailed => 'Export fehlgeschlagen';

  @override
  String get noValidRecords => 'Keine gültigen Einträge gefunden';

  @override
  String importedRecords(int count) {
    return '$count Einträge importiert';
  }

  @override
  String shareRecords(String name) {
    return 'Kraftstoffeinträge für $name';
  }

  @override
  String get currency => 'Währung';

  @override
  String get display => 'Anzeige';

  @override
  String get requireCost => 'Kosten erforderlich';

  @override
  String get requireCostSubtitle => 'Beim Erfassen des Kraftstoffeinkaufs';

  @override
  String get displayCost => 'Kosten in der Liste anzeigen';

  @override
  String get displayNotes => 'Notizen in der Liste anzeigen';

  @override
  String get database => 'Datenbank';

  @override
  String get backupDatabase => 'Datenbank sichern';

  @override
  String get backupDatabaseSubtitle =>
      'Gesamte Datenbank in eine Datei sichern';

  @override
  String get restoreDatabase => 'Datenbank wiederherstellen';

  @override
  String get restoreDatabaseSubtitle =>
      'Datenbank aus Sicherungsdatei wiederherstellen';

  @override
  String get helpSubtitle => 'Anwendungshilfe anzeigen';

  @override
  String get aboutSubtitle => 'Versionsinformationen anzeigen';

  @override
  String get license => 'Lizenz';

  @override
  String get licenseSubtitle => 'Die Softwaredlizenz anzeigen';

  @override
  String get close => 'Schließen';

  @override
  String get summary => 'Zusammenfassung';

  @override
  String get recordsLabel => 'Einträge';

  @override
  String get avg => 'Ø';

  @override
  String get min => 'Min';

  @override
  String get max => 'Max';

  @override
  String get total => 'Gesamt';

  @override
  String get avgMonth => 'Ø/Monat';

  @override
  String perDistance(String unit) {
    return 'Pro $unit';
  }

  @override
  String avgPerVolume(String unit) {
    return 'Ø/$unit';
  }

  @override
  String get distanceSection => 'Distanz';

  @override
  String get fuelSection => 'Kraftstoff';

  @override
  String get costSection => 'Kosten';

  @override
  String get priceSection => 'Preis';

  @override
  String get monthlyBreakdown => 'Monatliche Aufschlüsselung';

  @override
  String get shareReport => 'Bericht teilen';

  @override
  String shareReportError(String error) {
    return 'Bericht konnte nicht geteilt werden: $error';
  }

  @override
  String get usSection => 'US';

  @override
  String get usSubtitle => 'Meilen, Gallonen';

  @override
  String get metricSection => 'Metrisch';

  @override
  String get metricSubtitle => 'Kilometer, Liter';

  @override
  String get ukSection => 'UK';

  @override
  String get ukSubtitle => 'Meilen, Imperialgallonen';

  @override
  String get mpgLabel => 'MPG (Meilen pro Gallone)';

  @override
  String get kmlLabel => 'KM/L (Kilometer pro Liter)';

  @override
  String get l100kmLabel => 'L/100KM (Liter pro 100 km)';

  @override
  String get ukmpgLabel => 'UK MPG (Meilen pro Imperialgallone)';

  @override
  String get kpgLabel => 'KPG (Kilometer pro Gallone)';

  @override
  String get edit => 'Bearbeiten';

  @override
  String recordsLabelShort(
    int count,
    String odometer,
    String unitDistance,
    String mileage,
  ) {
    return '$count Einträge | $odometer $unitDistance | $mileage';
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
  String get appVersion => 'App-Version';

  @override
  String get buildDate => 'Builddatum';

  @override
  String get databaseVersion => 'Datenbankversion';

  @override
  String get gasMileageLog => 'Kraftstoffverbrauchstagebuch';

  @override
  String get selectCurrency => 'Währung auswählen';

  @override
  String get searchCurrenciesHint => 'Währungen durchsuchen...';

  @override
  String get backupSuccess => 'Datenbanksicherung erfolgreich erstellt';

  @override
  String backupFailed(String error) {
    return 'Sicherung fehlgeschlagen: $error';
  }

  @override
  String get restoreSuccess =>
      'Datenbank erfolgreich wiederhergestellt. Bitte die App neu starten.';

  @override
  String restoreFailed(String error) {
    return 'Wiederherstellung fehlgeschlagen: $error';
  }

  @override
  String get restoreConfirm =>
      'Dadurch wird Ihre aktuelle Datenbank durch die Sicherung ersetzt. Dies kann nicht rückgängig gemacht werden. Fortfahren?';

  @override
  String get faqs => 'Häufig gestellte Fragen (FAQ)';

  @override
  String get helpQ1 => 'Warum berechnet FillUp meinen Verbrauch nicht?';

  @override
  String get helpA1 =>
      'Sie müssen einmal den Tank füllen, um einen Ausgangspunkt zu setzen, und dann alle Kraftstoffeinkäufe dokumentieren. Jedes Mal, wenn Sie danach den Tank füllen, berechnet FillUp Ihren Verbrauch anhand der gefahrenen Distanz und des verbrauchten Kraftstoffs.\n\nTIPP: Häkchen Sie im Bildscherm \"Kraftstoff hinzufügen\" das Feld \"Tank voll\" an, andernfalls berechnet FillUp nie den Verbrauch.';

  @override
  String get helpQ2 => 'Warum schätzt FillUp meinen Verbrauch nur?';

  @override
  String get helpA2 =>
      'Ein voller Tank ist nötig, um exakt zu berechnen, wie viel Kraftstoff seit dem letzten vollen Tank verbraucht wurde. Wenn der Tank beim Tanken nicht voll ist, kann FillUp den Verbrauch nur schätzen.';

  @override
  String get helpQ3 =>
      'Was tun, wenn ich einen Kraftstoffeinkauf vergessen habe?';

  @override
  String get helpA3 =>
      'Beim nächsten Tanken wird der Verbrauch falsch (zu hoch) berechnet. Sie können diesen Wert in der Liste ausblenden, indem Sie ihn auswählen und \"Berechnung ausblenden\" klicken.';

  @override
  String get helpQ4 => 'Wie sichere/wiederherstelle ich meine Daten?';

  @override
  String get helpA4 =>
      'Die FillUp-Daten werden in einer Datenbank auf Ihrem Gerät gespeichert. Verwenden Sie Exportieren, um die Daten als CSV zu sichern, und Importieren, um sie wiederherzustellen.';

  @override
  String get licenseText =>
      'Lizenziert unter der Apache License, Version 2.0 (die \"License\"); Sie dürfen diese Software nicht außer in Übereinstimmung mit der License verwenden. Sie können eine Kopie der License erhalten unter:\n\nhttp://www.apache.org/licenses/LICENSE-2.0\n\nSofern nicht durch geltendes Gesetz oder schriftliche Vereinbarung vorgeschrieben, wird die Software unter der License auf \"AS IS\"-BASIS LIEFERT, OHNE GARANTIE ODER BEDINGUNG IHRDER ART, EXPRESS ODER IMPLIZIT. Siehe die License für die speziellen Sprache, die Sie für Berechtigungen und Beschränkungen verwenden.';

  @override
  String get copyright =>
      'Copyright © 2013,2014 William D. Kraemer - Neu geschrieben von Muhammad Bashir Al-Noimi am 2026-08-31';

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
  String get fuelAmount => 'Menge Kraftstoff';

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
}
