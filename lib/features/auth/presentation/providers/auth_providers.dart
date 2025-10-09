import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/app/di.dart';

final authLoadingProvider = StateProvider<bool>((_) => false);

final signInActionProvider =
    Provider<Future<void> Function(String, String)>((ref) {
  final signIn = ref.watch(signInUseCaseProvider);
  final loading = ref.watch(authLoadingProvider.notifier);

  return (String email, String password) async {
    loading.state = true;
    try {
      await signIn(email: email, password: password);
    } finally {
      loading.state = false;
    }
  };
});
