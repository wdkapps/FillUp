import 'package:units_converter/units_converter.dart';

class UnitConverter {
  static final UnitConverter _instance = UnitConverter._();
  static UnitConverter get instance => _instance;

  UnitConverter._();

  double gallonsToLiters(double gallons) {
    final volume = Volume()..convert(VOLUME.usGallons, gallons);
    return volume.liters.value ?? 0;
  }

  double litersToGallons(double liters) {
    final volume = Volume()..convert(VOLUME.liters, liters);
    return volume.usGallons.value ?? 0;
  }

  double milesToKilometers(double miles) {
    final length = Length()..convert(LENGTH.miles, miles);
    return length.kilometers.value ?? 0;
  }

  double kilometersToMiles(double km) {
    final length = Length()..convert(LENGTH.kilometers, km);
    return length.miles.value ?? 0;
  }
}
