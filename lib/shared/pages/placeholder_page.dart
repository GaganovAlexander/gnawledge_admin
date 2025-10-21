import 'package:flutter/material.dart';
import 'package:gnawledge_admin/l10n/app_localizations.dart';
import 'package:gnawledge_admin/shared/widgets/language_switcher.dart';

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({
    required this.titleKey,
    super.key,
  });
  final String titleKey;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final title = switch (titleKey) {
      'nav_dashboard' => t.nav_dashboard,
      'nav_users' => t.nav_users,
      'nav_settings' => t.nav_settings,
      _ => titleKey,
    };
    return Stack(
      children: [
        Center(child: Text(title)),
        const Positioned(top: 16, right: 16, child: LanguageSwitcher()),
      ],
    );
  }
}
