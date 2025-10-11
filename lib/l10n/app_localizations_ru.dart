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
  String forgot_confirmation(String email) {
    return 'Если аккаунт с адресом $email существует, на него вскоре придёт письмо со ссылкой для сброса.';
  }

  @override
  String get brand_title => 'Админ-панель';

  @override
  String get nav_dashboard => 'Дашборд';

  @override
  String get nav_users => 'Пользователи';

  @override
  String get nav_settings => 'Настройки';

  @override
  String get my_account => 'Мой аккаунт';

  @override
  String get logout => 'Выйти';

  @override
  String get logout_title => 'Выйти из аккаунта?';

  @override
  String get logout_body => 'Вы будете выведены из текущей сессии.';

  @override
  String get cancel => 'Отмена';

  @override
  String get page_dashboard => 'Панель';

  @override
  String get page_users => 'Пользователи';

  @override
  String get page_settings => 'Настройки';
}
