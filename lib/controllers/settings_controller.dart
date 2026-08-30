import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/units.dart';
import '../constants/app_constants.dart';

class SettingsController extends GetxController {
  final _unit = Units.mpg.obs;
  final _currency = AppConstants.defaultCurrency.obs;
  final _language = AppConstants.defaultLanguage.obs;
  final _themeMode = ThemeMode.system.obs;
  final requireCost = true.obs;
  final displayCost = true.obs;
  final displayNotes = true.obs;

  Units get unit => _unit.value;
  String get currency => _currency.value;
  String get language => _language.value;
  ThemeMode get themeMode => _themeMode.value;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _unit.value = Units.fromValue(prefs.getInt(AppConstants.keyUnit) ?? AppConstants.defaultUnit);
    _currency.value = prefs.getString(AppConstants.keyCurrency) ?? AppConstants.defaultCurrency;
    _language.value = prefs.getString(AppConstants.keyLanguage) ?? AppConstants.defaultLanguage;
    
    final themeIndex = prefs.getInt(AppConstants.keyTheme) ?? 0;
    _themeMode.value = ThemeMode.values[themeIndex];
    
    requireCost.value = prefs.getBool(AppConstants.keyRequireCost) ?? true;
    displayCost.value = prefs.getBool(AppConstants.keyDisplayCost) ?? true;
    displayNotes.value = prefs.getBool(AppConstants.keyDisplayNotes) ?? true;
  }

  Future<void> setUnit(Units unit) async {
    _unit.value = unit;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.keyUnit, unit.value);
  }

  Future<void> setCurrency(String currency) async {
    _currency.value = currency;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.keyCurrency, currency);
  }

  Future<void> setLanguage(String language) async {
    _language.value = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.keyLanguage, language);
    
    final locale = _getLocaleFromString(language);
    Get.updateLocale(locale);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode.value = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.keyTheme, mode.index);
    Get.changeThemeMode(mode);
  }

  Future<void> setRequireCost(bool value) async {
    requireCost.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyRequireCost, value);
  }

  Future<void> setDisplayCost(bool value) async {
    displayCost.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyDisplayCost, value);
  }

  Future<void> setDisplayNotes(bool value) async {
    displayNotes.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyDisplayNotes, value);
  }

  Locale _getLocaleFromString(String langCode) {
    switch (langCode) {
      case 'ar':
        return const Locale('ar');
      case 'tr':
        return const Locale('tr');
      default:
        return const Locale('en');
    }
  }
}
