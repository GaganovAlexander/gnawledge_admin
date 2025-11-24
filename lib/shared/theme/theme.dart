import 'package:flutter/material.dart';
import 'package:gnawledge_admin/shared/theme/colors.dart';

ThemeData buildLightTheme() {
  const colors = AppColors.light;

  return ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    extensions: const [
      AppColors.light,
    ],
    scaffoldBackgroundColor: colors.pageBg,
    canvasColor: colors.pageBg,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: colors.textHigh),
      bodyMedium: TextStyle(color: colors.textHigh),
      bodySmall: TextStyle(color: colors.textMedium),
      titleLarge: TextStyle(color: colors.textHigh),
      titleMedium: TextStyle(color: colors.textHigh),
      titleSmall: TextStyle(color: colors.textMedium),
    ),
    dividerColor: colors.hoverNeutral4,
    cardColor: colors.surface,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colors.readOnlyFill,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: colors.hoverNeutral4),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colors.hoverNeutral4),
      ),
      labelStyle: TextStyle(color: colors.textMedium),
      hintStyle: TextStyle(color: colors.textMedium),
    ),
    colorScheme: ColorScheme.light(
      primary: colors.brand,
      onPrimary: colors.onBrand,
      error: colors.error,
      onError: colors.onError,
      surface: colors.surface,
      onSurface: colors.textHigh,
    ),
  );
}

ThemeData buildDarkTheme() {
  const colors = AppColors.dark;

  return ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    extensions: const [
      AppColors.dark,
    ],
    scaffoldBackgroundColor: colors.pageBg,
    canvasColor: colors.pageBg,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: colors.textHigh),
      bodyMedium: TextStyle(color: colors.textHigh),
      bodySmall: TextStyle(color: colors.textMedium),
      titleLarge: TextStyle(color: colors.textHigh),
      titleMedium: TextStyle(color: colors.textHigh),
      titleSmall: TextStyle(color: colors.textMedium),
    ),
    dividerColor: colors.hoverNeutral4,
    cardColor: colors.surface,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colors.readOnlyFill,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: colors.hoverNeutral4),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colors.hoverNeutral4),
      ),
      labelStyle: TextStyle(color: colors.textMedium),
      hintStyle: TextStyle(color: colors.textMedium),
    ),
    colorScheme: ColorScheme.dark(
      primary: colors.brand,
      onPrimary: colors.onBrand,
      error: colors.error,
      onError: colors.onError,
      surface: colors.surface,
      onSurface: colors.textHigh,
    ),
  );
}
