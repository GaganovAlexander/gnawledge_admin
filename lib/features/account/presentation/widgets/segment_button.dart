import 'package:flutter/material.dart';
import 'package:gnawledge_admin/shared/theme/colors.dart';

class SegmentButton extends StatelessWidget {
  const SegmentButton({
    required this.label,
    required this.onTap,
    required this.borderRadius,
    required this.selected,
    super.key,
  });

  final String label;
  final VoidCallback onTap;
  final BorderRadius borderRadius;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final colors = Theme.of(context).extension<AppColors>()!;

    return Expanded(
      child: Material(
        type: MaterialType.transparency,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          splashFactory: NoSplash.splashFactory,
          hoverColor: colors.hoverNeutral4,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: selected ? cs.onSurface : colors.textHigh,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
