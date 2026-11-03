// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'FillUp';

  @override
  String get vehicleName => 'Nome do veículo';

  @override
  String get tankSize => 'Capacidade do tanque';

  @override
  String get addVehicle => 'Adicionar veículo';

  @override
  String get editVehicle => 'Editar veículo';

  @override
  String get deleteVehicle => 'Excluir veículo';

  @override
  String get date => 'Data';

  @override
  String get odometer => 'Quilometragem';

  @override
  String get gallons => 'Galões';

  @override
  String get cost => 'Custo';

  @override
  String get fullTank => 'Tanque cheio';

  @override
  String get notes => 'Notas';

  @override
  String get addRecord => 'Adicionar registo';

  @override
  String get editRecord => 'Editar registo';

  @override
  String get deleteRecord => 'Excluir registo';

  @override
  String get mileage => 'Rendimento';

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
  String get settings => 'Definições';

  @override
  String get units => 'Unidades';

  @override
  String get language => 'Idioma';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Escuro';

  @override
  String get system => 'Sistema';

  @override
  String get statistics => 'Estatísticas';

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
  String get delete => 'Excluir';

  @override
  String get confirm => 'Confirmar';

  @override
  String get yes => 'Sim';

  @override
  String get no => 'Não';

  @override
  String get ok => 'OK';

  @override
  String get error => 'Erro';

  @override
  String get success => 'Sucesso';

  @override
  String get loading => 'A carregar...';

  @override
  String get noVehicles => 'Ainda não há veículos';

  @override
  String get noRecords => 'Ainda não há registos de combustível';

  @override
  String get selectVehicle => 'Selecionar veículo';

  @override
  String get fuelRecords => 'Registos de combustível';

  @override
  String get plot => 'Gráfico';

  @override
  String get mileagePlot => 'Gráfico de rendimento';

  @override
  String get odometerPlot => 'Gráfico do odómetro';

  @override
  String get gallonsPlot => 'Gráfico de galões';

  @override
  String get costPlot => 'Gráfico de custo';

  @override
  String get pricePlot => 'Gráfico de preço';

  @override
  String get startDate => 'Data de início';

  @override
  String get endDate => 'Data de término';

  @override
  String get apply => 'Aplicar';

  @override
  String get reset => 'Repor';

  @override
  String get share => 'Partilhar';

  @override
  String get about => 'Sobre';

  @override
  String get help => 'Ajuda';

  @override
  String get version => 'Versão';

  @override
  String get importExport => 'Import/Export';

  @override
  String get pleaseEnterName => 'Please enter a name';

  @override
  String get pleaseEnterTankSize => 'Please enter tank size';

  @override
  String get pleaseEnterOdometer => 'Please enter odometer';

  @override
  String get pleaseEnterCost => 'Please enter cost';

  @override
  String pleaseEnterFuel(String unitLabel) {
    return 'Please enter $unitLabel';
  }

  @override
  String get fullTankSubtitle => 'Was the tank filled completely?';

  @override
  String get confirmDeleteRecord =>
      'Are you sure you want to delete this record?';

  @override
  String confirmDeleteVehicle(String name) {
    return 'Are you sure you want to delete $name?';
  }

  @override
  String get exportSubtitle => 'Export fuel records to CSV file';

  @override
  String get importSubtitle => 'Import fuel records from CSV file';

  @override
  String get shareTitle => 'Share';

  @override
  String get shareSubtitle => 'Share CSV file';

  @override
  String get exportSuccess => 'Export successful';

  @override
  String get exportFailed => 'Export failed';

  @override
  String get noValidRecords => 'No valid records found';

  @override
  String importedRecords(int count) {
    return 'Imported $count records';
  }

  @override
  String shareRecords(String name) {
    return 'Fuel records for $name';
  }

  @override
  String get currency => 'Currency';

  @override
  String get display => 'Display';

  @override
  String get requireCost => 'Require Cost';

  @override
  String get requireCostSubtitle => 'When entering fuel purchase';

  @override
  String get displayCost => 'Display Cost in Log';

  @override
  String get displayNotes => 'Display Notes in Log';

  @override
  String get database => 'Database';

  @override
  String get backupDatabase => 'Backup Database';

  @override
  String get backupDatabaseSubtitle => 'Backup entire database to file';

  @override
  String get restoreDatabase => 'Restore Database';

  @override
  String get restoreDatabaseSubtitle => 'Restore database from backup file';

  @override
  String get helpSubtitle => 'Display application help information';

  @override
  String get aboutSubtitle => 'Display application version information';

  @override
  String get license => 'License';

  @override
  String get licenseSubtitle => 'Display the software license';

  @override
  String get close => 'Close';

  @override
  String get summary => 'Summary';

  @override
  String get recordsLabel => 'Records';

  @override
  String get avg => 'Avg';

  @override
  String get min => 'Min';

  @override
  String get max => 'Max';

  @override
  String get total => 'Total';

  @override
  String get avgMonth => 'Avg/month';

  @override
  String perDistance(String unit) {
    return 'Per $unit';
  }

  @override
  String avgPerVolume(String unit) {
    return 'Avg/$unit';
  }

  @override
  String get distanceSection => 'Distance';

  @override
  String get fuelSection => 'Fuel';

  @override
  String get costSection => 'Cost';

  @override
  String get priceSection => 'Price';

  @override
  String get monthlyBreakdown => 'Monthly Breakdown';

  @override
  String get shareReport => 'Share Report';

  @override
  String shareReportError(String error) {
    return 'Failed to share report: $error';
  }

  @override
  String get usSection => 'US';

  @override
  String get usSubtitle => 'Miles, Gallons';

  @override
  String get metricSection => 'Metric';

  @override
  String get metricSubtitle => 'Kilometers, Liters';

  @override
  String get ukSection => 'UK';

  @override
  String get ukSubtitle => 'Miles, Imperial Gallons';

  @override
  String get mpgLabel => 'MPG (miles per gallon)';

  @override
  String get kmlLabel => 'KM/L (kilometers per liter)';

  @override
  String get l100kmLabel => 'L/100KM (liters per 100 km)';

  @override
  String get ukmpgLabel => 'UK MPG (miles per imperial gallon)';

  @override
  String get kpgLabel => 'KPG (kilometers per gallon)';

  @override
  String get edit => 'Edit';

  @override
  String recordsLabelShort(
    int count,
    String odometer,
    String unitDistance,
    String mileage,
  ) {
    return '$count records | $odometer $unitDistance | $mileage';
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
  String get appVersion => 'App Version';

  @override
  String get buildDate => 'Build Date';

  @override
  String get databaseVersion => 'Database Version';

  @override
  String get gasMileageLog => 'Gas Mileage Log';

  @override
  String get selectCurrency => 'Select Currency';

  @override
  String get searchCurrenciesHint => 'Search currencies...';

  @override
  String get backupSuccess => 'Database backup created successfully';

  @override
  String backupFailed(String error) {
    return 'Backup failed: $error';
  }

  @override
  String get restoreSuccess =>
      'Database restored successfully. Please restart the app.';

  @override
  String restoreFailed(String error) {
    return 'Restore failed: $error';
  }

  @override
  String get restoreConfirm =>
      'This will replace your current database with the backup. This action cannot be undone. Continue?';

  @override
  String get faqs => 'Frequently Asked Questions (FAQ)';

  @override
  String get helpQ1 => 'Why isn\'t FillUp calculating my mileage?';

  @override
  String get helpA1 =>
      'You need to fill your tank once to establish a starting point, and then continue recording all of your fuel purchases. Each time you fill your tank after the starting point, FillUp will calculate your mileage by determining the distance driven and fuel used since the previous full tank.\n\nTIP: In the Add Fuel screen, put a check mark in the \"Tank Full\" box to indicate when the tank has been filled, otherwise FillUp will never calculate mileage.';

  @override
  String get helpQ2 => 'Why does FillUp only estimate my mileage?';

  @override
  String get helpA2 =>
      'A full tank is needed to accurately calculate how much fuel was used since the previous full tank. When you get fuel and the tank is not full, FillUp cannot calculate mileage exactly. Instead it will allow you to estimate mileage.';

  @override
  String get helpQ3 => 'What if I forget to record a fuel purchase?';

  @override
  String get helpA3 =>
      'The next time you fill your tank, the mileage calculation will be wrong (too high). You can hide this value by selecting it in the Log and clicking \"Hide Calculation\".';

  @override
  String get helpQ4 => 'How do I backup/restore my data?';

  @override
  String get helpA4 =>
      'FillUp Log data is stored in a database on your device. Use Export to save Log data to a CSV file, and Import to restore it.';

  @override
  String get licenseText =>
      'Licensed under the Apache License, Version 2.0 (the \"License\"); you may not use this software except in compliance with the License. You may obtain a copy of the License at:\n\nhttp://www.apache.org/licenses/LICENSE-2.0\n\nUnless required by applicable law or agreed to in writing, software distributed under the License is distributed on an \"AS IS\" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.\n\nUse of this software constitutes acceptance of this license.';

  @override
  String get copyright =>
      'Copyright © 2013,2014 William D. Kraemer - Rewritten by Muhammad Bashir Al-Noimi on 2026-08-31';

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
  String get fuelAmount => 'Fuel Amount';

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

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'FillUp';

  @override
  String get vehicleName => 'Nome do veículo';

  @override
  String get tankSize => 'Capacidade do tanque';

  @override
  String get addVehicle => 'Adicionar veículo';

  @override
  String get editVehicle => 'Editar veículo';

  @override
  String get deleteVehicle => 'Excluir veículo';

  @override
  String get date => 'Data';

  @override
  String get odometer => 'Quilometragem';

  @override
  String get gallons => 'Galões';

  @override
  String get cost => 'Custo';

  @override
  String get fullTank => 'Tanque cheio';

  @override
  String get notes => 'Notas';

  @override
  String get addRecord => 'Adicionar registro';

  @override
  String get editRecord => 'Editar registro';

  @override
  String get deleteRecord => 'Excluir registro';

  @override
  String get mileage => 'Rendimento';

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
  String get settings => 'Configurações';

  @override
  String get units => 'Unidades';

  @override
  String get language => 'Idioma';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Escuro';

  @override
  String get system => 'Sistema';

  @override
  String get statistics => 'Estatísticas';

  @override
  String get charts => 'Gráficos';

  @override
  String get import => 'Importar';

  @override
  String get export => 'Exportar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Salvar';

  @override
  String get delete => 'Excluir';

  @override
  String get confirm => 'Confirmar';

  @override
  String get yes => 'Sim';

  @override
  String get no => 'Não';

  @override
  String get ok => 'OK';

  @override
  String get error => 'Erro';

  @override
  String get success => 'Sucesso';

  @override
  String get loading => 'Carregando...';

  @override
  String get noVehicles => 'Nenhum veículo adicionado ainda';

  @override
  String get noRecords => 'Nenhum registro de combustível ainda';

  @override
  String get selectVehicle => 'Selecionar veículo';

  @override
  String get fuelRecords => 'Registros de combustível';

  @override
  String get plot => 'Gráfico';

  @override
  String get mileagePlot => 'Gráfico de rendimento';

  @override
  String get odometerPlot => 'Gráfico do odômetro';

  @override
  String get gallonsPlot => 'Gráfico de galões';

  @override
  String get costPlot => 'Gráfico de custo';

  @override
  String get pricePlot => 'Gráfico de preço';

  @override
  String get startDate => 'Data de início';

  @override
  String get endDate => 'Data de término';

  @override
  String get apply => 'Aplicar';

  @override
  String get reset => 'Reiniciar';

  @override
  String get share => 'Compartilhar';

  @override
  String get about => 'Sobre';

  @override
  String get help => 'Ajuda';

  @override
  String get version => 'Versão';

  @override
  String get importExport => 'Importar/Exportar';

  @override
  String get pleaseEnterName => 'Por favor, insira um nome';

  @override
  String get pleaseEnterTankSize => 'Por favor, insira a capacidade do tanque';

  @override
  String get pleaseEnterOdometer => 'Por favor, insira a quilometragem';

  @override
  String get pleaseEnterCost => 'Por favor, insira o custo';

  @override
  String pleaseEnterFuel(String unitLabel) {
    return 'Por favor, insira $unitLabel';
  }

  @override
  String get fullTankSubtitle => 'O tanque foi totalmente abastecido?';

  @override
  String get confirmDeleteRecord =>
      'Tem certeza de que deseja excluir este registro?';

  @override
  String confirmDeleteVehicle(String name) {
    return 'Tem certeza de que deseja excluir $name?';
  }

  @override
  String get exportSubtitle => 'Exportar registros para arquivo CSV';

  @override
  String get importSubtitle => 'Importar registros de arquivo CSV';

  @override
  String get shareTitle => 'Compartilhar';

  @override
  String get shareSubtitle => 'Compartilhar arquivo CSV';

  @override
  String get exportSuccess => 'Exportação bem-sucedida';

  @override
  String get exportFailed => 'Falha na exportação';

  @override
  String get noValidRecords => 'Nenhum registro válido encontrado';

  @override
  String importedRecords(int count) {
    return '$count registros importados';
  }

  @override
  String shareRecords(String name) {
    return 'Registros de combustível de $name';
  }

  @override
  String get currency => 'Moeda';

  @override
  String get display => 'Exibição';

  @override
  String get requireCost => 'Custo obrigatório';

  @override
  String get requireCostSubtitle => 'Ao registrar a compra de combustível';

  @override
  String get displayCost => 'Exibir custo no diário';

  @override
  String get displayNotes => 'Exibir notas no diário';

  @override
  String get database => 'Banco de dados';

  @override
  String get backupDatabase => 'Backup do banco de dados';

  @override
  String get backupDatabaseSubtitle =>
      'Faça backup de todo o banco de dados para um arquivo';

  @override
  String get restoreDatabase => 'Restaurar banco de dados';

  @override
  String get restoreDatabaseSubtitle =>
      'Restaure o banco de dados de um arquivo de backup';

  @override
  String get helpSubtitle => 'Exibir informações de ajuda da aplicação';

  @override
  String get aboutSubtitle => 'Exibir informações de versão da aplicação';

  @override
  String get license => 'Licença';

  @override
  String get licenseSubtitle => 'Exibir a licença do software';

  @override
  String get close => 'Fechar';

  @override
  String get summary => 'Resumo';

  @override
  String get recordsLabel => 'Registros';

  @override
  String get avg => 'Média';

  @override
  String get min => 'Mín';

  @override
  String get max => 'Máx';

  @override
  String get total => 'Total';

  @override
  String get avgMonth => 'Média/mês';

  @override
  String perDistance(String unit) {
    return 'Por $unit';
  }

  @override
  String avgPerVolume(String unit) {
    return 'Média/$unit';
  }

  @override
  String get distanceSection => 'Distância';

  @override
  String get fuelSection => 'Combustível';

  @override
  String get costSection => 'Custo';

  @override
  String get priceSection => 'Preço';

  @override
  String get monthlyBreakdown => 'Detalhamento mensal';

  @override
  String get shareReport => 'Compartilhar relatório';

  @override
  String shareReportError(String error) {
    return 'Falha ao compartilhar o relatório: $error';
  }

  @override
  String get usSection => 'EUA';

  @override
  String get usSubtitle => 'Milhas, Galões';

  @override
  String get metricSection => 'Métrico';

  @override
  String get metricSubtitle => 'Quilômetros, Litros';

  @override
  String get ukSection => 'Reino Unido';

  @override
  String get ukSubtitle => 'Milhas, Galões imperiais';

  @override
  String get mpgLabel => 'MPG (milhas por galão)';

  @override
  String get kmlLabel => 'KM/L (quilômetros por litro)';

  @override
  String get l100kmLabel => 'L/100KM (litros por 100 km)';

  @override
  String get ukmpgLabel => 'UK MPG (milhas por galão imperial)';

  @override
  String get kpgLabel => 'KPG (quilômetros por galão)';

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
  String get appVersion => 'Versão da aplicação';

  @override
  String get buildDate => 'Data de compilação';

  @override
  String get databaseVersion => 'Versão do banco de dados';

  @override
  String get gasMileageLog => 'Diário de rendimento de combustível';

  @override
  String get selectCurrency => 'Selecionar moeda';

  @override
  String get searchCurrenciesHint => 'Pesquisar moedas...';

  @override
  String get backupSuccess => 'Backup do banco de dados criado com sucesso';

  @override
  String backupFailed(String error) {
    return 'Falha no backup: $error';
  }

  @override
  String get restoreSuccess =>
      'Banco de dados restaurado com sucesso. Por favor, reinicie a aplicação.';

  @override
  String restoreFailed(String error) {
    return 'Falha na restauração: $error';
  }

  @override
  String get restoreConfirm =>
      'Isso substituirá seu banco de dados atual pelo backup. Esta ação não pode ser desfeita. Continuar?';

  @override
  String get faqs => 'Perguntas frequentes (FAQ)';

  @override
  String get helpQ1 => 'Por que o FillUp não está calculando meu rendimento?';

  @override
  String get helpA1 =>
      'Você precisa encher o tanque uma vez para estabelecer um ponto de partida e depois registrar todas as suas compras de combustível. Toda vez que você encher o tanque após o ponto de partida, o FillUp calculará seu rendimento determinando a distância percorrida e o combustível usado desde o último abastecimento completo.\n\nDICA: Na tela \"Adicionar combustível\", marque a caixa \"Tanque cheio\" para indicar quando o tanque foi abastecido; caso contrário, o FillUp nunca calculará o rendimento.';

  @override
  String get helpQ2 => 'Por que o FillUp apenas estima meu rendimento?';

  @override
  String get helpA2 =>
      'Um tanque cheio é necessário para calcular com precisão a quantidade de combustível usado desde o último abastecimento completo. Se o tanque não estiver cheio ao abastecer, o FillUp não pode calcular o rendimento exatamente e o estima em vez disso.';

  @override
  String get helpQ3 =>
      'E se eu esquecer de registrar uma compra de combustível?';

  @override
  String get helpA3 =>
      'Na próxima vez que você encher o tanque, o cálculo do rendimento estará incorreto (demais alto). Você pode ocultar esse valor selecionando-o no diário e clicando em \"Ocultar cálculo\".';

  @override
  String get helpQ4 => 'Como faço para fazer backup/restaurar meus dados?';

  @override
  String get helpA4 =>
      'Os dados do FillUp são armazenados em um banco de dados no seu dispositivo. Use Exportar para salvar os dados em um arquivo CSV e Importar para restaurá-los.';

  @override
  String get licenseText =>
      'Licenciado sob a Licença Apache, Versão 2.0 (a \"Licença\"); você não pode usar este software exceto em conformidade com a Licença. Você pode obter uma cópia da Licença em:\n\nhttp://www.apache.org/licenses/LICENSE-2.0\n\nExceto conforme exigido pela lei aplicável ou por acordo escrito, o software é distribuído sob a Licença com base \"COM ESTÁ\", SEM GARANTIAS OU CONDIÇÕES DE QUALQUER TIPO, expressas ou implícitas. Consulte a Licença para os termos que regem permissões e limitações.';

  @override
  String get copyright =>
      'Copyright © 2013,2014 William D. Kraemer - Reescrito por Muhammad Bashir Al-Noimi em 2026-08-31';

  @override
  String get fuelAmount => 'Quantidade de combustível';
}
