import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:gnawledge_admin/features/auth/presentation/providers/forgot_password_providers.dart';
import 'package:gnawledge_admin/l10n/app_localizations.dart';
import 'package:gnawledge_admin/shared/theme/colors.dart';
import 'package:go_router/go_router.dart';

Future<void> _pumpForgotPasswordPage(
  WidgetTester tester, {
  required List<Override> overrides,
  String initialLocation = '/forgot-password',
}) async {
  final router = GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/forgot-password',
        builder: (_, __) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (_, __) => const Scaffold(body: Text('LOGIN_PAGE')),
      ),
    ],
  );

  final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.light.brand),
    extensions: const <ThemeExtension<dynamic>>[AppColors.light],
  );

  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: MaterialApp.router(
        routerConfig: router,
        theme: theme,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    ),
  );

  await tester.pump();
}

Override _overrideForgotEmail(String? value) {
  return forgotEmailProvider.overrideWith((ref) => value);
}

Override _overrideForgotLoading(bool value) {
  return forgotLoadingProvider.overrideWith((ref) => value);
}

Override _overrideSendReset(Future<void> Function(String) fn) {
  return sendResetLinkActionProvider.overrideWithValue(fn);
}

void main() {
  group('ForgotPasswordPage', () {
    testWidgets('renders form when email is not submitted yet', (tester) async {
      Future<void> act(String _) async {}

      await _pumpForgotPasswordPage(
        tester,
        overrides: [
          _overrideForgotEmail(null),
          _overrideForgotLoading(false),
          _overrideSendReset(act),
        ],
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(FilledButton), findsOneWidget);
      expect(find.byIcon(Icons.key), findsOneWidget);
    });

    testWidgets('does not call action when email is invalid', (tester) async {
      var calls = 0;
      Future<void> act(String _) async {
        calls += 1;
      }

      await _pumpForgotPasswordPage(
        tester,
        overrides: [
          _overrideForgotEmail(null),
          _overrideForgotLoading(false),
          _overrideSendReset(act),
        ],
      );

      await tester.enterText(find.byType(TextFormField), 'not-an-email');
      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      expect(calls, 0);
    });

    testWidgets('calls action with trimmed email when email is valid', (
      tester,
    ) async {
      String? received;
      Future<void> act(String email) async {
        received = email;
      }

      await _pumpForgotPasswordPage(
        tester,
        overrides: [
          _overrideForgotEmail(null),
          _overrideForgotLoading(false),
          _overrideSendReset(act),
        ],
      );

      await tester.enterText(
        find.byType(TextFormField),
        '  user@example.com  ',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      expect(received, 'user@example.com');
    });

    testWidgets('disables submit and shows progress when loading', (
      tester,
    ) async {
      Future<void> act(String _) async {}

      await _pumpForgotPasswordPage(
        tester,
        overrides: [
          _overrideForgotEmail(null),
          _overrideForgotLoading(true),
          _overrideSendReset(act),
        ],
      );

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNull);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders confirmation when done email exists', (tester) async {
      Future<void> act(String _) async {}

      await _pumpForgotPasswordPage(
        tester,
        overrides: [
          _overrideForgotEmail('user@example.com'),
          _overrideForgotLoading(false),
          _overrideSendReset(act),
        ],
      );

      expect(find.byType(TextFormField), findsNothing);
      expect(find.byType(FilledButton), findsNothing);

      final context = tester.element(find.byType(ForgotPasswordPage));
      final t = AppLocalizations.of(context)!;

      expect(
        find.text(t.forgot_confirmation('user@example.com')),
        findsOneWidget,
      );
    });

    testWidgets('navigates to /login when back button is pressed', (
      tester,
    ) async {
      Future<void> act(String _) async {}

      await _pumpForgotPasswordPage(
        tester,
        overrides: [
          _overrideForgotEmail(null),
          _overrideForgotLoading(false),
          _overrideSendReset(act),
        ],
      );

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.text('LOGIN_PAGE'), findsOneWidget);
    });
  });
}
