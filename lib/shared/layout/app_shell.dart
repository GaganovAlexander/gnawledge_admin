import 'package:flutter/material.dart';
import 'package:gnawledge_admin/shared/widgets/sidebar.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          Expanded(
            child: ColoredBox(
              color: const Color(0xFFF7F7FB),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
