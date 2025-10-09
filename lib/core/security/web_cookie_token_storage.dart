import 'package:gnawledge_admin/core/security/token_storage.dart';
import 'package:gnawledge_admin/core/security/web_cookie_storage.dart';

class WebCookieTokenStorage implements TokenStorage {
  WebCookieTokenStorage(this._cookies);

  final WebCookieStorage _cookies;
  static const _kAccess = 'auth_access';
  static const _kRefresh = 'auth_refresh';

  @override
  Future<void> save({
    required String access,
    required String refresh,
    Duration? ttl,
  }) async {
    _cookies
      ..set(_kAccess, access, maxAge: ttl ?? const Duration(hours: 1))
      ..set(_kRefresh, refresh, maxAge: const Duration(days: 30));
  }

  @override
  String? readAccess() => _cookies.get(_kAccess);

  @override
  String? readRefresh() => _cookies.get(_kRefresh);

  @override
  Future<void> clear() async {
    _cookies
      ..remove(_kAccess)
      ..remove(_kRefresh);
  }
}
