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
  String forgot_confirmation(String email) {
    return 'If an account exists with $email, you will receive a password reset link shortly.';
  }

  @override
  String get brand_title => 'Admin Panel';

  @override
  String get nav_dashboard => 'Dashboard';

  @override
  String get nav_users => 'Users';

  @override
  String get nav_settings => 'Settings';

  @override
  String get my_account => 'My Account';

  @override
  String get logout => 'Logout';

  @override
  String get logout_title => 'Log out?';

  @override
  String get logout_body => 'You will be signed out of your session.';

  @override
  String get cancel => 'Cancel';

  @override
  String get page_dashboard => 'Dashboard';

  @override
  String get page_users => 'Users';

  @override
  String get page_settings => 'Settings';

  @override
  String get account_settings => 'Account Settings';

  @override
  String get account_settings_subtitle => 'Manage your account information and security settings';

  @override
  String get close => 'Close';

  @override
  String get profile_tab => 'Profile';

  @override
  String get security_tab => 'Security';

  @override
  String get full_name => 'Full Name';

  @override
  String get email_cannot_be_changed => 'Email cannot be changed';

  @override
  String get update_profile => 'Update Profile';

  @override
  String get profile_updated => 'Profile updated';

  @override
  String get current_password => 'Current Password';

  @override
  String get new_password => 'New Password';

  @override
  String get confirm_new_password => 'Confirm New Password';

  @override
  String get update_password => 'Update Password';

  @override
  String get password_updated => 'Password updated';

  @override
  String get required => 'Required';

  @override
  String get validation_fullname => 'Please enter your full name';

  @override
  String get validation_password_length => 'Password must be at least 6 characters';

  @override
  String get validation_passwords_mismatch => 'Passwords do not match';

  @override
  String get error_loading_profile => 'Failed to load profile';

  @override
  String get retry => 'Retry';
}
