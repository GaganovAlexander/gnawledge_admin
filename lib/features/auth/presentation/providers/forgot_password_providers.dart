import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/app/di.dart';

final forgotLoadingProvider = StateProvider<bool>((_) => false);
final forgotEmailProvider = StateProvider<String?>((_) => null);

final sendResetLinkActionProvider =
    Provider<Future<void> Function(String)>((ref) {
  final usecase = ref.watch(requestPasswordResetProvider);
  final loading = ref.watch(forgotLoadingProvider.notifier);
  final emailSt = ref.watch(forgotEmailProvider.notifier);

  return (String email) async {
    loading.state = true;
    try {
      await usecase(email);
      emailSt.state = email;
    } finally {
      loading.state = false;
    }
  };
});
