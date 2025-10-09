import 'package:web/web.dart' as web;

class WebCookieStorage {
  void set(String key, String value, {Duration? maxAge}) {
    final age = maxAge != null ? '; max-age=${maxAge.inSeconds}' : '';
    web.document.cookie = '$key=$value$age; path=/';
  }

  String? get(String key) {
    final cookies = web.document.cookie.split(';');
    for (final c in cookies) {
      final parts = c.trim().split('=');
      if (parts.length == 2 && parts[0] == key) return parts[1];
    }
    return null;
  }

  void remove(String key) => set(key, '', maxAge: Duration.zero);
}
