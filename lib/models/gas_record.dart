import 'mileage_calculation.dart';

class GasRecord {
  static const int maxOdometer = 9999999;
  static const double maxGallons = 9999.999;
  static const double maxCost = 999999.999;
  static const double maxPrice = 999999.999;

  final int? id;
  final int? vehicleId;
  final DateTime date;
  final int odometer;
  final double gallons;
  final double cost;
  final double price;
  final String notes;
  final bool fullTank;
  final bool hidden;
  MileageCalculation? calculation;

  GasRecord({
    this.id,
    this.vehicleId,
    required this.date,
    required this.odometer,
    required this.gallons,
    required this.cost,
    this.price = 0.0,
    this.notes = '',
    this.fullTank = false,
    this.hidden = false,
    this.calculation,
  });

  bool get hasCalculation => calculation != null;

  void setCalculation(MileageCalculation? calc) {
    calculation = calc;
  }

  void setCalculationFromValues(int distance, double fuel, double mileage) {
    calculation = MileageCalculation.fromValues(
      startOdometer: odometer - distance,
      endOdometer: odometer,
      gasolineUsed: fuel,
      mileage: mileage,
    );
  }

  GasRecord copyWith({
    int? id,
    int? vehicleId,
    DateTime? date,
    int? odometer,
    double? gallons,
    double? cost,
    double? price,
    String? notes,
    bool? fullTank,
    bool? hidden,
    MileageCalculation? calculation,
  }) {
    return GasRecord(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      date: date ?? this.date,
      odometer: odometer ?? this.odometer,
      gallons: gallons ?? this.gallons,
      cost: cost ?? this.cost,
      price: price ?? this.price,
      notes: notes ?? this.notes,
      fullTank: fullTank ?? this.fullTank,
      hidden: hidden ?? this.hidden,
      calculation: calculation ?? this.calculation,
    );
  }

  factory GasRecord.fromMap(Map<String, dynamic> map) {
    return GasRecord(
      id: map['_id'] as int?,
      vehicleId: map['_vid'] as int?,
      date: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      odometer: map['odometer'] as int,
      gallons: (map['gallons'] as num).toDouble(),
      fullTank: (map['fulltank'] as int) == 1,
      hidden: (map['hidden'] as int) == 1,
      cost: (map['cost'] as num).toDouble(),
      notes: map['notes'] as String? ?? '',
      price: _calculatePrice(
        (map['cost'] as num).toDouble(),
        (map['gallons'] as num).toDouble(),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      '_vid': vehicleId,
      'time': date.millisecondsSinceEpoch,
      'odometer': odometer,
      'gallons': gallons,
      'fulltank': fullTank ? 1 : 0,
      'hidden': hidden ? 1 : 0,
      'cost': cost,
      'notes': notes,
    };
  }

  static double _calculatePrice(double cost, double gallons) {
    if (gallons != 0) {
      return cost / gallons;
    }
    return 0.0;
  }

  String toCSV() {
    final dateStr = '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    final csv = '$dateStr,$odometer,${gallons.toStringAsFixed(3)},$fullTank,$hidden,${cost.toStringAsFixed(3)},${notes.replaceAll(',', ' ').replaceAll('\n', ' ')}';
    
    if (hasCalculation) {
      return '$csv,${calculation!.getMileageString()}';
    }
    return csv;
  }

  static void validateOdometer(int value) {
    if (value < 0 || value > maxOdometer) {
      throw ArgumentError('Odometer must be between 0 and $maxOdometer');
    }
  }

  static void validateGallons(double value) {
    if (value <= 0 || value > maxGallons) {
      throw ArgumentError('Gallons must be between 0 and $maxGallons');
    }
  }

  static void validateCost(double value) {
    if (value < 0 || value > maxCost) {
      throw ArgumentError('Cost must be between 0 and $maxCost');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GasRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          vehicleId == other.vehicleId &&
          date == other.date &&
          odometer == other.odometer &&
          gallons == other.gallons &&
          cost == other.cost &&
          notes == other.notes &&
          fullTank == other.fullTank &&
          hidden == other.hidden;

  @override
  int get hashCode => Object.hash(
        id,
        vehicleId,
        date,
        odometer,
        gallons,
        cost,
        notes,
        fullTank,
        hidden,
      );
}
