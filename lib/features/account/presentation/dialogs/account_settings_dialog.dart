import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/features/account/domain/entities/user.dart';
import 'package:gnawledge_admin/features/account/presentation/providers.dart';
import 'package:gnawledge_admin/features/account/presentation/widgets/avatar.dart';
import 'package:gnawledge_admin/features/account/presentation/widgets/tabs_bar.dart';
import 'package:gnawledge_admin/l10n/app_localizations.dart';
import 'package:gnawledge_admin/shared/theme/colors.dart';

class AccountSettingsDialog extends ConsumerStatefulWidget {
  const AccountSettingsDialog({super.key});

  @override
  ConsumerState<AccountSettingsDialog> createState() =>
      _AccountSettingsDialogState();
}

class _AccountSettingsDialogState extends ConsumerState<AccountSettingsDialog>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  final _profileForm = GlobalKey<FormState>();
  final _securityForm = GlobalKey<FormState>();

  late final TextEditingController _name = TextEditingController();
  final _currentPass = TextEditingController();
  final _newPass = TextEditingController();
  final _confirmPass = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    _name.dispose();
    _currentPass.dispose();
    _newPass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final radius = BorderRadius.circular(16);

    final me = ref.watch(accountControllerProvider).me;

    return Dialog(
      backgroundColor: AppColors.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: radius),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720, maxHeight: 800),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          child: me.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(t.error_loading_profile),
                const SizedBox(height: 8),
                Text(
                  '$e',
                  style: const TextStyle(color: AppColors.error),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed:
                      ref.read(accountControllerProvider.notifier).refresh,
                  child: Text(t.retry),
                ),
              ],
            ),
            data: (user) => _Content(
              t: t,
              tab: _tab,
              user: user,
              nameCtrl: _name..text = user.fullName ?? '',
              currentPass: _currentPass,
              newPass: _newPass,
              confirmPass: _confirmPass,
              profileForm: _profileForm,
              securityForm: _securityForm,
            ),
          ),
        ),
      ),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content({
    required this.t,
    required this.tab,
    required this.user,
    required this.nameCtrl,
    required this.currentPass,
    required this.newPass,
    required this.confirmPass,
    required this.profileForm,
    required this.securityForm,
  });

  final AppLocalizations t;
  final TabController tab;
  final UserEntity user;
  final TextEditingController nameCtrl;
  final TextEditingController currentPass;
  final TextEditingController newPass;
  final TextEditingController confirmPass;
  final GlobalKey<FormState> profileForm;
  final GlobalKey<FormState> securityForm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.account_settings,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    t.account_settings_subtitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.textMedium),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: t.close,
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            AccountAvatar(email: user.email),
            const SizedBox(width: 12),
            Text(
              user.email,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColors.textHigh),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(height: 1),
        const SizedBox(height: 12),
        AccountTabsBar(
          controller: tab,
          labels: (
            t.profile_tab,
            t.security_tab,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 340,
          child: AnimatedBuilder(
            animation: tab,
            builder: (context, _) {
              final idx = tab.index;
              return IndexedStack(
                index: idx,
                children: [
                  _ProfileTab(
                    t: t,
                    nameCtrl: nameCtrl,
                    profileForm: profileForm,
                  ),
                  _SecurityTab(
                    t: t,
                    current: currentPass,
                    next: newPass,
                    confirm: confirmPass,
                    securityForm: securityForm,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ProfileTab extends ConsumerWidget {
  const _ProfileTab({
    required this.t,
    required this.nameCtrl,
    required this.profileForm,
  });
  final AppLocalizations t;
  final TextEditingController nameCtrl;
  final GlobalKey<FormState> profileForm;

  InputDecoration _inputDecoration() => InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        isDense: true,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(accountControllerProvider).me;
    final email = me.asData?.value.email ?? '';

    return Form(
      key: profileForm,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(t.full_name, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            TextFormField(
              controller: nameCtrl,
              decoration: _inputDecoration(),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? t.validation_fullname
                  : null,
            ),
            const SizedBox(height: 16),
            Text(t.email_label, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            TextFormField(
              enabled: false,
              initialValue: email,
              decoration: _inputDecoration().copyWith(
                filled: true,
                fillColor: AppColors.readOnlyFill,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              t.email_cannot_be_changed,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.textMedium),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 44,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  shape: const StadiumBorder(),
                  minimumSize: const Size.fromHeight(44),
                ),
                onPressed: () async {
                  if (!profileForm.currentState!.validate()) return;

                  final notifier = ref.read(accountControllerProvider.notifier);
                  await notifier.updateProfile(nameCtrl.text.trim());

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(t.profile_updated),
                      ),
                    );
                    Navigator.of(context).pop(true);
                  }
                },
                child: Text(t.update_profile),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SecurityTab extends ConsumerWidget {
  const _SecurityTab({
    required this.t,
    required this.current,
    required this.next,
    required this.confirm,
    required this.securityForm,
  });

  final AppLocalizations t;
  final TextEditingController current;
  final TextEditingController next;
  final TextEditingController confirm;
  final GlobalKey<FormState> securityForm;

  InputDecoration _inputDecoration() => InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        isDense: true,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: securityForm,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              t.current_password,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: current,
              obscureText: true,
              decoration: _inputDecoration().copyWith(
                hintText: '********',
              ),
              validator: (v) => (v == null || v.isEmpty) ? t.required : null,
            ),
            const SizedBox(height: 16),
            Text(t.new_password, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            TextFormField(
              controller: next,
              obscureText: true,
              decoration: _inputDecoration().copyWith(
                hintText: '********',
              ),
              validator: (v) => (v == null || v.length < 6)
                  ? t.validation_password_length
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              t.confirm_new_password,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: confirm,
              obscureText: true,
              decoration: _inputDecoration().copyWith(
                hintText: '********',
              ),
              validator: (v) =>
                  v != next.text ? t.validation_passwords_mismatch : null,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 44,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  shape: const StadiumBorder(),
                  minimumSize: const Size.fromHeight(44),
                ),
                onPressed: () async {
                  if (!securityForm.currentState!.validate()) return;

                  final notifier = ref.read(accountControllerProvider.notifier);
                  await notifier.changePassword(
                    current: current.text,
                    next: next.text,
                  );

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(t.password_updated),
                      ),
                    );
                    Navigator.of(context).pop(true);
                  }
                },
                child: Text(t.update_password),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
