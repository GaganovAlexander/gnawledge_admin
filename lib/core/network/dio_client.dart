import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/app/env.dart';
import 'package:gnawledge_admin/core/network/interceptors/logging_interceptor.dart';

final dioProvider = Provider<Dio>((ref) {
  final env = ref.read(envProvider);
  final dio = Dio(BaseOptions(baseUrl: env.apiBase));
  dio.interceptors.add(LoggingInterceptor());
  return dio;
});

final dioClientProvider = Provider((ref) => ref.watch(dioProvider));
