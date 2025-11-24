import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/features/auth/presentation/providers/auth_providers.dart';
import 'package:gnawledge_admin/l10n/app_localizations.dart';
import 'package:gnawledge_admin/shared/theme/colors.dart';
import 'package:gnawledge_admin/shared/validations/email.dart';
import 'package:gnawledge_admin/shared/widgets/language_switcher.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: colors.pageBg,
      body: Stack(
        children: [
          const Positioned(top: 16, right: 16, child: LanguageSwitcher()),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: _buildCard(context, t),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, AppLocalizations t) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              _buildLogo(context),
              const SizedBox(height: 16),
              _buildTitle(context, t),
              const SizedBox(height: 24),
              _buildEmailLabel(context, t),
              const SizedBox(height: 8),
              _buildEmailField(t),
              const SizedBox(height: 16),
              _buildPasswordLabel(context, t),
              const SizedBox(height: 8),
              _buildPasswordField(t),
              _buildForgotPassword(context, t),
              const SizedBox(height: 4),
              _buildSubmitButton(context, t),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.login, color: colors.onPrimary),
    );
  }

  Widget _buildTitle(BuildContext context, AppLocalizations t) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Column(
      children: [
        Text(
          t.login_title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          t.login_subtitle,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: colors.textMedium),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEmailLabel(BuildContext context, AppLocalizations t) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(t.email_label, style: Theme.of(context).textTheme.labelLarge),
    );
  }

  Widget _buildEmailField(AppLocalizations t) {
    return TextFormField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: t.email_hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        isDense: true,
      ),
      validator: emailValidator(t),
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildPasswordLabel(BuildContext context, AppLocalizations t) {
    return Align(
      alignment: Alignment.centerLeft,
      child:
          Text(t.password_label, style: Theme.of(context).textTheme.labelLarge),
    );
  }

  Widget _buildPasswordField(AppLocalizations t) {
    return TextFormField(
      controller: _password,
      obscureText: _obscure,
      decoration: InputDecoration(
        hintText: t.password_hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        isDense: true,
        suffixIcon: IconButton(
          onPressed: _toggleObscure,
          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
        ),
      ),
      validator: (v) => (v == null || v.isEmpty) ? t.validation_password : null,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => _onSubmit(context),
    );
  }

  Widget _buildForgotPassword(BuildContext context, AppLocalizations t) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => context.go('/forgot-password'),
        child: Text(t.forgot_password),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context, AppLocalizations t) {
    final isLoading = ref.watch(authLoadingProvider);
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: FilledButton(
        onPressed: isLoading ? null : () => _onSubmit(context),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(t.sign_in),
      ),
    );
  }

  void _toggleObscure() => setState(() => _obscure = !_obscure);

  Future<void> _onSubmit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final t = AppLocalizations.of(context)!;
    final doSignIn = ref.read(signInActionProvider);
    final router = GoRouter.of(context);

    try {
      await doSignIn(_email.text.trim(), _password.text);
      if (!context.mounted) return;

      final from = GoRouterState.of(context).uri.queryParameters['from'];
      router.go(from ?? '/users');
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            t.validation_invalid_credentials,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
