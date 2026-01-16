import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/auth/presentation/pages/auth_shell.dart';
import 'package:gnawledge_admin/l10n/app_localizations.dart';
import 'package:gnawledge_admin/shared/theme/colors.dart';

void main() {
  testWidgets('AuthShell renders child and top controls', (tester) async {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.light.brand),
      extensions: const [AppColors.light],
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: theme,
          home: const AuthShell(child: Text('CONTENT')),
        ),
      ),
    );

    expect(find.text('CONTENT'), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
  });
}
