import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kUseMocks = bool.fromEnvironment('USE_MOCKS', defaultValue: true);
const _kApiBase =
    String.fromEnvironment('API_BASE', defaultValue: 'https://api.example.com');

class AppEnv {
  const AppEnv({this.apiBase = _kApiBase, this.useMocks = _kUseMocks});
  final String apiBase;
  final bool useMocks;
}

final envProvider = Provider<AppEnv>((_) => const AppEnv());
