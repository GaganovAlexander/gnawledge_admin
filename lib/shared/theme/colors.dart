import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.brand,
    required this.onBrand,
    required this.onPrimary,
    required this.textHigh,
    required this.textMedium,
    required this.surface,
    required this.pageBg,
    required this.avatarSurface,
    required this.readOnlyFill,
    required this.hoverNeutral4,
    required this.dangerous,
    required this.error,
    required this.onError,
  });

  final Color brand;
  final Color onBrand;
  final Color onPrimary;
  final Color textHigh;
  final Color textMedium;
  final Color surface;
  final Color pageBg;
  final Color avatarSurface;
  final Color readOnlyFill;
  final Color hoverNeutral4;
  final Color dangerous;
  final Color error;
  final Color onError;

  static const light = AppColors(
    brand: Color(0xFF4269BE),
    onBrand: Color(0xFFFFFFFF),
    onPrimary: Color(0xFFFFFFFF),
    textHigh: Color(0xDD000000),
    textMedium: Color(0x8A000000),
    surface: Color(0xFFFFFFFF),
    pageBg: Color(0xFFF5F6FA),
    avatarSurface: Color(0x1F000000),
    readOnlyFill: Color(0x1A000000),
    hoverNeutral4: Color(0x0A000000),
    dangerous: Color(0xE0FF0000),
    error: Color(0xFFB3261E),
    onError: Color(0xFFFFFFFF),
  );

  static const dark = AppColors(
    brand: Color(0xFF4269BE),
    onBrand: Color(0xFFFFFFFF),
    onPrimary: Color(0xFFFFFFFF),
    textHigh: Color(0xE0FFFFFF),
    textMedium: Color(0x99FFFFFF),
    pageBg: Color(0xFF0F0F12),
    surface: Color(0xFF1A1B1F),
    avatarSurface: Color(0xFF26272C),
    readOnlyFill: Color(0x1FFFFFFF),
    hoverNeutral4: Color(0x14FFFFFF),
    dangerous: Color(0xE0FF0000),
    error: Color(0xFFCF6679),
    onError: Color(0xFF000000),
  );

  @override
  AppColors copyWith({
    Color? brand,
    Color? onBrand,
    Color? onPrimary,
    Color? textHigh,
    Color? textMedium,
    Color? surface,
    Color? pageBg,
    Color? avatarSurface,
    Color? readOnlyFill,
    Color? hoverNeutral4,
    Color? dangerous,
    Color? error,
    Color? onError,
  }) {
    return AppColors(
      brand: brand ?? this.brand,
      onBrand: onBrand ?? this.onBrand,
      onPrimary: onPrimary ?? this.onPrimary,
      textHigh: textHigh ?? this.textHigh,
      textMedium: textMedium ?? this.textMedium,
      surface: surface ?? this.surface,
      pageBg: pageBg ?? this.pageBg,
      avatarSurface: avatarSurface ?? this.avatarSurface,
      readOnlyFill: readOnlyFill ?? this.readOnlyFill,
      hoverNeutral4: hoverNeutral4 ?? this.hoverNeutral4,
      dangerous: dangerous ?? this.dangerous,
      error: error ?? this.error,
      onError: onError ?? this.onError,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return this;
  }
}
