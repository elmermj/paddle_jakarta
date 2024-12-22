import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paddle_jakarta/utils/themes/sporty_elegant_minimal_theme.dart';
import 'package:stacked/stacked.dart';

class ThemeService extends ChangeNotifier with ListenableServiceMixin {
  double? buttonHeight;
  ThemeService({this.buttonHeight}) {
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    _isDarkMode.value = brightness == Brightness.dark;
    listenToReactiveValues([_isDarkMode]);
  }

  final ReactiveValue<bool> _isDarkMode = ReactiveValue<bool>(false);

  bool get isDarkMode => _isDarkMode.value;

  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    notifyListeners();
  }

  ThemeData get themeData {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:_isDarkMode.value? Colors.black: Colors.white,
        statusBarIconBrightness: _isDarkMode.value? Brightness.light :Brightness.dark,
        statusBarBrightness: _isDarkMode.value? Brightness.light : Brightness.dark,
        systemNavigationBarColor: const Color.fromARGB(255, 57, 97, 142).withOpacity(1),
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
    return _isDarkMode.value
      ? SportyElegantMinimalTheme(const TextTheme()).dark()
      : SportyElegantMinimalTheme(const TextTheme()).light();
  }
}
