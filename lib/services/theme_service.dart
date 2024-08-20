import 'package:flutter/material.dart';
import 'package:paddle_jakarta/utils/themes/sporty_elegant_minimal_theme.dart';
import 'package:stacked/stacked.dart';

class ThemeService extends ChangeNotifier with ListenableServiceMixin {
  ThemeService() {
    // Initialize with system theme mode
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    _isDarkMode.value = brightness == Brightness.dark;
    listenToReactiveValues([_isDarkMode]);
  }

  final ReactiveValue<bool> _isDarkMode = ReactiveValue<bool>(false);

  bool get isDarkMode => _isDarkMode.value;

  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    notifyListeners();
  }

  ThemeData get themeData => _isDarkMode.value
      ? SportyElegantMinimalTheme(const TextTheme()).dark()
      : SportyElegantMinimalTheme(const TextTheme()).light();
}
