import 'package:flutter/material.dart';
import 'package:gnawledge_admin/shared/theme/colors.dart';

Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String text,
  required String cancelText,
  required String acceptText,
  Color? cancelFg,
  Color? cancelBg,
  Color? acceptFg,
  Color? acceptBg,
}) async {
  final colors = Theme.of(context).extension<AppColors>()!;

  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            style: TextButton.styleFrom(
              foregroundColor: cancelFg ?? colors.brand,
              backgroundColor: cancelBg ?? colors.surface,
            ),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: acceptFg ?? colors.onBrand,
              backgroundColor: acceptBg ?? colors.brand,
            ),
            child: Text(acceptText),
          ),
        ],
      );
    },
  );

  return result ?? false;
}
