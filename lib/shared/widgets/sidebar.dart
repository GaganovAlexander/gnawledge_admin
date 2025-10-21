import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/app/di.dart';
import 'package:gnawledge_admin/features/account/presentation/dialogs/account_settings_dialog.dart';
import 'package:gnawledge_admin/l10n/app_localizations.dart';
import 'package:gnawledge_admin/shared/theme/colors.dart';
import 'package:go_router/go_router.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});

  bool _sel(BuildContext c, String path) =>
      GoRouterState.of(c).matchedLocation.startsWith(path);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    Widget navItem({
      required IconData icon,
      required String label,
      required String path,
    }) {
      final selected = _sel(context, path);
      return InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => context.go(path),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? cs.primary.withValues(alpha: .08) : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: selected ? cs.primary : cs.onSurfaceVariant,
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: selected ? cs.primary : cs.onSurface,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Future<void> logout() async {
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(t.logout_title),
          content: Text(t.logout_body),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(t.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(t.logout),
            ),
          ],
        ),
      );
      if (ok != true) return;
      await ref.read(authRepositoryProvider).signOut();
      if (!context.mounted) return;
      context.go('/login');
    }

    return Container(
      width: 240,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          right: BorderSide(
            color: AppColors.textHigh.withValues(alpha: .06),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6, bottom: 16),
            child: Text(
              t.brand_title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 6),
          navItem(
            icon: Icons.dashboard_outlined,
            label: t.nav_dashboard,
            path: '/dashboard',
          ),
          const SizedBox(height: 4),
          navItem(
            icon: Icons.group_outlined,
            label: t.nav_users,
            path: '/users',
          ),
          const SizedBox(height: 4),
          navItem(
            icon: Icons.settings_outlined,
            label: t.nav_settings,
            path: '/settings',
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: () async {
              await showDialog<bool>(
                context: context,
                barrierColor: AppColors.textHigh.withValues(alpha: .3),
                builder: (_) => const AccountSettingsDialog(),
              );
            },
            icon: const Icon(Icons.account_circle_outlined, size: 18),
            label: Text(t.my_account),
          ),
          const SizedBox(height: 4),
          TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: cs.error),
            onPressed: logout,
            icon: const Icon(Icons.logout, size: 18),
            label: Text(t.logout),
          ),
        ],
      ),
    );
  }
}
