import 'gas_record.dart';
import 'units.dart';

class MileageCalculation {
  static const double imperialGallonsPerLiter = 0.219969;
  static const double milesPerKilometer = 0.621371;

  final int startOdometer;
  int endOdometer;
  double gasolineUsed;
  final Units units;

  MileageCalculation({
    required this.startOdometer,
    required this.endOdometer,
    required this.gasolineUsed,
    required this.units,
  });

  factory MileageCalculation.fromRecord(GasRecord startRecord, Units units) {
    return MileageCalculation(
      startOdometer: startRecord.odometer,
      endOdometer: startRecord.odometer,
      gasolineUsed: 0,
      units: units,
    );
  }

  factory MileageCalculation.fromValues({
    required int startOdometer,
    required int endOdometer,
    required double gasolineUsed,
    required double mileage,
  }) {
    return _CachedMileageCalculation(
      startOdometer: startOdometer,
      endOdometer: endOdometer,
      gasolineUsed: gasolineUsed,
      cachedMileage: mileage,
    );
  }

  void add(GasRecord record) {
    endOdometer = record.odometer;
    gasolineUsed += record.gallons;
  }

  int get distanceDriven => endOdometer - startOdometer;

  double getMileage() {
    if (gasolineUsed <= 0 || distanceDriven <= 0) {
      return 0;
    }

    switch (units) {
      case Units.mpg:
      case Units.kml:
      case Units.kpg:
        return distanceDriven / gasolineUsed;
      case Units.l100km:
        return (gasolineUsed * 100) / distanceDriven;
      case Units.ukmpg:
        // UK MPG: odometer in km, fuel in liters → convert both
        final miles = distanceDriven * milesPerKilometer;
        final imperialGallons = gasolineUsed * imperialGallonsPerLiter;
        return miles / imperialGallons;
    }
  }

  String getMileageString() {
    return getMileage().toStringAsFixed(3);
  }
}

class _CachedMileageCalculation extends MileageCalculation {
  final double _cachedMileage;

  _CachedMileageCalculation({
    required int startOdometer,
    required int endOdometer,
    required double gasolineUsed,
    required double cachedMileage,
  })  : _cachedMileage = cachedMileage,
        super(
          startOdometer: startOdometer,
          endOdometer: endOdometer,
          gasolineUsed: gasolineUsed,
          units: Units.mpg,
        );

  @override
  double getMileage() => _cachedMileage;

  @override
  String getMileageString() => _cachedMileage.toStringAsFixed(2);
}
