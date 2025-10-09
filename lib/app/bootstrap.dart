import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/app/app.dart';
import 'package:gnawledge_admin/app/env.dart';

Future<void> bootstrap() async {
  final container = ProviderContainer(
    overrides: [
      envProvider.overrideWithValue(const AppEnv()),
    ],
  );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const App(),
    ),
  );
}
