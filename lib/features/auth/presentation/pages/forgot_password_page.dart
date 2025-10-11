import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/features/auth/presentation/providers/forgot_password_providers.dart';
import 'package:gnawledge_admin/l10n/app_localizations.dart';
import 'package:gnawledge_admin/shared/widgets/language_switcher.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final doneEmail = ref.watch(forgotEmailProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Stack(
        children: [
          const Positioned(top: 16, right: 16, child: LanguageSwitcher()),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: doneEmail == null
                      ? _buildForm(context, t)
                      : _buildConfirmation(context, t, doneEmail),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context, AppLocalizations t) {
    final isLoading = ref.watch(forgotLoadingProvider);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          _buildIcon(context),
          const SizedBox(height: 16),
          _buildTitle(context, t),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(t.email_label,
                style: Theme.of(context).textTheme.labelLarge),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.send,
            onFieldSubmitted: (_) => _onSubmit(context),
            decoration: InputDecoration(
              hintText: t.email_hint,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              isDense: true,
            ),
            validator: (v) {
              final s = (v ?? '').trim();
              final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(s);
              return ok ? null : t.validation_email;
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: FilledButton(
              onPressed: isLoading ? null : () => _onSubmit(context),
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(t.send_reset_link),
            ),
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: () => context.go('/login'),
            icon: const Icon(Icons.arrow_back, size: 18),
            label: Text(t.back_to_login),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmation(
      BuildContext context, AppLocalizations t, String email) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        _buildIcon(context),
        const SizedBox(height: 16),
        _buildTitle(context, t),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.04),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            t.forgot_confirmation(email),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        TextButton.icon(
          onPressed: () => context.go('/login'),
          icon: const Icon(Icons.arrow_back, size: 18),
          label: Text(t.back_to_login),
        ),
      ],
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.key, color: Colors.white),
    );
  }

  Widget _buildTitle(BuildContext context, AppLocalizations t) {
    return Column(
      children: [
        Text(
          t.forgot_title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          t.forgot_subtitle,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Future<void> _onSubmit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    final act = ref.read(sendResetLinkActionProvider);
    await act(_email.text.trim());
    if (!mounted) return;
  }
}
