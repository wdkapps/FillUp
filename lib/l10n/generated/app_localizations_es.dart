// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'FillUp';

  @override
  String get vehicleName => 'Nombre del vehículo';

  @override
  String get tankSize => 'Capacidad del tanque';

  @override
  String get addVehicle => 'Agregar vehículo';

  @override
  String get editVehicle => 'Editar vehículo';

  @override
  String get deleteVehicle => 'Eliminar vehículo';

  @override
  String get date => 'Fecha';

  @override
  String get odometer => 'Kilometraje';

  @override
  String get gallons => 'Galones';

  @override
  String get cost => 'Costo';

  @override
  String get fullTank => 'Tanque lleno';

  @override
  String get notes => 'Notas';

  @override
  String get addRecord => 'Agregar registro';

  @override
  String get editRecord => 'Editar registro';

  @override
  String get deleteRecord => 'Eliminar registro';

  @override
  String get mileage => 'Rendimiento';

  @override
  String get mpg => 'MPG (mi/gal)';

  @override
  String get kml => 'KM/L';

  @override
  String get l100km => 'L/100KM';

  @override
  String get ukmpg => 'UK MPG';

  @override
  String get kpg => 'KPG (km/gal)';

  @override
  String get settings => 'Configuración';

  @override
  String get units => 'Unidades';

  @override
  String get language => 'Idioma';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get system => 'Sistema';

  @override
  String get statistics => 'Estadísticas';

  @override
  String get charts => 'Gráficos';

  @override
  String get import => 'Importar';

  @override
  String get export => 'Exportar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get ok => 'Aceptar';

  @override
  String get error => 'Error';

  @override
  String get success => 'Éxito';

  @override
  String get loading => 'Cargando...';

  @override
  String get noVehicles => 'Aún no hay vehículos';

  @override
  String get noRecords => 'Aún no hay registros de combustible';

  @override
  String get selectVehicle => 'Seleccionar vehículo';

  @override
  String get fuelRecords => 'Registros de combustible';

  @override
  String get plot => 'Gráfico';

  @override
  String get mileagePlot => 'Gráfico de rendimiento';

  @override
  String get odometerPlot => 'Gráfico de odómetro';

  @override
  String get gallonsPlot => 'Gráfico de galones';

  @override
  String get costPlot => 'Gráfico de costo';

  @override
  String get pricePlot => 'Gráfico de precio';

  @override
  String get startDate => 'Fecha de inicio';

  @override
  String get endDate => 'Fecha de fin';

  @override
  String get apply => 'Aplicar';

  @override
  String get reset => 'Reiniciar';

  @override
  String get share => 'Compartir';

  @override
  String get about => 'Acerca de';

  @override
  String get help => 'Ayuda';

  @override
  String get version => 'Versión';

  @override
  String get importExport => 'Importar/Exportar';

  @override
  String get pleaseEnterName => 'Ingrese un nombre';

  @override
  String get pleaseEnterTankSize => 'Ingrese la capacidad del tanque';

  @override
  String get pleaseEnterOdometer => 'Ingrese el kilometraje';

  @override
  String get pleaseEnterCost => 'Ingrese el costo';

  @override
  String pleaseEnterFuel(String unitLabel) {
    return 'Ingrese $unitLabel';
  }

  @override
  String get fullTankSubtitle => '¿Se llenó el tanque por completo?';

  @override
  String get confirmDeleteRecord =>
      '¿Está seguro de que desea eliminar este registro?';

  @override
  String confirmDeleteVehicle(String name) {
    return '¿Está seguro de que desea eliminar $name?';
  }

  @override
  String get exportSubtitle => 'Exportar registros a archivo CSV';

  @override
  String get importSubtitle => 'Importar registros desde archivo CSV';

  @override
  String get shareTitle => 'Compartir';

  @override
  String get shareSubtitle => 'Compartir archivo CSV';

  @override
  String get exportSuccess => 'Exportación exitosa';

  @override
  String get exportFailed => 'Falló la exportación';

  @override
  String get noValidRecords => 'No se encontraron registros válidos';

  @override
  String importedRecords(int count) {
    return 'Se importaron $count registros';
  }

  @override
  String shareRecords(String name) {
    return 'Registros de combustible de $name';
  }

  @override
  String get currency => 'Moneda';

  @override
  String get display => 'Visualización';

  @override
  String get requireCost => 'Costo obligatorio';

  @override
  String get requireCostSubtitle => 'Al registrar la compra de combustible';

  @override
  String get displayCost => 'Mostrar costo en el registro';

  @override
  String get displayNotes => 'Mostrar notas en el registro';

  @override
  String get database => 'Base de datos';

  @override
  String get backupDatabase => 'Respaldo de base de datos';

  @override
  String get backupDatabaseSubtitle =>
      'Respalde toda la base de datos en un archivo';

  @override
  String get restoreDatabase => 'Restaurar base de datos';

  @override
  String get restoreDatabaseSubtitle =>
      'Restaurar la base de datos desde un archivo de respaldo';

  @override
  String get helpSubtitle => 'Mostrar información de ayuda de la aplicación';

  @override
  String get aboutSubtitle => 'Mostrar información de versión de la aplicación';

  @override
  String get license => 'Licencia';

  @override
  String get licenseSubtitle => 'Mostrar la licencia del software';

  @override
  String get close => 'Cerrar';

  @override
  String get summary => 'Resumen';

  @override
  String get recordsLabel => 'Registros';

  @override
  String get avg => 'Prom';

  @override
  String get min => 'Mín';

  @override
  String get max => 'Máx';

  @override
  String get total => 'Total';

  @override
  String get avgMonth => 'Prom/mes';

  @override
  String perDistance(String unit) {
    return 'Por $unit';
  }

  @override
  String avgPerVolume(String unit) {
    return 'Prom/$unit';
  }

  @override
  String get distanceSection => 'Distancia';

  @override
  String get fuelSection => 'Combustible';

  @override
  String get costSection => 'Costo';

  @override
  String get priceSection => 'Precio';

  @override
  String get monthlyBreakdown => 'Desglose mensual';

  @override
  String get shareReport => 'Compartir informe';

  @override
  String shareReportError(String error) {
    return 'No se pudo compartir el informe: $error';
  }

  @override
  String get usSection => 'EE.UU.';

  @override
  String get usSubtitle => 'Millas, Galones';

  @override
  String get metricSection => 'Métrico';

  @override
  String get metricSubtitle => 'Kilómetros, Litros';

  @override
  String get ukSection => 'Reino Unido';

  @override
  String get ukSubtitle => 'Millas, Galones imperiales';

  @override
  String get mpgLabel => 'MPG (millas por galón)';

  @override
  String get kmlLabel => 'KM/L (kilómetros por litro)';

  @override
  String get l100kmLabel => 'L/100KM (litros por 100 km)';

  @override
  String get ukmpgLabel => 'UK MPG (millas por galón imperial)';

  @override
  String get kpgLabel => 'KPG (kilómetros por galón)';

  @override
  String get edit => 'Editar';

  @override
  String recordsLabelShort(
    int count,
    String odometer,
    String unitDistance,
    String mileage,
  ) {
    return '$count registros | $odometer $unitDistance | $mileage';
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
  String get appVersion => 'Versión de la aplicación';

  @override
  String get buildDate => 'Fecha de compilación';

  @override
  String get databaseVersion => 'Versión de base de datos';

  @override
  String get gasMileageLog => 'Registro de rendimiento de combustible';

  @override
  String get selectCurrency => 'Seleccionar moneda';

  @override
  String get searchCurrenciesHint => 'Buscar monedas...';

  @override
  String get backupSuccess => 'Respaldo de base de datos creado con éxito';

  @override
  String backupFailed(String error) {
    return 'Falló el respaldo: $error';
  }

  @override
  String get restoreSuccess =>
      'Base de datos restaurada. Por favor reinicie la aplicación.';

  @override
  String restoreFailed(String error) {
    return 'Falló la restauración: $error';
  }

  @override
  String get restoreConfirm =>
      'Esto reemplazará su base de datos actual con el respaldo. Esta acción no se puede deshacer. ¿Continuar?';

  @override
  String get faqs => 'Preguntas frecuentes (FAQ)';

  @override
  String get helpQ1 => '¿Por qué FillUp no calcula mi rendimiento?';

  @override
  String get helpA1 =>
      'Debe llenar el tanque una vez para establecer un punto de partida y luego registrar todas sus compras de combustible. Cada vez que llene el tanque después del punto de partida, FillUp calculará su rendimiento determinando la distancia recorrida y el combustible usado desde la última carga completa.\n\nCONSEJO: En la pantalla \"Agregar combustible\", marque la casilla \"Tanque lleno\" para indicar cuando el tanque ha sido llenado; de lo contrario, FillUp nunca calculará el rendimiento.';

  @override
  String get helpQ2 => '¿Por qué FillUp solo estima mi rendimiento?';

  @override
  String get helpA2 =>
      'Se necesita un tanque lleno para calcular con precisión cuánto combustible se usó desde la última carga completa. Si el tanque no está lleno al recargar, FillUp no puede calcular el rendimiento exacto y lo estima en su lugar.';

  @override
  String get helpQ3 =>
      '¿Qué hago si olvido registrar una compra de combustible?';

  @override
  String get helpA3 =>
      'La próxima vez que llene el tanque, el cálculo de rendimiento será incorrecto (demasiado alto). Puede ocultar este valor seleccionándolo en el registro y haciendo clic en \"Ocultar cálculo\".';

  @override
  String get helpQ4 => '¿Cómo respaldo/restauro mis datos?';

  @override
  String get helpA4 =>
      'Los datos de FillUp se almacenan en una base de datos en su dispositivo. Use Exportar para guardar los datos en un archivo CSV e Importar para restaurarlos.';

  @override
  String get licenseText =>
      'Licenciado bajo la Licencia Apache, Versión 2.0 (la \"Licencia\"); no puede usar este software salvo en cumplimiento de la Licencia. Puede obtener una copia de la Licencia en:\n\nhttp://www.apache.org/licenses/LICENSE-2.0\n\nSalvo lo requerido por la ley aplicable o un acuerdo por escrito, el software se distribuye bajo la Licencia en una base \"CUAL ESTÉ\", SIN GARANTÍAS O CONDICIONES DE CUALQUIER TIPO, ya sean expresas o implícitas. Consulte la Licencia para los términos que rigen permisos y limitaciones.';

  @override
  String get copyright =>
      'Copyright © 2013,2014 William D. Kraemer - Reescrito por Muhammad Bashir Al-Noimi el 2026-08-31';

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
  String get fuelAmount => 'Cantidad de combustible';

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
