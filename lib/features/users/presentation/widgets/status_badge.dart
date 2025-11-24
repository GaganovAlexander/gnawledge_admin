import 'package:flutter/material.dart';
import 'package:gnawledge_admin/l10n/app_localizations.dart';
import 'package:gnawledge_admin/shared/theme/colors.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    required this.status,
    super.key,
  });
  final String status;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColors>()!;
    final isActive = status.toLowerCase() == 'active';
    final bg = isActive ? colors.brand : colors.avatarSurface;
    final fg = isActive ? colors.onBrand : colors.textHigh;
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
