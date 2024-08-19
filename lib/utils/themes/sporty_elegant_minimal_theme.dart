import 'package:flutter/material.dart';

class SportyElegantMinimalTheme {
  final TextTheme textTheme;

  const SportyElegantMinimalTheme(this.textTheme);

  // Define a moonlight blue color
  static const Color moonlightBlue = Color(0xFF4A90E2); // A calming blue

  static MaterialColor primarySwatch = const MaterialColor(
    0xFF4A90E2, // Moonlight Blue
    {
      50: Color(0xFFE1E8F0),
      100: Color(0xFFB0C4DE),
      200: Color(0xFF8AB0D4),
      300: Color(0xFF4A90E2),
      400: Color(0xFF357ABD),
      500: Color(0xFF4A90E2),
      600: Color(0xFF4388D4),
      700: Color(0xFF3173A9),
      800: Color(0xFF1F5A8D),
      900: Color(0xFF154F77),
    },
  );

  static ColorScheme lightScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: moonlightBlue,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFD4E1F1), // Lightened version
      onPrimaryContainer: moonlightBlue,
      secondary: const Color(0xFFDAA520), // Golden accents for elegance
      onSecondary: Colors.white,
      secondaryContainer: const Color(0xFFF5D79A),
      onSecondaryContainer: const Color(0xFF3F301D),
      surface: Colors.white,
      onSurface: moonlightBlue,
      error: const Color(0xFFB00020),
      onError: Colors.white,
      surfaceContainerHighest: const Color(0xFFE0E0E0),
      onSurfaceVariant: const Color(0xFF757575),
      outline: const Color(0xFFBDBDBD),
      shadow: Colors.black.withOpacity(0.2),
      scrim: Colors.black.withOpacity(0.2),
      inverseSurface: moonlightBlue,
      inversePrimary: Color(0xFF357ABD),
    );
  }

  ThemeData light() {
    final base = ThemeData.light();
    return base.copyWith(
      colorScheme: lightScheme(),
      primaryColor: primarySwatch,
      scaffoldBackgroundColor: lightScheme().surface,
      appBarTheme: AppBarTheme(
        backgroundColor: lightScheme().primary,
        foregroundColor: lightScheme().onPrimary,
        elevation: 0,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: lightScheme().primary,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      textTheme: textTheme.apply(
        bodyColor: lightScheme().onSurface,
        displayColor: lightScheme().onSurface,
      ),
      iconTheme: IconThemeData(color: lightScheme().primary),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: lightScheme().outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: lightScheme().outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: lightScheme().primary),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          surfaceTintColor: lightScheme().onPrimary
        )
      ),
      primaryTextTheme: base.primaryTextTheme.apply(
        bodyColor: lightScheme().onSurface,
        displayColor: lightScheme().onSurface,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: moonlightBlue,
      )
    );
  }

  static ColorScheme darkScheme() {
    return ColorScheme(
      brightness: Brightness.dark,
      primary: moonlightBlue,
      onPrimary: Colors.white,
      primaryContainer: moonlightBlue,
      onPrimaryContainer: Colors.white,
      secondary: const Color(0xFFF5D79A),
      onSecondary: const Color(0xFF3F301D),
      secondaryContainer: const Color(0xFF3F301D),
      onSecondaryContainer: const Color(0xFFF5D79A),
      surface: const Color(0xFF1E1E1E),
      onSurface: Colors.white,
      error: const Color(0xFFCF6679),
      onError: Colors.black,
      surfaceContainerHighest: const Color(0xFF404040),
      onSurfaceVariant: const Color(0xFFCCCCCC),
      outline: const Color(0xFF757575),
      shadow: Colors.black.withOpacity(0.5),
      scrim: Colors.black.withOpacity(0.5),
      inverseSurface: Colors.white,
      inversePrimary: moonlightBlue,
    );
  }

  ThemeData dark() {
    final base = ThemeData.dark();
    return base.copyWith(
      colorScheme: darkScheme(),
      primaryColor: darkScheme().primary,
      scaffoldBackgroundColor: darkScheme().surface,
      appBarTheme: AppBarTheme(
        backgroundColor: darkScheme().primary,
        foregroundColor: darkScheme().onPrimary,
        elevation: 0,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: darkScheme().primary,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      textTheme: textTheme.apply(
        bodyColor: darkScheme().onSurface,
        displayColor: darkScheme().onSurface,
      ),
      iconTheme: IconThemeData(
        color: darkScheme().onPrimary,
        shadows: [
          Shadow(
            color: moonlightBlue.withOpacity(0.5), // Glow color
            blurRadius: 8.0, // Adjust blur radius
          ),
        ],
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        contentPadding: const EdgeInsets.all(12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkScheme().outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkScheme().outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkScheme().primary),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          surfaceTintColor: darkScheme().onPrimary
        )
      ),
      primaryTextTheme: base.primaryTextTheme.apply(
        bodyColor: darkScheme().onSurface,
        displayColor: darkScheme().onSurface,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: moonlightBlue,
      )
    );
  }
}
