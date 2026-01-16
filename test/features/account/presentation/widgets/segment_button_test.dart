import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/account/presentation/widgets/segment_button.dart';
import 'package:gnawledge_admin/shared/theme/colors.dart';

void main() {
  testWidgets('SegmentButton displays label', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.light.brand),
          extensions: const [AppColors.light],
        ),
        home: Scaffold(
          body: Row(
            children: [
              SegmentButton(
                label: 'Test Label',
                onTap: () {},
                borderRadius: BorderRadius.circular(8),
                selected: false,
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Test Label'), findsOneWidget);
  });

  testWidgets('SegmentButton calls onTap when tapped', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.light.brand),
          extensions: const [AppColors.light],
        ),
        home: Scaffold(
          body: Row(
            children: [
              SegmentButton(
                label: 'Test',
                onTap: () {
                  tapped = true;
                },
                borderRadius: BorderRadius.circular(8),
                selected: false,
              ),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.byType(SegmentButton));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('SegmentButton shows different styles when selected',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.light.brand),
          extensions: const [AppColors.light],
        ),
        home: Scaffold(
          body: Row(
            children: [
              SegmentButton(
                label: 'Selected',
                onTap: () {},
                borderRadius: BorderRadius.circular(8),
                selected: true,
              ),
              SegmentButton(
                label: 'Not Selected',
                onTap: () {},
                borderRadius: BorderRadius.circular(8),
                selected: false,
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Selected'), findsOneWidget);
    expect(find.text('Not Selected'), findsOneWidget);
  });
}
