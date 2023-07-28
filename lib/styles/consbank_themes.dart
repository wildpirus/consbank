import 'package:flutter/material.dart';
import 'package:consbank/styles/styles.dart';

class ConsbankThemes {
  static ThemeData ligth = ThemeData(
      brightness: Brightness.light,
      primaryColor: ConsbankColors.primary,
      primaryColorDark: ConsbankColors.secondary,
      primaryColorLight: ConsbankColors.primaryLigth,
      checkboxTheme: CheckboxThemeData(fillColor: MaterialStateProperty.all(ConsbankColors.green)),
      indicatorColor: ConsbankColors.greyBackground,
      // iconTheme: IconThemeData(color: ConsColors.secondary),
      // fontFamily: 'Roboto',
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 35, letterSpacing: -0.03),
        displayMedium: TextStyle(fontSize: 30, letterSpacing: -0.03),
        displaySmall: TextStyle(fontSize: 27, letterSpacing: -0.03),
        headlineMedium: TextStyle(fontSize: 24, letterSpacing: -0.03),
        headlineSmall: TextStyle(fontSize: 20, letterSpacing: -0.03),
        titleLarge: TextStyle(fontSize: 18, letterSpacing: -0.03),
        titleMedium: TextStyle(fontSize: 16, letterSpacing: -0.03),
        titleSmall: TextStyle(fontSize: 15, letterSpacing: -0.03),
        bodyLarge: TextStyle(fontSize: 14, letterSpacing: -0.03),
        bodyMedium: TextStyle(fontSize: 12, letterSpacing: -0.03),
        bodySmall: TextStyle(fontSize: 11, letterSpacing: -0.03),
        labelLarge: TextStyle(fontSize: 16, color: Colors.white),
        labelSmall: TextStyle(fontSize: 9, letterSpacing: -0.03),
      ),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(
            secondary: ConsbankColors.accent,
          )
          .copyWith(error: ConsbankColors.red));
}
