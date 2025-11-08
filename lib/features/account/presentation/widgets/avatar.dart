import 'package:flutter/material.dart';
import 'package:gnawledge_admin/shared/theme/colors.dart';

class AccountAvatar extends StatelessWidget {
  const AccountAvatar({required this.name, super.key});
  final String? name;

  @override
  Widget build(BuildContext context) {
    final initials = _calcInitials(name ?? '');
    return CircleAvatar(
      radius: 28,
      backgroundColor: AppColors.avatarSurface,
      child: Text(
        initials,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  String _calcInitials(String e) {
    final base = e.split('@').first;
    final parts =
        base.split(RegExp('[._-]')).where((s) => s.isNotEmpty).toList();
    if (parts.isEmpty) return base.isNotEmpty ? base[0].toUpperCase() : '?';
    final first = parts.first[0].toUpperCase();
    final last = parts.length > 1 ? parts.last[0].toUpperCase() : '';
    return '$first$last';
  }
}
