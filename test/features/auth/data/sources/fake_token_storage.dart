import 'package:gnawledge_admin/core/security/token_storage.dart';

class FakeTokenStorage implements TokenStorage {
  String? _access;
  String? _refresh;

  @override
  Future<void> save({
    required String access,
    required String refresh,
    Duration? ttl,
  }) async {
    _access = access;
    _refresh = refresh;
  }

  @override
  Future<void> clear() async {
    _access = null;
    _refresh = null;
  }

  @override
  String? readAccess() => _access;

  @override
  String? readRefresh() => _refresh;
}
