import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paddle_jakarta/app/app.locator.dart';
import 'package:paddle_jakarta/services/theme_service.dart';

class SportyElegantMinimalTheme {
  final TextTheme textTheme;

  SportyElegantMinimalTheme(this.textTheme);

  static double offsetVariable = 10;

  static const Color moonlightBlue = Color.fromARGB(255, 117, 169, 229);
  static const Color moonlightBlueUnderDark = Color.fromARGB(255, 99, 168, 246);
  static const Color primaryContainerLight = Color.fromARGB(255, 212, 225, 241);
  static const Color secondaryLight = Color.fromARGB(255, 218, 165, 32);
  static const Color secondaryContainerLight =
      Color.fromARGB(255, 245, 215, 154);
  static const Color onSecondaryContainerLight =
      Color.fromARGB(255, 63, 48, 29);
  static const Color surfaceContainerHighestLight =
      Color.fromARGB(255, 224, 224, 224);
  static const Color onSurfaceVariantLight = Color.fromARGB(255, 117, 117, 117);
  static const Color outlineLight = Color.fromARGB(255, 189, 189, 189);

  static const Color primaryContainerDark = moonlightBlue;
  static const Color secondaryDark = secondaryContainerLight;
  static const Color secondaryContainerDark = onSecondaryContainerLight;
  static const Color surfaceContainerHighestDark =
      Color.fromARGB(255, 64, 64, 64);
  static const Color onSurfaceVariantDark = Color.fromARGB(255, 204, 204, 204);
  static const Color outlineDark = onSurfaceVariantLight;

  static Color darkButtonBackground = darkScheme().surface.withOpacity(0.75);
  static Color lightButtonBackground = lightScheme().surface.withOpacity(0.75);

  static LinearGradient appBackgroundGradient(Color backgroundColor) {
    return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          backgroundColor,
          const Color.fromARGB(255, 70, 113, 162).withOpacity(0.85),
        ],
        stops: const [
          0.4,
          1,
        ]);
  }

  static ColorScheme lightScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: moonlightBlue,
      onPrimary: Colors.black,
      primaryContainer: primaryContainerLight,
      onPrimaryContainer: moonlightBlue,
      secondary: secondaryLight,
      onSecondary: Colors.black,
      secondaryContainer: secondaryContainerLight,
      onSecondaryContainer: onSecondaryContainerLight,
      surface: Colors.white,
      onSurface: const Color.fromARGB(255, 48, 48, 48),
      error: const Color.fromARGB(255, 176, 0, 32),
      onError: Colors.white,
      surfaceContainerHighest: surfaceContainerHighestLight,
      onSurfaceVariant: onSurfaceVariantLight,
      outline: outlineLight,
      shadow: Colors.black.withOpacity(0.2),
      scrim: Colors.black.withOpacity(0.2),
      inverseSurface: moonlightBlue,
      inversePrimary: const Color.fromARGB(255, 53, 122, 189),
      surfaceBright: Colors.white,
    );
  }

  ThemeData light() {
    final base = ThemeData.light();
    final buttonHeight = base.elevatedButtonTheme.style?.minimumSize?.resolve({})?.height ?? 48.0;
    return base.copyWith(
      colorScheme: lightScheme(),
      primaryColor: moonlightBlue,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        backgroundColor: lightScheme().primary.withOpacity(0),
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
      textTheme: base.textTheme.apply(
        fontFamily: GoogleFonts.poppins().fontFamily,
        bodyColor: lightScheme().onSurface,
        displayColor: lightScheme().onSurface,
      ),
      primaryTextTheme: base.primaryTextTheme.apply(
        fontFamily: GoogleFonts.poppins().fontFamily,
        bodyColor: lightScheme().onSurface,
        displayColor: lightScheme().onSurface,
      ),
      iconTheme: IconThemeData(color: lightScheme().primary),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: WidgetStateTextStyle.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.focused)) {
              return TextStyle(color: lightScheme().onSurface);
            }
            return TextStyle(color: lightScheme().onSurface);
          },
        ),
        filled: true,
        hintStyle: const TextStyle(fontSize: 12),
        fillColor: Colors.white.withOpacity(0.5),
        labelStyle: TextStyle(color: lightScheme().onSurface),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent),
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
          backgroundColor: lightButtonBackground,
          minimumSize: Size(double.infinity, buttonHeight ??  48.0),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: lightScheme().primary,
        selectionColor: lightScheme().primary.withOpacity(0.5),
        selectionHandleColor: lightScheme().primary,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
          color: moonlightBlue, linearMinHeight: buttonHeight),
    );
  }

  static ColorScheme darkScheme() {
    return ColorScheme(
      brightness: Brightness.dark,
      primary: moonlightBlueUnderDark,
      onPrimary: Colors.white,
      primaryContainer: primaryContainerDark,
      onPrimaryContainer: Colors.white,
      secondary: secondaryDark,
      onSecondary: onSecondaryContainerLight,
      secondaryContainer: secondaryContainerDark,
      onSecondaryContainer: secondaryDark,
      surface: const Color.fromARGB(255, 30, 30, 30),
      onSurface: Colors.white,
      error: const Color.fromARGB(255, 207, 102, 121),
      onError: Colors.black,
      surfaceContainerHighest: surfaceContainerHighestDark,
      onSurfaceVariant: onSurfaceVariantDark,
      outline: outlineDark,
      shadow: Colors.black.withOpacity(0.5),
      scrim: Colors.black.withOpacity(0.5),
      inverseSurface: Colors.white,
      inversePrimary: moonlightBlueUnderDark,
      surfaceBright: Colors.black,
    );
  }

  ThemeData dark() {
    final base = ThemeData.dark();
    final buttonHeight = base.elevatedButtonTheme.style?.minimumSize?.resolve({})?.height ?? 48.0;
    return base.copyWith(
      colorScheme: darkScheme(),
      primaryColor: darkScheme().primary,
      scaffoldBackgroundColor: Colors.transparent,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkScheme().primary.withOpacity(0),
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
      textTheme: base.textTheme.apply(
        fontFamily: GoogleFonts.poppins().fontFamily,
        bodyColor: darkScheme().onSurface,
        displayColor: darkScheme().onSurface,
      ),
      primaryTextTheme: base.primaryTextTheme.apply(
        fontFamily: GoogleFonts.poppins().fontFamily,
        bodyColor: darkScheme().onSurface,
        displayColor: darkScheme().onSurface,
      ),
      iconTheme: IconThemeData(
        color: darkScheme().onPrimary,
        shadows: [
          Shadow(
            color: moonlightBlueUnderDark.withOpacity(0.5),
            blurRadius: 8.0,
          ),
        ],
      ),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: WidgetStateTextStyle.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.focused)) {
              return TextStyle(color: darkScheme().onSurface);
            }
            return TextStyle(color: darkScheme().onSurface);
          },
        ),
        filled: true,
        hintStyle: const TextStyle(fontSize: 12),
        fillColor: const Color.fromARGB(255, 30, 30, 30).withOpacity(0.5),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        labelStyle: TextStyle(color: darkScheme().onSurface),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkScheme().primary),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: darkButtonBackground,
          minimumSize: Size(double.infinity, buttonHeight ??  48.0),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: darkScheme().primary,
        selectionColor: darkScheme().primary.withOpacity(0.75),
        selectionHandleColor: darkScheme().primary,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
          color: moonlightBlueUnderDark, linearMinHeight: buttonHeight),
    );
  }
}
