import '../models/units.dart';
import '../l10n/generated/app_localizations.dart';

class MileageCalculator {
  static const double imperialGallonsPerLiter = 0.219969;
  static const double milesPerKilometer = 0.621371;

  /// Calculates mileage matching the Java version exactly.
  /// Data is always stored in the user's current unit system:
  /// - MPG/KPG: fuel in gallons, distance in miles
  /// - KM/L/L100KM/UKMPG: fuel in liters, distance in kilometers
  static double calculate({
    required int startOdometer,
    required int endOdometer,
    required double gallonsUsed,
    required Units units,
  }) {
    final distance = endOdometer - startOdometer;

    if (gallonsUsed <= 0 || distance <= 0) {
      return 0;
    }

    switch (units) {
      case Units.mpg:
      case Units.kml:
      case Units.kpg:
        // distance per unit fuel, no conversion needed
        return distance / gallonsUsed;
      case Units.l100km:
        // fuel per 100 distance, no conversion needed
        return (gallonsUsed * 100) / distance;
      case Units.ukmpg:
        // UK MPG: data in km + liters, convert both to miles + imperial gallons
        final miles = distance * milesPerKilometer;
        final imperialGallons = gallonsUsed * imperialGallonsPerLiter;
        return miles / imperialGallons;
    }
  }

  static String getMileageLabel(Units unit) {
    switch (unit) {
      case Units.mpg:
        return 'MPG';
      case Units.kml:
        return 'KM/L';
      case Units.l100km:
        return 'L/100KM';
      case Units.ukmpg:
        return 'UK MPG';
      case Units.kpg:
        return 'KPG';
    }
  }

  static String getUnitLabel(Units unit, AppLocalizations l10n) {
    switch (unit) {
      case Units.mpg:
        return l10n.mpgLabel;
      case Units.kml:
        return l10n.kmlLabel;
      case Units.l100km:
        return l10n.l100kmLabel;
      case Units.ukmpg:
        return l10n.ukmpgLabel;
      case Units.kpg:
        return l10n.kpgLabel;
    }
  }

  static String formatMileage(double mileage, Units unit, AppLocalizations l10n) {
    return '${mileage.toStringAsFixed(2)} ${getMileageLabel(unit)}';
  }
}
