import 'package:flutter/material.dart';
import 'package:gnawledge_admin/features/account/presentation/widgets/segment_button.dart';

class AccountTabsBar extends StatelessWidget {
  const AccountTabsBar({
    required this.controller,
    required this.labels,
    super.key,
  });
  final TabController controller;
  final (String, String) labels;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        const h = 40.0;
        const pad = 2.0;
        final w = constraints.maxWidth;
        final segW = (w - pad * 2) / 2;

        BorderRadius radiusFor(int index) {
          const r = Radius.circular(24);
          return index == 0
              ? const BorderRadius.only(topLeft: r, bottomLeft: r)
              : const BorderRadius.only(topRight: r, bottomRight: r);
        }

        void go(int i) => controller.index = i;

        return Container(
          height: h,
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest.withValues(alpha: .35),
            borderRadius: BorderRadius.circular(24),
          ),
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              final raw = (controller.animation?.value ?? controller.index)
                  .clamp(0.0, 1.0);
              final left = pad + segW * raw;
              final selectedIdx = raw >= 0.5 ? 1 : 0;

              return Stack(
                children: [
                  Positioned(
                    left: left,
                    top: pad,
                    width: segW,
                    height: h - pad * 2,
                    child: ClipRRect(
                      borderRadius: radiusFor(selectedIdx),
                      child: ColoredBox(
                        color: cs.primary.withValues(alpha: .12),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SegmentButton(
                        label: labels.$1,
                        onTap: () => go(0),
                        borderRadius: radiusFor(0),
                        selected: selectedIdx == 0,
                      ),
                      SegmentButton(
                        label: labels.$2,
                        onTap: () => go(1),
                        borderRadius: radiusFor(1),
                        selected: selectedIdx == 1,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
