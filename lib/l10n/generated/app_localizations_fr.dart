// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'FillUp';

  @override
  String get vehicleName => 'Nom du véhicule';

  @override
  String get tankSize => 'Capacité du réservoir';

  @override
  String get addVehicle => 'Ajouter un véhicule';

  @override
  String get editVehicle => 'Modifier le véhicule';

  @override
  String get deleteVehicle => 'Supprimer le véhicule';

  @override
  String get date => 'Date';

  @override
  String get odometer => 'Compteur';

  @override
  String get gallons => 'Gallons';

  @override
  String get cost => 'Coût';

  @override
  String get fullTank => 'Réservoir plein';

  @override
  String get notes => 'Notes';

  @override
  String get addRecord => 'Ajouter une entrée';

  @override
  String get editRecord => 'Modifier l\'entrée';

  @override
  String get deleteRecord => 'Supprimer l\'entrée';

  @override
  String get mileage => 'Consommation';

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
  String get settings => 'Paramètres';

  @override
  String get units => 'Unités';

  @override
  String get language => 'Langue';

  @override
  String get theme => 'Thème';

  @override
  String get light => 'Clair';

  @override
  String get dark => 'Sombre';

  @override
  String get system => 'Système';

  @override
  String get statistics => 'Statistiques';

  @override
  String get charts => 'Graphiques';

  @override
  String get import => 'Importer';

  @override
  String get export => 'Exporter';

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get delete => 'Supprimer';

  @override
  String get confirm => 'Confirmer';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get ok => 'OK';

  @override
  String get error => 'Erreur';

  @override
  String get success => 'Succès';

  @override
  String get loading => 'Chargement...';

  @override
  String get noVehicles => 'Aucun véhicule ajouté';

  @override
  String get noRecords => 'Aucune entrée de carburant';

  @override
  String get selectVehicle => 'Sélectionner un véhicule';

  @override
  String get fuelRecords => 'Entrées de carburant';

  @override
  String get plot => 'Graphique';

  @override
  String get mileagePlot => 'Graphique de consommation';

  @override
  String get odometerPlot => 'Graphique du compteur';

  @override
  String get gallonsPlot => 'Graphique des gallons';

  @override
  String get costPlot => 'Graphique des coûts';

  @override
  String get pricePlot => 'Graphique des prix';

  @override
  String get startDate => 'Date de début';

  @override
  String get endDate => 'Date de fin';

  @override
  String get apply => 'Appliquer';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get share => 'Partager';

  @override
  String get about => 'À propos';

  @override
  String get help => 'Aide';

  @override
  String get version => 'Version';

  @override
  String get importExport => 'Import/Exporter';

  @override
  String get pleaseEnterName => 'Veuillez saisir un nom';

  @override
  String get pleaseEnterTankSize => 'Veuillez saisir la capacité du réservoir';

  @override
  String get pleaseEnterOdometer => 'Veuillez saisir le compteur';

  @override
  String get pleaseEnterCost => 'Veuillez saisir le coût';

  @override
  String pleaseEnterFuel(String unitLabel) {
    return 'Veuillez saisir $unitLabel';
  }

  @override
  String get fullTankSubtitle => 'Le réservoir a-t-il été rempli à plein ?';

  @override
  String get confirmDeleteRecord =>
      'Voulez-vous vraiment supprimer cette entrée ?';

  @override
  String confirmDeleteVehicle(String name) {
    return 'Voulez-vous vraiment supprimer $name ?';
  }

  @override
  String get exportSubtitle => 'Exporter les entrées dans un fichier CSV';

  @override
  String get importSubtitle => 'Importer les entrées depuis un fichier CSV';

  @override
  String get shareTitle => 'Partager';

  @override
  String get shareSubtitle => 'Partager le fichier CSV';

  @override
  String get exportSuccess => 'Export réussi';

  @override
  String get exportFailed => 'Échec de l\'export';

  @override
  String get noValidRecords => 'Aucune entrée valide trouvée';

  @override
  String importedRecords(int count) {
    return '$count entrées importées';
  }

  @override
  String shareRecords(String name) {
    return 'Entrées de carburant pour $name';
  }

  @override
  String get currency => 'Devise';

  @override
  String get display => 'Affichage';

  @override
  String get requireCost => 'Coût obligatoire';

  @override
  String get requireCostSubtitle =>
      'Lors de la saisie d\'un achat de carburant';

  @override
  String get displayCost => 'Afficher le coût dans le journal';

  @override
  String get displayNotes => 'Afficher les notes dans le journal';

  @override
  String get database => 'Base de données';

  @override
  String get backupDatabase => 'Sauvegarder la base';

  @override
  String get backupDatabaseSubtitle =>
      'Sauvegarder l\'intégralité de la base de données';

  @override
  String get restoreDatabase => 'Restaurer la base';

  @override
  String get restoreDatabaseSubtitle =>
      'Restaurer la base de données depuis une sauvegarde';

  @override
  String get helpSubtitle => 'Afficher l\'aide de l\'application';

  @override
  String get aboutSubtitle => 'Afficher les informations de version';

  @override
  String get license => 'Licence';

  @override
  String get licenseSubtitle => 'Afficher la licence logicielle';

  @override
  String get close => 'Fermer';

  @override
  String get summary => 'Résumé';

  @override
  String get recordsLabel => 'Entrées';

  @override
  String get avg => 'Moy';

  @override
  String get min => 'Min';

  @override
  String get max => 'Max';

  @override
  String get total => 'Total';

  @override
  String get avgMonth => 'Moy/mois';

  @override
  String perDistance(String unit) {
    return 'Par $unit';
  }

  @override
  String avgPerVolume(String unit) {
    return 'Moy/$unit';
  }

  @override
  String get distanceSection => 'Distance';

  @override
  String get fuelSection => 'Carburant';

  @override
  String get costSection => 'Coût';

  @override
  String get priceSection => 'Prix';

  @override
  String get monthlyBreakdown => 'Répartition mensuelle';

  @override
  String get shareReport => 'Partager le rapport';

  @override
  String shareReportError(String error) {
    return 'Impossible de partager le rapport : $error';
  }

  @override
  String get usSection => 'US';

  @override
  String get usSubtitle => 'Miles, Gallons';

  @override
  String get metricSection => 'Métrique';

  @override
  String get metricSubtitle => 'Kilomètres, Litres';

  @override
  String get ukSection => 'UK';

  @override
  String get ukSubtitle => 'Miles, Gallons impériaux';

  @override
  String get mpgLabel => 'MPG (miles par gallon)';

  @override
  String get kmlLabel => 'KM/L (kilomètres par litre)';

  @override
  String get l100kmLabel => 'L/100KM (litres par 100 km)';

  @override
  String get ukmpgLabel => 'UK MPG (miles par gallon impérial)';

  @override
  String get kpgLabel => 'KPG (kilomètres par gallon)';

  @override
  String get gallonsUnit => 'gallons';

  @override
  String get litersUnit => 'litres';

  @override
  String get milesUnit => 'miles';

  @override
  String get kilometersUnit => 'kilomètres';

  @override
  String get edit => 'Modifier';

  @override
  String recordsLabelShort(
    int count,
    String odometer,
    String unitDistance,
    String mileage,
  ) {
    return '$count entrées | $odometer $unitDistance | $mileage';
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
  String get appVersion => 'Version de l\'application';

  @override
  String get buildDate => 'Date de compilation';

  @override
  String get databaseVersion => 'Version de la base';

  @override
  String get gasMileageLog => 'Journal de consommation de carburant';

  @override
  String get selectCurrency => 'Choisir la devise';

  @override
  String get searchCurrenciesHint => 'Rechercher les devises...';

  @override
  String get backupSuccess => 'Sauvegarde de la base de données créée';

  @override
  String backupFailed(String error) {
    return 'Échec de la sauvegarde : $error';
  }

  @override
  String get restoreSuccess =>
      'Base de données restaurée. Veuillez relancer l\'application.';

  @override
  String restoreFailed(String error) {
    return 'Échec de la restauration : $error';
  }

  @override
  String get restoreConfirm =>
      'Cela remplacera votre base de données actuelle par la sauvegarde. Cette action est irréversible. Continuer ?';

  @override
  String get faqs => 'Questions fréquentes (FAQ)';

  @override
  String get helpQ1 => 'Pourquoi FillUp ne calcule-t-il pas ma consommation ?';

  @override
  String get helpA1 =>
      'Vous devez remplir le réservoir une fois pour établir un point de départ, puis enregistrer tous vos achats de carburant. À chaque remplissage complet après ce point de départ, FillUp calcule votre consommation à partir de la distance parcourue et du carburant utilisé depuis le plein précédent.\n\nASTUCE : Dans l\'écran « Ajouter du carburant », cochez la case « Réservoir plein » ; sinon FillUp ne calculera jamais la consommation.';

  @override
  String get helpQ2 =>
      'Pourquoi FillUp estime-t-il seulement ma consommation ?';

  @override
  String get helpA2 =>
      'Un réservoir plein est nécessaire pour calculer exactement la quantité de carburant utilisée depuis le plein précédent. Si le réservoir n\'est pas plein lors du ravitaillement, FillUp ne peut pas calculer la consommation avec précision et la estime.';

  @override
  String get helpQ3 =>
      'Que faire si j\'oublie d\'enregistrer un achat de carburant ?';

  @override
  String get helpA3 =>
      'Au prochain plein, le calcul de consommation sera erroné (trop élevé). Vous pouvez masquer cette valeur en la sélectionnant dans le journal et en cliquant sur « Masquer le calcul ».';

  @override
  String get helpQ4 => 'Comment sauvegarder/restaurer mes données ?';

  @override
  String get helpA4 =>
      'Les données FillUp sont stockées dans une base de données sur votre appareil. Utilisez Exporter pour sauvegarder les données dans un fichier CSV et Importer pour les restaurer.';

  @override
  String get licenseText =>
      'Sous licence Apache License, Version 2.0 (la « Licence ») ; vous ne pouvez pas utiliser ce logiciel sauf en conformité avec la Licence. Vous pouvez obtenir une copie de la Licence à l\'adresse :\n\nhttp://www.apache.org/licenses/LICENSE-2.0\n\nSauf exigence de la loi applicable ou accord écrit, le logiciel est distribué sous la Licence sur une base « EN L\'ÉTAT », SANS GARANTIE OU CONDITION D\'AUCUNE SORTE, expresse ou implicite. Consultez la Licence pour les conditions régissant les autorisations et limitations.';

  @override
  String get copyright =>
      'Copyright © 2013,2014 William D. Kraemer - Réécrit par Muhammad Bashir Al-Noimi le 2026-08-31';

  @override
  String shareStatistics(String name) {
    return 'Statistiques de $name';
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
  String get allData => 'Toutes les données';

  @override
  String get dateRange => 'Période';

  @override
  String get months => 'mois';

  @override
  String fuelEconomy(String metric) {
    return 'Consommation ($metric)';
  }

  @override
  String get distanceDriven => 'Distance parcourue';

  @override
  String get fuelPurchased => 'Carburant acheté';

  @override
  String get fuelCost => 'Coût du carburant';

  @override
  String get fuelPrice => 'Prix du carburant (moy.)';

  @override
  String get perMonth => 'par mois';

  @override
  String per(String unit) {
    return 'par $unit';
  }

  @override
  String get fuelAmount => 'Quantité de carburant';

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
    return 'Consommation ($unit)';
  }

  @override
  String get noFileSelected => 'Aucun fichier sélectionné';

  @override
  String get searchLanguagesHint => 'Rechercher les langues...';
}
