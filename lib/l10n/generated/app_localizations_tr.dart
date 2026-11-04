// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'FillUp';

  @override
  String get vehicleName => 'Araç Adı';

  @override
  String get tankSize => 'Depo Boyutu';

  @override
  String get addVehicle => 'Araç Ekle';

  @override
  String get editVehicle => 'Araç Düzenle';

  @override
  String get deleteVehicle => 'Araç Sil';

  @override
  String get date => 'Tarih';

  @override
  String get odometer => 'Kilometre Sayacı';

  @override
  String get gallons => 'Galon';

  @override
  String get cost => 'Maliyet';

  @override
  String get fullTank => 'Dolu Depo';

  @override
  String get notes => 'Notlar';

  @override
  String get addRecord => 'Kayıt Ekle';

  @override
  String get editRecord => 'Kayıt Düzenle';

  @override
  String get deleteRecord => 'Kayıt Sil';

  @override
  String get mileage => 'Kilometre';

  @override
  String get mpg => 'Mil/Galon';

  @override
  String get kml => 'KM/Litre';

  @override
  String get l100km => 'Litre/100KM';

  @override
  String get ukmpg => 'İngiliz Mil/Galon';

  @override
  String get kpg => 'KM/Galon';

  @override
  String get settings => 'Ayarlar';

  @override
  String get units => 'Birimler';

  @override
  String get language => 'Dil';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Açık';

  @override
  String get dark => 'Koyu';

  @override
  String get system => 'Sistem';

  @override
  String get statistics => 'İstatistikler';

  @override
  String get charts => 'Grafikler';

  @override
  String get import => 'İçe Aktar';

  @override
  String get export => 'Dışa Aktar';

  @override
  String get cancel => 'İptal';

  @override
  String get save => 'Kaydet';

  @override
  String get delete => 'Sil';

  @override
  String get confirm => 'Onayla';

  @override
  String get yes => 'Evet';

  @override
  String get no => 'Hayır';

  @override
  String get ok => 'Tamam';

  @override
  String get error => 'Hata';

  @override
  String get success => 'Başarılı';

  @override
  String get loading => 'Yükleniyor...';

  @override
  String get noVehicles => 'Henüz araç eklenmedi';

  @override
  String get noRecords => 'Henüz yakıt kaydı yok';

  @override
  String get selectVehicle => 'Araç Seç';

  @override
  String get fuelRecords => 'Yakıt Kayıtları';

  @override
  String get plot => 'Grafik';

  @override
  String get mileagePlot => 'Kilometre Grafiği';

  @override
  String get odometerPlot => 'Kilometre Sayacı Grafiği';

  @override
  String get gallonsPlot => 'Galon Grafiği';

  @override
  String get costPlot => 'Maliyet Grafiği';

  @override
  String get pricePlot => 'Fiyat Grafiği';

  @override
  String get startDate => 'Başlangıç Tarihi';

  @override
  String get endDate => 'Bitiş Tarihi';

  @override
  String get apply => 'Uygula';

  @override
  String get reset => 'Sıfırla';

  @override
  String get share => 'Paylaş';

  @override
  String get about => 'Hakkında';

  @override
  String get help => 'Yardım';

  @override
  String get version => 'Sürüm';

  @override
  String get importExport => 'İçe/Dışa Aktar';

  @override
  String get pleaseEnterName => 'Lütfen bir ad girin';

  @override
  String get pleaseEnterTankSize => 'Lütfen depo boyutu girin';

  @override
  String get pleaseEnterOdometer => 'Lütfen kilometre sayacını girin';

  @override
  String get pleaseEnterCost => 'Lütfen maliyeti girin';

  @override
  String pleaseEnterFuel(String unitLabel) {
    return 'Lütfen $unitLabel girin';
  }

  @override
  String get fullTankSubtitle => 'Depo tamamen dolduruldu mu?';

  @override
  String get confirmDeleteRecord =>
      'Bu kaydı silmek istediğinizden emin misiniz?';

  @override
  String confirmDeleteVehicle(String name) {
    return '$name adlı aracı silmek istediğinizden emin misiniz?';
  }

  @override
  String get exportSubtitle => 'Yakıt kayıtlarını CSV dosyasına dışa aktar';

  @override
  String get importSubtitle => 'CSV dosyasından yakıt kayıtlarını içe aktar';

  @override
  String get shareTitle => 'Paylaş';

  @override
  String get shareSubtitle => 'CSV dosyasını paylaş';

  @override
  String get exportSuccess => 'Dışa aktarma başarılı';

  @override
  String get exportFailed => 'Dışa aktarma başarısız';

  @override
  String get noValidRecords => 'Geçerli kayıt bulunamadı';

  @override
  String importedRecords(int count) {
    return '$count kayıt içe aktarıldı';
  }

  @override
  String shareRecords(String name) {
    return '$name yakıt kayıtları';
  }

  @override
  String get currency => 'Para Birimi';

  @override
  String get display => 'Görünüm';

  @override
  String get requireCost => 'Maliyet Zorunlu';

  @override
  String get requireCostSubtitle => 'Yakıt alımı girerken';

  @override
  String get displayCost => 'Maliyeti Kayıtta Göster';

  @override
  String get displayNotes => 'Notları Kayıtta Göster';

  @override
  String get database => 'Veritabanı';

  @override
  String get backupDatabase => 'Veritabanı Yedekle';

  @override
  String get backupDatabaseSubtitle => 'Tüm veritabanını dosyaya yedekle';

  @override
  String get restoreDatabase => 'Veritabanını Geri Yükle';

  @override
  String get restoreDatabaseSubtitle =>
      'Veritabanını yedek dosyasından geri yükle';

  @override
  String get helpSubtitle => 'Uygulama yardım bilgisini göster';

  @override
  String get aboutSubtitle => 'Uygulama sürüm bilgisini göster';

  @override
  String get license => 'Lisans';

  @override
  String get licenseSubtitle => 'Yazılım lisansını göster';

  @override
  String get close => 'Kapat';

  @override
  String get summary => 'Özet';

  @override
  String get recordsLabel => 'Kayıtlar';

  @override
  String get avg => 'Ort.';

  @override
  String get min => 'Min';

  @override
  String get max => 'Maks';

  @override
  String get total => 'Toplam';

  @override
  String get avgMonth => 'Ort./Ay';

  @override
  String perDistance(String unit) {
    return '$unit başına';
  }

  @override
  String avgPerVolume(String unit) {
    return 'Ort./$unit';
  }

  @override
  String get distanceSection => 'Mesafe';

  @override
  String get fuelSection => 'Yakıt';

  @override
  String get costSection => 'Maliyet';

  @override
  String get priceSection => 'Fiyat';

  @override
  String get monthlyBreakdown => 'Aylık Detay';

  @override
  String get shareReport => 'Raporu Paylaş';

  @override
  String shareReportError(String error) {
    return 'Rapor paylaşımı başarısız: $error';
  }

  @override
  String get usSection => 'ABD';

  @override
  String get usSubtitle => 'Mil, Galon';

  @override
  String get metricSection => 'Metrik';

  @override
  String get metricSubtitle => 'Kilometre, Litre';

  @override
  String get ukSection => 'İngiltere';

  @override
  String get ukSubtitle => 'Mil, İmperyal Galon';

  @override
  String get mpgLabel => 'MPG (Mil/Galon)';

  @override
  String get kmlLabel => 'KM/L (Kilometre/Litre)';

  @override
  String get l100kmLabel => 'L/100KM (Litre/100KM)';

  @override
  String get ukmpgLabel => 'UK MPG (İngiliz Mil/Galon)';

  @override
  String get kpgLabel => 'KPG (KM/Galon)';

  @override
  String get gallonsUnit => 'galon';

  @override
  String get litersUnit => 'litre';

  @override
  String get milesUnit => 'mil';

  @override
  String get kilometersUnit => 'kilometre';

  @override
  String get edit => 'Düzenle';

  @override
  String recordsLabelShort(
    int count,
    String odometer,
    String unitDistance,
    String mileage,
  ) {
    return '$count kayıt | $odometer $unitDistance | $mileage';
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
  String get appVersion => 'Uygulama Sürümü';

  @override
  String get buildDate => 'Derleme Tarihi';

  @override
  String get databaseVersion => 'Veritabanı Sürümü';

  @override
  String get gasMileageLog => 'Yakıt Tüketim Kaydı';

  @override
  String get selectCurrency => 'Para Birimi Seçin';

  @override
  String get searchCurrenciesHint => 'Para birimleri ara...';

  @override
  String get backupSuccess => 'Veritabanı yedeği başarıyla oluşturuldu';

  @override
  String backupFailed(String error) {
    return 'Yedekleme başarısız: $error';
  }

  @override
  String get restoreSuccess =>
      'Veritabanı başarıyla geri yüklendi. Lütfen uygulamayı yeniden başlatın.';

  @override
  String restoreFailed(String error) {
    return 'Geri yükleme başarısız: $error';
  }

  @override
  String get restoreConfirm =>
      'Bu işlem mevcut veritabanınızı yedek dosyasıyla değiştirecek. Bu işlem geri alınamaz. Devam etmek istiyor musunuz?';

  @override
  String get faqs => 'Sık Sorulan Sorular (FAQ)';

  @override
  String get helpQ1 => 'Neden FillUp kilomajını hesaplamıyor?';

  @override
  String get helpA1 =>
      'Bir başlangıç noktası belirlemek için deposunu bir kez doldurmanız ve ardından tüm yakıt alımlarını kaydetmeniz gerekir. Başlangıç noktasından sonra her depo dolumunda, FillUp, son tam dolumdan bu yana kat edilen mesafeyi ve kullanılan yakıtı belirleyerek kilomajınızı hesaplar.\n\nİPUCU: \"Yakıt Ekle\" ekranında, depo dolduğunda \"Dolu Depo\" kutusunu işaretleyin; aksi takdirde FillUp asla kilomaj hesaplamaz.';

  @override
  String get helpQ2 => 'Neden FillUp kilomajımı tahmin olarak belirtiyor?';

  @override
  String get helpA2 =>
      'Son tam dolumdan bu yana ne kadar yakıt kullanıldığını doğru hesaplamak için depo dolumu gereklidir. Yakıt alırken depo tam değilse, FillUp kilomajı doğru olarak hesaplayamaz; bunun yerine tahmini olarak belirtir.';

  @override
  String get helpQ3 => 'Yakıt alışımını kaydetmeyi unutursam ne olur?';

  @override
  String get helpA3 =>
      'Bir sonraki depo dolumunda, kilomaj hesabı yanlış (çok yüksek) olacaktır. Bu değeri, kayıttan seçip \"Hesabı Gizle\"ye tıklayarak gizleyebilirsiniz.';

  @override
  String get helpQ4 => 'Verilerimi nasıl yedeklerim/geri yüklerim?';

  @override
  String get helpA4 =>
      'FillUp verileri cihazınızdaki bir veritabanında saklanır. Verileri CSV dosyasına kaydetmek için Dışa Aktar\'ı, geri yüklemek için İçe Aktar\'ı kullanın.';

  @override
  String get licenseText =>
      'Apache Lisansı, Versiyon 2.0 (\"Lisans\") kapsamında lisanslanmıştır; yazılımı Lisansa uygun olmayan şekilde kullanamazsınız. Lisansın bir kopyasını buradan edinebilirsiniz:\n\nhttp://www.apache.org/licenses/LICENSE-2.0\n\nUygulanabilir yasa gerektirmedikçe veya yazılı anlaşma olmadıkça, yazılım Lisans kapsamında \"OLDUĞU GİBİ\" temelde, herhangi bir türde garanti veya koşul verilmeden dağıtılır. İzins ve kısıtlamalar hakkında Lisansa bakın.';

  @override
  String get copyright =>
      'Telif Hakkı © 2013,2014 William D. Kraemer - Muhammad Bashir Al-Noimi tarafından 2026-08-31\'de yeniden yazıldı';

  @override
  String shareStatistics(String name) {
    return '$name için istatistikler';
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
  String get allData => 'Tüm veriler';

  @override
  String get dateRange => 'Tarih Aralığı';

  @override
  String get months => 'ay';

  @override
  String fuelEconomy(String metric) {
    return 'Yakıt Ekonomisi ($metric)';
  }

  @override
  String get distanceDriven => 'Kat Edilen Mesafe';

  @override
  String get fuelPurchased => 'Alınan Yakıt';

  @override
  String get fuelCost => 'Yakıt Maliyeti';

  @override
  String get fuelPrice => 'Yakıt Fiyatı (ort.)';

  @override
  String get perMonth => 'ayda';

  @override
  String per(String unit) {
    return 'birim başına $unit';
  }

  @override
  String get fuelAmount => 'Yakıt Miktarı';

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
    return 'Tasarruf ($unit)';
  }

  @override
  String get noFileSelected => 'Dosya seçilmedi';

  @override
  String get searchLanguagesHint => 'Dilleri ara...';
}
