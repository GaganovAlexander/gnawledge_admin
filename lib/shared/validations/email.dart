import 'package:flutter/material.dart';
import 'package:gnawledge_admin/l10n/app_localizations.dart';

FormFieldValidator<String> emailValidator(AppLocalizations t) {
  return (v) {
    final s = (v ?? '').trim();
    final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(s);
    return ok ? null : t.validation_email;
  };
}
