// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Admin';

  @override
  String get login_title => 'Admin Panel Login';

  @override
  String get login_subtitle => 'Enter your credentials to access the admin panel';

  @override
  String get email_label => 'Email';

  @override
  String get email_hint => 'admin@example.com';

  @override
  String get password_label => 'Password';

  @override
  String get password_hint => 'Your password';

  @override
  String get forgot_password => 'Forgot password?';

  @override
  String get sign_in => 'Sign In';

  @override
  String get lang_en => 'English';

  @override
  String get lang_ru => 'Русский';

  @override
  String get change_language => 'Change language';

  @override
  String get validation_email => 'Enter a valid email';

  @override
  String get validation_password => 'Enter your password';

  @override
  String get validation_invalid_credentials => 'Incorrect email or password';

  @override
  String get forgot_title => 'Reset Password';

  @override
  String get forgot_subtitle => 'Enter your email address and we\'ll send you a link to reset your password';

  @override
  String get send_reset_link => 'Send Reset Link';

  @override
  String get back_to_login => 'Back to Login';

  @override
  String forgot_confirmation(Object email) {
    return 'If an account exists with $email, you will receive a password reset link shortly.';
  }
}
