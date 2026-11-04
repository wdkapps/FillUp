class Vehicle {
  static const int minLength = 1;
  static const int maxLength = 20;
  static final RegExp validNameRegex = RegExp(r'^[a-zA-Z0-9][a-zA-Z0-9- ]*$');

  final int? id;
  final String name;
  final double tankSize;

  const Vehicle({
    this.id,
    required this.name,
    required this.tankSize,
  });

  Vehicle copyWith({
    int? id,
    String? name,
    double? tankSize,
  }) {
    return Vehicle(
      id: id ?? this.id,
      name: name ?? this.name,
      tankSize: tankSize ?? this.tankSize,
    );
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['_id'] as int?,
      name: map['name'] as String,
      tankSize: (map['tanksize'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'tanksize': tankSize,
    };
  }

  static void validateName(String name) {
    if (name.isEmpty) {
      throw ArgumentError('Name cannot be empty');
    }
    if (name.length < minLength || name.length > maxLength) {
      throw ArgumentError('Name must be between $minLength and $maxLength characters');
    }
    if (!validNameRegex.hasMatch(name)) {
      throw ArgumentError('Invalid name format');
    }
  }

  static void validateTankSize(double value) {
    if (value < 1.0 || value > 1000.0) {
      throw ArgumentError('Tank size must be between 1.0 and 1000.0');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Vehicle &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          tankSize == other.tankSize;

  @override
  int get hashCode => Object.hash(id, name, tankSize);

  @override
  String toString() => name;
}
