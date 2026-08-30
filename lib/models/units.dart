import 'package:intl/intl.dart';
import '../utils/unit_converter.dart';

enum Units {
  mpg(0, 'MPG', 'Miles per gallon'),
  kml(1, 'KM/L', 'Kilometers per liter'),
  l100km(2, 'L/100KM', 'Liters per 100 kilometers'),
  ukmpg(3, 'UK MPG', 'UK miles per gallon'),
  kpg(4, 'KPG', 'Kilometers per gallon');

  final int value;
  final String abbreviation;
  final String description;

  const Units(this.value, this.abbreviation, this.description);

  static Units fromValue(int value) {
    return Units.values.firstWhere(
      (unit) => unit.value == value,
      orElse: () => Units.mpg,
    );
  }

  bool get isImperial => this == Units.mpg || this == Units.ukmpg || this == Units.kpg;

  bool get isMetric => !isImperial;

  String get liquidVolumeLabel => isImperial ? 'gallons' : 'liters';

  String get distanceLabel => isImperial ? 'miles' : 'kilometers';

  String get mileageLabel {
    switch (this) {
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

  String get perLiquidVolumeLabel => isImperial ? 'per gallon' : 'per liter';

  double getAverageTankSize() {
    switch (this) {
      case Units.mpg:
        return 16.0; // gallons
      case Units.kml:
        return 60.0; // liters
      case Units.l100km:
        return 60.0; // liters
      case Units.ukmpg:
        return 60.0; // liters
      case Units.kpg:
        return 60.0; // liters
    }
  }

  double calculateMileage({
    required int startOdometer,
    required int endOdometer,
    required double gallonsUsed,
  }) {
    final distance = endOdometer - startOdometer;
    if (gallonsUsed <= 0 || distance <= 0) return 0;

    final converter = UnitConverter.instance;

    switch (this) {
      case Units.mpg:
        return distance / gallonsUsed;
      case Units.kml:
        final km = converter.milesToKilometers(distance.toDouble());
        return km / gallonsUsed;
      case Units.l100km:
        final km = converter.milesToKilometers(distance.toDouble());
        final liters = converter.gallonsToLiters(gallonsUsed);
        return km > 0 ? (liters / km) * 100 : 0;
      case Units.ukmpg:
        final miles = distance.toDouble();
        final ukGallons = gallonsUsed * 1.20095;
        return miles / ukGallons;
      case Units.kpg:
        final km = converter.milesToKilometers(distance.toDouble());
        return km / gallonsUsed;
    }
  }

  String formatMileage(double mileage) {
    final formatter = NumberFormat('#,##0.00');
    return '${formatter.format(mileage)} $mileageLabel';
  }
}
