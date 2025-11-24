import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/l10n/app_localizations.dart';
import 'package:gnawledge_admin/shared/i18n/locale_provider.dart';

class LanguageSwitcher extends ConsumerWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final current = ref.watch(localeProvider);
    final controller = ref.read(localeProvider.notifier);

    return PopupMenuButton<Locale>(
      tooltip: t.change_language,
      onSelected: controller.setLocale,
      itemBuilder: (context) => const [
        PopupMenuItem(value: Locale('en'), child: Text('English')),
        PopupMenuItem(value: Locale('ru'), child: Text('Русский')),
      ],
      child: Chip(
        label: Text(current.languageCode == 'ru' ? t.lang_ru : t.lang_en),
      ),
    );
  }
}
