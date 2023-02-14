import 'package:flutter/material.dart';
import 'package:listinha/src/configuration/services/configuration_service.dart';

class AppStore {
  // 1st - Public var:
  final themeMode = ValueNotifier(ThemeMode.system);
  final syncDate = ValueNotifier<DateTime?>(null);

  // 2nd - Private var.
  final ConfigurationService _configurationService;

  AppStore(this._configurationService) {
    init();
  }
  // 3rd - Constructor

  // 4th - Functions: order of usage
  void init() {
    final model = _configurationService.getConfiguration();
    syncDate.value = model.syncDate;
    themeMode.value = _getThemeModeByName(model.themeModeName);
  }

  void save() {
    _configurationService.saveConfiguration(
      themeMode.value.name,
      syncDate.value,
    );
  }

  void changeThemeMode(ThemeMode? mode) {
    if (mode != null) {
      themeMode.value = mode;
      save();
    }
  }

  void setSyncDate(DateTime date) {
    syncDate.value = date;
    save();
  }

  void deleteApp() {
    _configurationService.deleteAll();
  }

  ThemeMode _getThemeModeByName(String name) {
    return ThemeMode.values.firstWhere((mode) => mode.name == name);
  }
}
