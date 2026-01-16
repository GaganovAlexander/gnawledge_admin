import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/users/presentation/widgets/status_badge.dart';
import 'package:gnawledge_admin/l10n/app_localizations.dart';
import 'package:gnawledge_admin/shared/theme/colors.dart';

void main() {
  testWidgets('StatusBadge shows active status', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
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
        home: const Scaffold(
          body: StatusBadge(status: 'active'),
        ),
      ),
    );

    final context = tester.element(find.byType(StatusBadge));
    final t = AppLocalizations.of(context)!;

    expect(find.text(t.status_active), findsOneWidget);
  });

  testWidgets('StatusBadge shows inactive status', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
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
        home: const Scaffold(
          body: StatusBadge(status: 'inactive'),
        ),
      ),
    );

    final context = tester.element(find.byType(StatusBadge));
    final t = AppLocalizations.of(context)!;

    expect(find.text(t.status_inactive), findsOneWidget);
  });

  testWidgets('StatusBadge is case insensitive', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
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
        home: const Scaffold(
          body: StatusBadge(status: 'ACTIVE'),
        ),
      ),
    );

    final context = tester.element(find.byType(StatusBadge));
    final t = AppLocalizations.of(context)!;

    expect(find.text(t.status_active), findsOneWidget);
  });
}
