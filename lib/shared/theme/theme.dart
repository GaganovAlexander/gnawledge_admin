import 'package:flutter/material.dart';
import 'package:gnawledge_admin/shared/theme/colors.dart';
import 'package:gnawledge_admin/shared/theme/typography.dart';

ThemeData buildTheme() {
  final base = ThemeData(useMaterial3: true);
  return base.copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.brand),
    textTheme: buildTextTheme(),
    scaffoldBackgroundColor: const Color(0xFFF7F7FB),
  );
}
