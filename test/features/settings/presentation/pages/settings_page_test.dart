import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/settings/presentation/pages/settings_page.dart';
import 'package:gnawledge_admin/l10n/app_localizations.dart';
import 'package:gnawledge_admin/shared/theme/colors.dart';
import 'package:gnawledge_admin/shared/widgets/language_switcher.dart';
import 'package:gnawledge_admin/shared/widgets/theme_switcher.dart';

void main() {
  testWidgets('SettingsPage renders language and theme switchers',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.light.brand),
            extensions: const [AppColors.light],
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SettingsPage(),
        ),
      ),
    );

    expect(find.byType(LanguageSwitcher), findsOneWidget);
    expect(find.byType(ThemeSwitcher), findsOneWidget);
  });

  testWidgets('SettingsPage shows correct labels', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.light.brand),
            extensions: const [AppColors.light],
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SettingsPage(),
        ),
      ),
    );

    final context = tester.element(find.byType(SettingsPage));
    final t = AppLocalizations.of(context)!;

    expect(find.text(t.change_language), findsOneWidget);
    expect(find.text(t.change_theme), findsOneWidget);
  });
}
