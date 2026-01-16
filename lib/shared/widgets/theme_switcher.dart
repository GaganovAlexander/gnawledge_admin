import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/app/di.dart';
import 'package:gnawledge_admin/l10n/app_localizations.dart';
import 'package:gnawledge_admin/shared/theme/theme_mode_provider.dart';

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final mode = ref.watch(themeModeProvider);
    final notifier = ref.read(themeModeProvider.notifier);

    String label;
    switch (mode) {
      case ThemeMode.light:
        label = t.theme_light;
      case ThemeMode.dark:
        label = t.theme_dark;
      case ThemeMode.system:
        label = t.theme_system;
    }

    return PopupMenuButton<ThemeMode>(
      tooltip: t.change_theme,
      onOpened: () => ref.read(isPopupOpenProvider.notifier).state = true,
      onCanceled: () => ref.read(isPopupOpenProvider.notifier).state = false,
      onSelected: (v) {
        ref.read(isPopupOpenProvider.notifier).state = false;
        notifier.state = v;
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: ThemeMode.system, child: Text(t.theme_system)),
        PopupMenuItem(value: ThemeMode.light, child: Text(t.theme_light)),
        PopupMenuItem(value: ThemeMode.dark, child: Text(t.theme_dark)),
      ],
      child: Chip(
        label: Text(label),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
    );
  }
}
