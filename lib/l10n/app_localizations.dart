import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get appTitle;

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Admin Panel Login'**
  String get login_title;

  /// No description provided for @login_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your credentials to access the admin panel'**
  String get login_subtitle;

  /// No description provided for @email_label.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email_label;

  /// No description provided for @email_hint.
  ///
  /// In en, this message translates to:
  /// **'admin@example.com'**
  String get email_hint;

  /// No description provided for @password_label.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password_label;

  /// No description provided for @password_hint.
  ///
  /// In en, this message translates to:
  /// **'Your password'**
  String get password_hint;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgot_password;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// No description provided for @lang_en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get lang_en;

  /// No description provided for @lang_ru.
  ///
  /// In en, this message translates to:
  /// **'Русский'**
  String get lang_ru;

  /// No description provided for @change_language.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get change_language;

  /// No description provided for @validation_email.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get validation_email;

  /// No description provided for @validation_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get validation_password;

  /// No description provided for @validation_invalid_credentials.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password'**
  String get validation_invalid_credentials;

  /// No description provided for @forgot_title.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get forgot_title;

  /// No description provided for @forgot_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you a link to reset your password'**
  String get forgot_subtitle;

  /// No description provided for @send_reset_link.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get send_reset_link;

  /// No description provided for @back_to_login.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get back_to_login;

  /// No description provided for @forgot_confirmation.
  ///
  /// In en, this message translates to:
  /// **'If an account exists with {email}, you will receive a password reset link shortly.'**
  String forgot_confirmation(String email);

  /// No description provided for @brand_title.
  ///
  /// In en, this message translates to:
  /// **'Admin Panel'**
  String get brand_title;

  /// No description provided for @nav_dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get nav_dashboard;

  /// No description provided for @nav_users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get nav_users;

  /// No description provided for @nav_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get nav_settings;

  /// No description provided for @my_account.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get my_account;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logout_title.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get logout_title;

  /// No description provided for @logout_body.
  ///
  /// In en, this message translates to:
  /// **'You will be signed out of your session.'**
  String get logout_body;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @page_dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get page_dashboard;

  /// No description provided for @page_users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get page_users;

  /// No description provided for @page_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get page_settings;

  /// No description provided for @account_settings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get account_settings;

  /// No description provided for @account_settings_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your account information and security settings'**
  String get account_settings_subtitle;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @profile_tab.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_tab;

  /// No description provided for @security_tab.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security_tab;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// No description provided for @email_cannot_be_changed.
  ///
  /// In en, this message translates to:
  /// **'Email cannot be changed'**
  String get email_cannot_be_changed;

  /// No description provided for @update_profile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get update_profile;

  /// No description provided for @profile_updated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get profile_updated;

  /// No description provided for @current_password.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get current_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @confirm_new_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirm_new_password;

  /// No description provided for @update_password.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get update_password;

  /// No description provided for @password_updated.
  ///
  /// In en, this message translates to:
  /// **'Password updated'**
  String get password_updated;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @validation_fullname.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name'**
  String get validation_fullname;

  /// No description provided for @validation_password_length.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get validation_password_length;

  /// No description provided for @validation_passwords_mismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validation_passwords_mismatch;

  /// No description provided for @error_loading_profile.
  ///
  /// In en, this message translates to:
  /// **'Failed to load profile'**
  String get error_loading_profile;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
