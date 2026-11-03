// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'FillUp';

  @override
  String get vehicleName => 'Название автомобиля';

  @override
  String get tankSize => 'Объём бака';

  @override
  String get addVehicle => 'Добавить автомобиль';

  @override
  String get editVehicle => 'Изменить автомобиль';

  @override
  String get deleteVehicle => 'Удалить автомобиль';

  @override
  String get date => 'Дата';

  @override
  String get odometer => 'Счётчик';

  @override
  String get gallons => 'Галлоны';

  @override
  String get cost => 'Стоимость';

  @override
  String get fullTank => 'Полный бак';

  @override
  String get notes => 'Заметки';

  @override
  String get addRecord => 'Добавить запись';

  @override
  String get editRecord => 'Изменить запись';

  @override
  String get deleteRecord => 'Удалить запись';

  @override
  String get mileage => 'Расход топлива';

  @override
  String get mpg => 'Миля/галлон';

  @override
  String get kml => 'КМ/Л';

  @override
  String get l100km => 'Л/100КМ';

  @override
  String get ukmpg => 'UK Миля/галлон';

  @override
  String get kpg => 'КМ/галлон';

  @override
  String get settings => 'Настройки';

  @override
  String get units => 'Единицы';

  @override
  String get language => 'Язык';

  @override
  String get theme => 'Тема';

  @override
  String get light => 'Светлая';

  @override
  String get dark => 'Тёмная';

  @override
  String get system => 'Система';

  @override
  String get statistics => 'Статистика';

  @override
  String get charts => 'Диаграммы';

  @override
  String get import => 'Импорт';

  @override
  String get export => 'Экспорт';

  @override
  String get cancel => 'Отмена';

  @override
  String get save => 'Сохранить';

  @override
  String get delete => 'Удалить';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get ok => 'ОК';

  @override
  String get error => 'Ошибка';

  @override
  String get success => 'Успех';

  @override
  String get loading => 'Загрузка...';

  @override
  String get noVehicles => 'Автомобили ещё не добавлены';

  @override
  String get noRecords => 'Записей о топливе ещё нет';

  @override
  String get selectVehicle => 'Выберите автомобиль';

  @override
  String get fuelRecords => 'Записи о топливе';

  @override
  String get plot => 'График';

  @override
  String get mileagePlot => 'График расхода';

  @override
  String get odometerPlot => 'График счётчика';

  @override
  String get gallonsPlot => 'График галлонов';

  @override
  String get costPlot => 'График стоимости';

  @override
  String get pricePlot => 'График цены';

  @override
  String get startDate => 'Дата начала';

  @override
  String get endDate => 'Дата окончания';

  @override
  String get apply => 'Применить';

  @override
  String get reset => 'Сбросить';

  @override
  String get share => 'Поделиться';

  @override
  String get about => 'О программе';

  @override
  String get help => 'Справка';

  @override
  String get version => 'Версия';

  @override
  String get importExport => 'Импорт/Экспорт';

  @override
  String get pleaseEnterName => 'Введите название';

  @override
  String get pleaseEnterTankSize => 'Введите объём бака';

  @override
  String get pleaseEnterOdometer => 'Введите показания счётчика';

  @override
  String get pleaseEnterCost => 'Введите стоимость';

  @override
  String pleaseEnterFuel(String unitLabel) {
    return 'Введите $unitLabel';
  }

  @override
  String get fullTankSubtitle => 'Бак был полностью заправлен?';

  @override
  String get confirmDeleteRecord =>
      'Вы уверены, что хотите удалить эту запись?';

  @override
  String confirmDeleteVehicle(String name) {
    return 'Вы уверены, что хотите удалить $name?';
  }

  @override
  String get exportSubtitle => 'Экспорт записей в CSV-файл';

  @override
  String get importSubtitle => 'Импорт записей из CSV-файла';

  @override
  String get shareTitle => 'Поделиться';

  @override
  String get shareSubtitle => 'Поделиться CSV-файлом';

  @override
  String get exportSuccess => 'Экспорт выполнен успешно';

  @override
  String get exportFailed => 'Ошибка экспорта';

  @override
  String get noValidRecords => 'Не найдено валидных записей';

  @override
  String importedRecords(int count) {
    return 'Импортировано записей: $count';
  }

  @override
  String shareRecords(String name) {
    return 'Записи о топливе: $name';
  }

  @override
  String get currency => 'Валюта';

  @override
  String get display => 'Отображение';

  @override
  String get requireCost => 'Стоимость обязательна';

  @override
  String get requireCostSubtitle => 'При вводе покупки топлива';

  @override
  String get displayCost => 'Показывать стоимость в журнале';

  @override
  String get displayNotes => 'Показывать заметки в журнале';

  @override
  String get database => 'База данных';

  @override
  String get backupDatabase => 'Резервное копирование БД';

  @override
  String get backupDatabaseSubtitle => 'Скопировать всю базу данных в файл';

  @override
  String get restoreDatabase => 'Восстановление БД';

  @override
  String get restoreDatabaseSubtitle =>
      'Восстановить базу данных из файла резервной копии';

  @override
  String get helpSubtitle => 'Показать справку приложения';

  @override
  String get aboutSubtitle => 'Показать информацию о версии';

  @override
  String get license => 'Лицензия';

  @override
  String get licenseSubtitle => 'Показать лицензию ПО';

  @override
  String get close => 'Закрыть';

  @override
  String get summary => 'Сводка';

  @override
  String get recordsLabel => 'Записи';

  @override
  String get avg => 'Среднее';

  @override
  String get min => 'Мин';

  @override
  String get max => 'Макс';

  @override
  String get total => 'Итого';

  @override
  String get avgMonth => 'Среднее/мес';

  @override
  String perDistance(String unit) {
    return 'За $unit';
  }

  @override
  String avgPerVolume(String unit) {
    return 'Среднее/$unit';
  }

  @override
  String get distanceSection => 'Дистанция';

  @override
  String get fuelSection => 'Топливо';

  @override
  String get costSection => 'Стоимость';

  @override
  String get priceSection => 'Цена';

  @override
  String get monthlyBreakdown => 'Помесячная сводка';

  @override
  String get shareReport => 'Поделиться отчётом';

  @override
  String shareReportError(String error) {
    return 'Не удалось поделиться отчётом: $error';
  }

  @override
  String get usSection => 'США';

  @override
  String get usSubtitle => 'Мили, Галлоны';

  @override
  String get metricSection => 'Метрическая';

  @override
  String get metricSubtitle => 'Километры, Литры';

  @override
  String get ukSection => 'Великобритания';

  @override
  String get ukSubtitle => 'Мили, Имперские галлоны';

  @override
  String get mpgLabel => 'Миля/галлон (miles per gallon)';

  @override
  String get kmlLabel => 'КМ/Л (километров на литр)';

  @override
  String get l100kmLabel => 'Л/100КМ (литров на 100 км)';

  @override
  String get ukmpgLabel => 'UK Миля/галлон (miles per imperial gallon)';

  @override
  String get kpgLabel => 'КМ/галлон (километров на галлон)';

  @override
  String get edit => 'Изменить';

  @override
  String recordsLabelShort(
    int count,
    String odometer,
    String unitDistance,
    String mileage,
  ) {
    return '$count записей | $odometer $unitDistance | $mileage';
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
  String get appVersion => 'Версия приложения';

  @override
  String get buildDate => 'Дата сборки';

  @override
  String get databaseVersion => 'Версия базы данных';

  @override
  String get gasMileageLog => 'Журнал расхода топлива';

  @override
  String get selectCurrency => 'Выбрать валюту';

  @override
  String get searchCurrenciesHint => 'Поиск валют...';

  @override
  String get backupSuccess => 'Резервная копия базы данных создана';

  @override
  String backupFailed(String error) {
    return 'Ошибка копирования: $error';
  }

  @override
  String get restoreSuccess =>
      'База данных восстановлена. Перезапустите приложение.';

  @override
  String restoreFailed(String error) {
    return 'Ошибка восстановления: $error';
  }

  @override
  String get restoreConfirm =>
      'Это заменит вашу текущую базу данных резервной копией. Это действие нельзя отменить. Продолжить?';

  @override
  String get faqs => 'Часто задаваемые вопросы (FAQ)';

  @override
  String get helpQ1 => 'Почему FillUp не рассчитывает мой расход?';

  @override
  String get helpA1 =>
      'Нужно один раз заполнить бак, чтобы установить отправную точку, а затем записывать все покупки топлива. Каждый раз, когда вы заполняете бак после отправной точки, FillUp рассчитывает расход по пройденной дистанции и объёму топлива с последнего полного бака.\n\nСовет: в окне «Добавить топливо» отмечайте «Бак полный», иначе FillUp никогда не посчитает расход.';

  @override
  String get helpQ2 => 'Почему FillUp только оценивает мой расход?';

  @override
  String get helpA2 =>
      'Для точного расчёта объёма топлива с последнего полного бака нужен полный бак. Если бак при заправке не полный, FillUp не может точно рассчитать расход — он лишь оценивает его.';

  @override
  String get helpQ3 => 'Что, если я забыл записать покупку топлива?';

  @override
  String get helpA3 =>
      'При следующей заправке расчёт будет неверным (завышен). Вы можете скрыть это значение, выбрав запись в журнале и нажав «Скрыть расчёт».';

  @override
  String get helpQ4 => 'Как сделать резервную копию / восстановить данные?';

  @override
  String get helpA4 =>
      'Данные FillUp хранятся в базе данных на вашем устройстве. Используйте Экспорт для сохранения в CSV и Импорт для восстановления.';

  @override
  String get licenseText =>
      'Лицензия Apache License, Version 2.0 (\"Лицензия\"); вы не можете использовать это программное обеспечение, кроме как в соответствии с Лицензией. Скопированное можно получить по адресу:\n\nhttp://www.apache.org/licenses/LICENSE-2.0\n\nЕсли не требуется применимым законом или письменным соглашением, ПО распространяется по Лицензии на условиях \"КАК ЕСТЬ\", БЕЗ КАКИХ-ЛИБО ГАРАНТИЙ ИЛИ УСЛОВИЙ, явных или подразумеваемых. Смотрите Лицензию для прав и ограничений.';

  @override
  String get copyright =>
      'Copyright © 2013,2014 William D. Kraemer - Переписано Muhammad Bashir Al-Noimi 2026-08-31';

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
  String get fuelAmount => 'Объём топлива';

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
