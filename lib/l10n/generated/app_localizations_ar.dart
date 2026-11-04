// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'FillUp';

  @override
  String get vehicleName => 'اسم المركبة';

  @override
  String get tankSize => 'حجم الخزان';

  @override
  String get addVehicle => 'إضافة مركبة';

  @override
  String get editVehicle => 'تعديل المركبة';

  @override
  String get deleteVehicle => 'حذف المركبة';

  @override
  String get date => 'التاريخ';

  @override
  String get odometer => 'عداد المسافة';

  @override
  String get gallons => 'جالون';

  @override
  String get cost => 'التكلفة';

  @override
  String get fullTank => 'خزان كامل';

  @override
  String get notes => 'ملاحظات';

  @override
  String get addRecord => 'إضافة سجل';

  @override
  String get editRecord => 'تعديل السجل';

  @override
  String get deleteRecord => 'حذف السجل';

  @override
  String get mileage => 'المسافة';

  @override
  String get mpg => 'ميل لكل جالون';

  @override
  String get kml => 'كم لكل لتر';

  @override
  String get l100km => 'لتر لكل 100 كم';

  @override
  String get ukmpg => 'ميل بريطاني لكل جالون';

  @override
  String get kpg => 'كم لكل جالون';

  @override
  String get settings => 'الإعدادات';

  @override
  String get units => 'الوحدات';

  @override
  String get language => 'اللغة';

  @override
  String get theme => 'المظهر';

  @override
  String get light => 'فاتح';

  @override
  String get dark => 'داكن';

  @override
  String get system => 'النظام';

  @override
  String get statistics => 'الإحصائيات';

  @override
  String get charts => 'الرسوم البيانية';

  @override
  String get import => 'استيراد';

  @override
  String get export => 'تصدير';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get delete => 'حذف';

  @override
  String get confirm => 'تأكيد';

  @override
  String get yes => 'نعم';

  @override
  String get no => 'لا';

  @override
  String get ok => 'موافق';

  @override
  String get error => 'خطأ';

  @override
  String get success => 'نجاح';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get noVehicles => 'لم تتم إضافة أي مركبات بعد';

  @override
  String get noRecords => 'لا توجد سجلات وقود بعد';

  @override
  String get selectVehicle => 'اختر المركبة';

  @override
  String get fuelRecords => 'سجلات الوقود';

  @override
  String get plot => 'رسم بياني';

  @override
  String get mileagePlot => 'رسم بياني للمسافة';

  @override
  String get odometerPlot => 'رسم بياني لعداد المسافة';

  @override
  String get gallonsPlot => 'رسم بياني للجالون';

  @override
  String get costPlot => 'رسم بياني للتكلفة';

  @override
  String get pricePlot => 'رسم بياني للسعر';

  @override
  String get startDate => 'تاريخ البداية';

  @override
  String get endDate => 'تاريخ النهاية';

  @override
  String get apply => 'تطبيق';

  @override
  String get reset => 'إعادة تعيين';

  @override
  String get share => 'مشاركة';

  @override
  String get about => 'حول';

  @override
  String get help => 'مساعدة';

  @override
  String get version => 'الإصدار';

  @override
  String get importExport => 'استيراد/تصدير';

  @override
  String get pleaseEnterName => 'الرجاء إدخال اسم';

  @override
  String get pleaseEnterTankSize => 'الرجاء إدخال حجم الخزان';

  @override
  String get pleaseEnterOdometer => 'الرجاء إدخال عداد المسافة';

  @override
  String get pleaseEnterCost => 'الرجاء إدخال التكلفة';

  @override
  String pleaseEnterFuel(String unitLabel) {
    return 'الرجاء إدخال $unitLabel';
  }

  @override
  String get fullTankSubtitle => 'هل امتلأ الخزان بالكامل؟';

  @override
  String get confirmDeleteRecord => 'هل أنت متأكد من حذف هذا السجل؟';

  @override
  String confirmDeleteVehicle(String name) {
    return 'هل أنت متأكد من حذف $name؟';
  }

  @override
  String get exportSubtitle => 'تصدير سجلات الوقود إلى ملف CSV';

  @override
  String get importSubtitle => 'استيراد سجلات الوقود من ملف CSV';

  @override
  String get shareTitle => 'مشاركة';

  @override
  String get shareSubtitle => 'مشاركة ملف CSV';

  @override
  String get exportSuccess => 'تم التصدير بنجاح';

  @override
  String get exportFailed => 'فشل التصدير';

  @override
  String get noValidRecords => 'لم يتم العثور على سجلات صالحة';

  @override
  String importedRecords(int count) {
    return 'تم استيراد $count من السجلات';
  }

  @override
  String shareRecords(String name) {
    return 'سجلات الوقود لـ $name';
  }

  @override
  String get currency => 'العملة';

  @override
  String get display => 'العرض';

  @override
  String get requireCost => 'التكلفة مطلوبة';

  @override
  String get requireCostSubtitle => 'عند إدخال شراء الوقود';

  @override
  String get displayCost => 'إظهار التكلفة في السجل';

  @override
  String get displayNotes => 'إظهار الملاحظات في السجل';

  @override
  String get database => 'قاعدة البيانات';

  @override
  String get backupDatabase => 'نسخ احتياطي لقاعدة البيانات';

  @override
  String get backupDatabaseSubtitle => 'نسخ قاعدة البيانات كاملة إلى ملف';

  @override
  String get restoreDatabase => 'استعادة قاعدة البيانات';

  @override
  String get restoreDatabaseSubtitle =>
      'استعادة قاعدة البيانات من ملف النسخ الاحتياطي';

  @override
  String get helpSubtitle => 'إظهار معلومات مساعدة التطبيق';

  @override
  String get aboutSubtitle => 'إظهار معلومات إصدار التطبيق';

  @override
  String get license => 'رخصة';

  @override
  String get licenseSubtitle => 'إظهار رخصة البرنامج';

  @override
  String get close => 'إغلاق';

  @override
  String get summary => 'ملخص';

  @override
  String get recordsLabel => 'السجلات';

  @override
  String get avg => 'متوسط';

  @override
  String get min => 'أدنى';

  @override
  String get max => 'أعلى';

  @override
  String get total => 'إجمالي';

  @override
  String get avgMonth => 'متوسط/شهري';

  @override
  String perDistance(String unit) {
    return 'لكل $unit';
  }

  @override
  String avgPerVolume(String unit) {
    return 'متوسط/$unit';
  }

  @override
  String get distanceSection => 'المسافة';

  @override
  String get fuelSection => 'الوقود';

  @override
  String get costSection => 'التكلفة';

  @override
  String get priceSection => 'السعر';

  @override
  String get monthlyBreakdown => 'التفصيل الشهري';

  @override
  String get shareReport => 'مشاركة التقرير';

  @override
  String shareReportError(String error) {
    return 'فشل مشاركة التقرير: $error';
  }

  @override
  String get usSection => 'أمريكي';

  @override
  String get usSubtitle => 'أميال، جالون';

  @override
  String get metricSection => 'متري';

  @override
  String get metricSubtitle => 'كيلومترات، لترات';

  @override
  String get ukSection => 'بريطاني';

  @override
  String get ukSubtitle => 'أميال، جالون إمبراطوري';

  @override
  String get mpgLabel => 'ميل/جالون (ميل لكل جالون)';

  @override
  String get kmlLabel => 'كم/ل (كيلومتر لكل لتر)';

  @override
  String get l100kmLabel => 'ل/100كم (لتر لكل 100 كم)';

  @override
  String get ukmpgLabel => 'ميل بريطاني/جالون (ميل إمبراطوري لكل جالون)';

  @override
  String get kpgLabel => 'كم/جالون (كيلومتر لكل جالون)';

  @override
  String get gallonsUnit => 'جالون';

  @override
  String get litersUnit => 'لتر';

  @override
  String get milesUnit => 'ميل';

  @override
  String get kilometersUnit => 'كيلومتر';

  @override
  String get edit => 'تعديل';

  @override
  String recordsLabelShort(
    int count,
    String odometer,
    String unitDistance,
    String mileage,
  ) {
    return '$count من السجلات | $odometer $unitDistance | $mileage';
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
  String get appVersion => 'إصدار التطبيق';

  @override
  String get buildDate => 'تاريخ البناء';

  @override
  String get databaseVersion => 'إصدار قاعدة البيانات';

  @override
  String get gasMileageLog => 'سجل استهلاك الوقود';

  @override
  String get selectCurrency => 'اختر العملة';

  @override
  String get searchCurrenciesHint => 'ابحث عن العملات...';

  @override
  String get backupSuccess => 'تم إنشاء نسخة احتياطية لقاعدة البيانات بنجاح';

  @override
  String backupFailed(String error) {
    return 'فشل النسخ الاحتياطي: $error';
  }

  @override
  String get restoreSuccess =>
      'تمت استعادة قاعدة البيانات بنجاح. يُرجى إعادة تشغيل التطبيق.';

  @override
  String restoreFailed(String error) {
    return 'فشل الاستعادة: $error';
  }

  @override
  String get restoreConfirm =>
      'سيؤدي هذا إلى استبدال قاعدة بياناتك الحالية بالنسخة الاحتياطية. لا يمكن التراجع عن هذا الإجراء. هل تريد المتابعة؟';

  @override
  String get faqs => 'الأسئلة الشائعة (FAQ)';

  @override
  String get helpQ1 => 'لماذا لا يحسب FillUp مسافتي؟';

  @override
  String get helpA1 =>
      'تحتاج إلى ملء الخزان مرة واحدة لتحديد نقطة البداية، ثم تسجيل جميع مشتريات الوقود. في كل مرة تملأ فيها الخزان بعد نقطة البداية، سيحسب FillUp مسافتك عن طريق تحديد المسافة المقطوعة والوقود المستخدم منذ آخر خزان ممتلئ.\n\nنصيحة: في شاشة \"إضافة وقود\"، ضع علامة في مربع \"الخزان ممتلئ\" عند امتلاء الخزان، وإلا لن يحسب FillUp مسافتك أبدًا.';

  @override
  String get helpQ2 => 'لماذا يقدّر FillUp مسافتي فقط؟';

  @override
  String get helpA2 =>
      'يحتاج خزان ممتلئ لحساب بدقة كمية الوقود المستخدمة منذ آخر خزان ممتلئ. إذا كان الخزان غير ممتلئ عند وضع الوقود، لا يمكن لـ FillUp حساب المسافة بدقة، بل يقدرها فقط.';

  @override
  String get helpQ3 => 'ماذا لو نسيت تسجيل شراء وقود؟';

  @override
  String get helpA3 =>
      'عند ملء الخزان التالي، سيكون حساب المسافة خاطئًا (مرتفعًا جدًا). يمكنك إخفاء هذا القيمة من خلال اختياره في السجل والنقر على \"إخفاء الحساب\".';

  @override
  String get helpQ4 => 'كيف أنسخ/أستعيد بياناتي؟';

  @override
  String get helpA4 =>
      'تخزن بيانات FillUp في قاعدة بيانات على جهازك. استخدم التصدير لحفظ بيانات السجل في ملف CSV، والاستيراد لاستعادتها.';

  @override
  String get licenseText =>
      'مرخّصة بموجب رخصة Apache، الإصدار 2.0 (\"الرخصة\"). لا يمكنك استخدام هذا البرمجيات إلا وفقًا للرخصة. يمكنك الحصول على نسخة من الرخصة من:\n\nhttp://www.apache.org/licenses/LICENSE-2.0\n\nإلا إذا كانت مطلوبة بموجب القانون المعمول به أو اتفاق خطي، تُوزّع البرمجيات المرخّصة تحت الرخصة على أساس \"كما هي\"، بدون ضمانات أو شروط من أي نوع، صريحة أو ضمنية. راجع الرخصة لمعرفة الشروط المنصوص عليها في الصلاحيات والقيود.';

  @override
  String get copyright =>
      'حقوق النشر © 2013,2014 William D. Kraemer - إعادة كتابة بواسطة Muhammad Bashir Al-Noimi في 2026-08-31';

  @override
  String shareStatistics(String name) {
    return 'إحصائيات $name';
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
  String get allData => 'جميع البيانات';

  @override
  String get dateRange => 'النطاق الزمني';

  @override
  String get months => 'أشهر';

  @override
  String fuelEconomy(String metric) {
    return 'الاستهلاك ($metric)';
  }

  @override
  String get distanceDriven => 'المسافة المقطوعة';

  @override
  String get fuelPurchased => 'الوقود المشتراه';

  @override
  String get fuelCost => 'تكلفة الوقود';

  @override
  String get fuelPrice => 'سعر الوقود (متوسط)';

  @override
  String get perMonth => 'لكل شهر';

  @override
  String per(String unit) {
    return 'لكل $unit';
  }

  @override
  String get fuelAmount => 'كمية الوقود';

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
    return 'الاقتصاد ($unit)';
  }

  @override
  String get noFileSelected => 'لم يتم اختيار أي ملف';

  @override
  String get searchLanguagesHint => 'ابحث عن لغة...';
}
