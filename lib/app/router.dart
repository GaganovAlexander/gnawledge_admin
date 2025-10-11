import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/app/di.dart';
import 'package:gnawledge_admin/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:gnawledge_admin/features/auth/presentation/pages/login_page.dart';
import 'package:gnawledge_admin/shared/widgets/sidebar.dart';
import 'package:go_router/go_router.dart';

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) => Center(child: Text(title));
}

final routerProvider = Provider<GoRouter>((ref) {
  final repo = ref.read(authRepositoryProvider);

  const publicPaths = <String>['/login', '/forgot-password'];
  bool isPublic(String loc) => publicPaths.any((p) => loc.startsWith(p));

  FutureOr<String?> guard(BuildContext context, GoRouterState state) async {
    final loc = state.matchedLocation;

    if (repo.isAccessValid()) {
      if (isPublic(loc)) return '/dashboard';
      return null;
    }

    if (isPublic(loc)) return null;

    final r = repo.currentRefresh();
    if (r != null && r.isNotEmpty) {
      try {
        await repo.refresh(r);
        return null;
      } catch (_) {}
    }
    final from = Uri.encodeComponent(state.uri.toString());
    return '/login?from=$from';
  }

  return GoRouter(
    initialLocation: '/users',
    redirect: guard,
    routes: [
      GoRoute(
        path: '/login',
        pageBuilder: (c, s) => const NoTransitionPage(child: LoginPage()),
      ),
      GoRoute(
        path: '/forgot-password',
        pageBuilder: (c, s) =>
            const NoTransitionPage(child: ForgotPasswordPage()),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            body: Row(
              children: [
                const Sidebar(),
                Expanded(
                  child: ColoredBox(
                    color: const Color(0xFFF7F7FB),
                    child: child,
                  ),
                ),
              ],
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            pageBuilder: (c, s) => const NoTransitionPage(
              child: _PlaceholderPage(title: 'Dashboard'),
            ),
          ),
          GoRoute(
            path: '/users',
            pageBuilder: (c, s) => const NoTransitionPage(
              child: _PlaceholderPage(title: 'Users'),
            ),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (c, s) => const NoTransitionPage(
              child: _PlaceholderPage(title: 'Settings'),
            ),
          ),
        ],
      ),
    ],
  );
});
