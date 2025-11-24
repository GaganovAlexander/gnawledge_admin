import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/features/settings/presentation/widgets/language_switcher.dart';
import 'package:gnawledge_admin/features/settings/presentation/widgets/theme_switcher.dart';
import 'package:gnawledge_admin/l10n/app_localizations.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.change_language,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const LanguageSwitcher(),
            const SizedBox(height: 24),
            Text(t.change_theme,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const ThemeSwitcher(),
          ],
        ),
      ),
    );
  }
}
