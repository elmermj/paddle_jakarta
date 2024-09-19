import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paddle_jakarta/app/app.locator.dart';
import 'package:paddle_jakarta/services/theme_service.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ThemeService -', () {
    late ThemeService themeService;
    TestWidgetsFlutterBinding.ensureInitialized();

    setUp(() {
      registerServices();
      themeService = ThemeService();
    });

    tearDown(() => locator.reset());

    test('Initial dark mode state matches platform brightness', () {
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      expect(themeService.isDarkMode, equals(brightness == Brightness.dark));
    });

    test('toggleTheme changes isDarkMode', () {
      final initialState = themeService.isDarkMode;
      themeService.toggleTheme();
      expect(themeService.isDarkMode, equals(!initialState));
    });

    test('themeData returns correct theme based on isDarkMode', () {
      themeService.toggleTheme();
      final isDark = themeService.isDarkMode;
      final theme = themeService.themeData;
      expect(theme, isDark ? isA<ThemeData>().having((t) => t.brightness, 'brightness', Brightness.dark)
                           : isA<ThemeData>().having((t) => t.brightness, 'brightness', Brightness.light));
    });

    test('ThemeService notifies listeners when theme changes', () {
      var notified = false;
      themeService.addListener(() => notified = true);
      themeService.toggleTheme();
      expect(notified, isTrue);
    });

    test('buttonHeight is nullable and can be set through constructor', () {
      final customThemeService = ThemeService(buttonHeight: 50);
      expect(customThemeService.buttonHeight, equals(50));
      expect(themeService.buttonHeight, isNull);
    });
  });
}
