import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/account/presentation/widgets/avatar.dart';
import 'package:gnawledge_admin/features/account/presentation/widgets/tabs_bar.dart';
import 'package:gnawledge_admin/shared/theme/colors.dart';

class _TabsHost extends StatefulWidget {
  const _TabsHost({required this.labels});
  final (String, String) labels;

  @override
  State<_TabsHost> createState() => _TabsHostState();
}

class _TabsHostState extends State<_TabsHost>
    with SingleTickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: AccountTabsBar(controller: controller, labels: widget.labels),
        ),
      ),
    );
  }
}

void main() {
  ThemeData theme() => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.light.brand),
    extensions: const [AppColors.light],
  );

  testWidgets('AccountAvatar shows initials', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme(),
        home: const Scaffold(
          body: Center(child: AccountAvatar(name: 'john.doe@example.com')),
        ),
      ),
    );

    expect(find.text('JD'), findsOneWidget);
  });

  testWidgets('AccountTabsBar switches selection on tap', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme(),
        home: const _TabsHost(labels: ('Profile', 'Security')),
      ),
    );

    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Security'), findsOneWidget);

    await tester.tap(find.text('Security'));
    await tester.pump();

    await tester.tap(find.text('Profile'));
    await tester.pump();
  });
}
