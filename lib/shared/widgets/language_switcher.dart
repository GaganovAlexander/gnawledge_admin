import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/app/di.dart';
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
      onOpened: () => ref.read(isPopupOpenProvider.notifier).state = true,
      onCanceled: () => ref.read(isPopupOpenProvider.notifier).state = false,
      onSelected: (locale) {
        ref.read(isPopupOpenProvider.notifier).state = false;
        controller.setLocale(locale);
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: const Locale('en'), child: Text(t.lang_en)),
        PopupMenuItem(value: const Locale('ru'), child: Text(t.lang_ru)),
      ],
      child: Chip(
        label: Text(current.languageCode == 'ru' ? t.lang_ru : t.lang_en),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
    );
  }
}
