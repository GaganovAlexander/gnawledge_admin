abstract class TokenStorage {
  Future<void> save({
    required String access,
    required String refresh,
    Duration? ttl,
  });
  String? readAccess();
  String? readRefresh();
  Future<void> clear();
}
