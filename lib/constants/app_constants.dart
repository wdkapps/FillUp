class AppConstants {
  static const String dbName = 'gaslog.db';
  static const int dbVersion = 5;
  
  // Storage keys
  static const String keyVehicleId = 'vehicle_id';
  static const String keyUnit = 'unit';
  static const String keyCurrency = 'currency';
  static const String keyLanguage = 'language';
  static const String keyTheme = 'theme';
  static const String keyRequireCost = 'require_cost';
  static const String keyDisplayCost = 'display_cost';
  static const String keyDisplayNotes = 'display_notes';
  
  // Default values
  static const int defaultUnit = 0;
  static const String defaultCurrency = 'USD';
  static const String defaultLanguage = 'en';
}
