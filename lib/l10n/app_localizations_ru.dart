// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Админка';

  @override
  String get login_title => 'Вход в админ-панель';

  @override
  String get login_subtitle => 'Введите учётные данные для доступа';

  @override
  String get email_label => 'Email';

  @override
  String get email_hint => 'admin@example.com';

  @override
  String get password_label => 'Пароль';

  @override
  String get password_hint => 'Ваш пароль';

  @override
  String get forgot_password => 'Забыли пароль?';

  @override
  String get sign_in => 'Войти';

  @override
  String get lang_en => 'English';

  @override
  String get lang_ru => 'Русский';

  @override
  String get change_language => 'Сменить язык';

  @override
  String get validation_email => 'Введите корректный email';

  @override
  String get validation_password => 'Введите пароль';

  @override
  String get validation_invalid_credentials => 'Неверный email или пароль';

  @override
  String get forgot_title => 'Сброс пароля';

  @override
  String get forgot_subtitle => 'Введите ваш email, и мы отправим ссылку для сброса пароля';

  @override
  String get send_reset_link => 'Отправить ссылку';

  @override
  String get back_to_login => 'Назад ко входу';

  @override
  String forgot_confirmation(Object email) {
    return 'Если аккаунт с адресом $email существует, на него вскоре придёт письмо со ссылкой для сброса.';
  }
}
