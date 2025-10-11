import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/app/di.dart';
import 'package:gnawledge_admin/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:gnawledge_admin/features/auth/presentation/pages/login_page.dart';
import 'package:go_router/go_router.dart';

class _HomeStub extends StatelessWidget {
  const _HomeStub();
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

final routerProvider = Provider<GoRouter>((ref) {
  final repo = ref.read(authRepositoryProvider);

  const publicPaths = <String>[
    '/login',
    '/forgot-password',
  ];

  bool isPublic(String loc) => publicPaths.any((p) => loc.startsWith(p));

  FutureOr<String?> guard(BuildContext context, GoRouterState state) async {
    final loc = state.matchedLocation;

    if (repo.isAccessValid()) {
      if (isPublic(loc)) return '/';
      return null;
    }

    if (isPublic(loc)) return null;

    final refresh = repo.currentRefresh();
    if (refresh != null && refresh.isNotEmpty) {
      try {
        await repo.refresh(refresh);

        return null;
      } catch (_) {}
    }

    final from = Uri.encodeComponent(state.uri.toString());
    return '/login?from=$from';
  }

  return GoRouter(
    initialLocation: '/login',
    redirect: guard,
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: _HomeStub()),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: LoginPage()),
      ),
      GoRoute(
        path: '/forgot-password',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: ForgotPasswordPage()),
      ),
    ],
  );
});
