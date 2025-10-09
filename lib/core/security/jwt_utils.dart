import 'dart:convert';

bool _isProbablyJwt(String t) => t.split('.').length == 3;

bool isAccessTokenValid(String? token) {
  if (token == null || token.isEmpty) return false;
  if (!_isProbablyJwt(token)) return true;
  try {
    final payload = token.split('.')[1];
    final norm = base64.normalize(payload);
    final json =
        jsonDecode(utf8.decode(base64.decode(norm))) as Map<String, dynamic>;
    final exp = (json['exp'] as num?)?.toInt();
    if (exp == null) return true;
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return now < exp;
  } catch (_) {
    return true;
  }
}
