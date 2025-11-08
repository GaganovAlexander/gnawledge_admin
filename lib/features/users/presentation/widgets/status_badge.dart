import 'package:flutter/material.dart';
import 'package:gnawledge_admin/l10n/app_localizations.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    required this.status,
    super.key,
  });
  final String status;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final isActive = status.toLowerCase() == 'active';
    final bg = isActive
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.surfaceContainerHighest;
    final fg = isActive
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSurfaceVariant;
    final label = isActive ? t.status_active : t.status_inactive;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child:
          Text(label, style: TextStyle(color: fg, fontWeight: FontWeight.w600)),
    );
  }
}
