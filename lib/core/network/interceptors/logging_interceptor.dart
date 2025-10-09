import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
// TODO: добавить нормальный логгер
// print('[REQ] ${options.method} ${options.uri}');
    super.onRequest(options, handler);
  }
}
