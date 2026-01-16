import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/auth/presentation/pages/login_page.dart';
import 'package:gnawledge_admin/features/auth/presentation/providers/auth_providers.dart';
import 'package:gnawledge_admin/l10n/app_localizations.dart';
import 'package:gnawledge_admin/shared/theme/colors.dart';
import 'package:go_router/go_router.dart';

Future<void> _pumpLoginPage(
  WidgetTester tester, {
  required List<Override> overrides,
  String initialLocation = '/login',
}) async {
  final router = GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/login',
        builder: (_, __) => const Scaffold(body: LoginPage()),
      ),
      GoRoute(
        path: '/users',
        builder: (_, __) => const Scaffold(body: Text('USERS_PAGE')),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (_, __) => const Scaffold(body: Text('FORGOT_PASSWORD_PAGE')),
      ),
    ],
  );

  final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    extensions: const <ThemeExtension<dynamic>>[AppColors.dark],
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

Override _overrideLoading(bool value) {
  return authLoadingProvider.overrideWith((ref) => value);
}

Override _overrideSignIn(Future<void> Function(String, String) fn) {
  return signInActionProvider.overrideWith((ref) => fn);
}

void main() {
  group('LoginPage', () {
    testWidgets('renders login form', (tester) async {
      Future<void> fakeSignIn(String _, String __) async {}

      await _pumpLoginPage(
        tester,
        overrides: [_overrideSignIn(fakeSignIn), _overrideLoading(false)],
      );

      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(FilledButton), findsOneWidget);
      expect(find.byIcon(Icons.login), findsOneWidget);
    });

    testWidgets('does not call signIn when form is invalid', (tester) async {
      var calls = 0;
      Future<void> fakeSignIn(String _, String __) async {
        calls += 1;
      }

      await _pumpLoginPage(
        tester,
        overrides: [_overrideSignIn(fakeSignIn), _overrideLoading(false)],
      );

      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      expect(calls, 0);
      expect(find.text('USERS_PAGE'), findsNothing);
    });

    testWidgets('navigates to /users on successful signIn', (tester) async {
      Future<void> fakeSignIn(String _, String __) async {}

      await _pumpLoginPage(
        tester,
        overrides: [_overrideSignIn(fakeSignIn), _overrideLoading(false)],
      );

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'admin@example.com',
      );
      await tester.enterText(find.byType(TextFormField).at(1), 'admin123');

      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      expect(find.text('USERS_PAGE'), findsOneWidget);
    });

    testWidgets('navigates to "from" query param when present', (tester) async {
      Future<void> fakeSignIn(String _, String __) async {}

      await _pumpLoginPage(
        tester,
        initialLocation: '/login?from=/forgot-password',
        overrides: [_overrideSignIn(fakeSignIn), _overrideLoading(false)],
      );

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'admin@example.com',
      );
      await tester.enterText(find.byType(TextFormField).at(1), 'admin123');

      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      expect(find.text('FORGOT_PASSWORD_PAGE'), findsOneWidget);
    });

    testWidgets('shows SnackBar on signIn error', (tester) async {
      Future<void> fakeSignIn(String _, String __) async {
        throw Exception('Invalid credentials');
      }

      await _pumpLoginPage(
        tester,
        overrides: [_overrideSignIn(fakeSignIn), _overrideLoading(false)],
      );

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'admin@example.com',
      );
      await tester.enterText(find.byType(TextFormField).at(1), 'wrong');

      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      final context = tester.element(find.byType(LoginPage));
      final t = AppLocalizations.of(context)!;

      expect(find.text(t.validation_invalid_credentials), findsOneWidget);
    });

    testWidgets('disables submit and shows progress when loading', (
      tester,
    ) async {
      Future<void> fakeSignIn(String _, String __) async {}

      await _pumpLoginPage(
        tester,
        overrides: [_overrideSignIn(fakeSignIn), _overrideLoading(true)],
      );

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNull);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('toggles password visibility', (tester) async {
      Future<void> fakeSignIn(String _, String __) async {}

      await _pumpLoginPage(
        tester,
        overrides: [_overrideSignIn(fakeSignIn), _overrideLoading(false)],
      );

      expect(find.byIcon(Icons.visibility), findsOneWidget);

      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();

      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });
  });
}
