import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/core/security/web_cookie_storage.dart';

const _kLocaleCookie = 'app_locale';

Locale _parseLocale(String? v) {
  if (v == null || v.isEmpty) return const Locale('ru');
  final parts = v.split('_');
  return parts.length == 1 ? Locale(parts[0]) : Locale(parts[0], parts[1]);
}

String _localeToString(Locale l) =>
    l.countryCode == null || l.countryCode!.isEmpty
        ? l.languageCode
        : '${l.languageCode}_${l.countryCode}';

class LocaleController extends Notifier<Locale> {
  final _cookies = WebCookieStorage();

  @override
  Locale build() {
    final fromCookie = _cookies.get(_kLocaleCookie);
    return _parseLocale(fromCookie);
  }

  void setLocale(Locale locale) {
    state = locale;
    _cookies.set(_kLocaleCookie, _localeToString(locale),
        maxAge: const Duration(days: 365));
  }
}

final localeProvider =
    NotifierProvider<LocaleController, Locale>(LocaleController.new);

final supportedLocales = <Locale>[
  const Locale('en'),
  const Locale('ru'),
];
