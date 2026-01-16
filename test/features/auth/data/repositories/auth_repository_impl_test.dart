import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/auth/data/repositories/auth_repository_impl.dart';

import '../sources/fake_auth_data_source.dart';
import '../sources/fake_token_storage.dart';

void main() {
  group('AuthRepositoryImpl', () {
    group('signIn', () {
      test('stores tokens and returns them', () async {
        final dataSource = FakeAuthDataSource();
        final tokenStorage = FakeTokenStorage();
        final repository = AuthRepositoryImpl(
          dataSource: dataSource,
          tokens: tokenStorage,
        );

        final tokens = await repository.signIn(
          email: 'admin@example.com',
          password: 'admin123',
        );

        expect(tokens.access, 'mock_access_admin_123');
        expect(tokens.refresh, 'mock_refresh_admin_456');
        expect(tokenStorage.readAccess(), 'mock_access_admin_123');
        expect(tokenStorage.readRefresh(), 'mock_refresh_admin_456');
      });

      test('throws exception when data source fails', () async {
        final dataSource = FakeAuthDataSource()..shouldThrow = true;
        final tokenStorage = FakeTokenStorage();
        final repository = AuthRepositoryImpl(
          dataSource: dataSource,
          tokens: tokenStorage,
        );

        await expectLater(
          () => repository.signIn(
            email: 'admin@example.com',
            password: 'admin123',
          ),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('refresh', () {
      test('stores new tokens and returns them', () async {
        final dataSource = FakeAuthDataSource();
        final tokenStorage = FakeTokenStorage();
        final repository = AuthRepositoryImpl(
          dataSource: dataSource,
          tokens: tokenStorage,
        );

        final tokens = await repository.refresh('old_refresh_token');

        expect(tokens.access, 'new_access_token');
        expect(tokens.refresh, 'new_refresh_token');
        expect(tokenStorage.readAccess(), 'new_access_token');
        expect(tokenStorage.readRefresh(), 'new_refresh_token');
      });

      test('throws exception when data source fails', () async {
        final dataSource = FakeAuthDataSource()..shouldThrow = true;
        final tokenStorage = FakeTokenStorage();
        final repository = AuthRepositoryImpl(
          dataSource: dataSource,
          tokens: tokenStorage,
        );

        await expectLater(
          () => repository.refresh('old_refresh_token'),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('signOut', () {
      test('clears tokens', () async {
        final dataSource = FakeAuthDataSource();
        final tokenStorage = FakeTokenStorage();
        final repository = AuthRepositoryImpl(
          dataSource: dataSource,
          tokens: tokenStorage,
        );

        // Set some tokens first
        await tokenStorage.save(
          access: 'access',
          refresh: 'refresh',
        );

        await repository.signOut();

        expect(tokenStorage.readAccess(), isNull);
        expect(tokenStorage.readRefresh(), isNull);
      });
    });

    group('currentAccess', () {
      test('returns access token from storage', () {
        final dataSource = FakeAuthDataSource();
        final tokenStorage = FakeTokenStorage();
        final repository = AuthRepositoryImpl(
          dataSource: dataSource,
          tokens: tokenStorage,
        );

        tokenStorage.save(access: 'test_access', refresh: 'test_refresh');

        expect(repository.currentAccess(), 'test_access');
      });
    });

    group('currentRefresh', () {
      test('returns refresh token from storage', () {
        final dataSource = FakeAuthDataSource();
        final tokenStorage = FakeTokenStorage();
        final repository = AuthRepositoryImpl(
          dataSource: dataSource,
          tokens: tokenStorage,
        );

        tokenStorage.save(access: 'test_access', refresh: 'test_refresh');

        expect(repository.currentRefresh(), 'test_refresh');
      });
    });

    group('requestPasswordReset', () {
      test('calls data source', () async {
        final dataSource = FakeAuthDataSource();
        final tokenStorage = FakeTokenStorage();
        final repository = AuthRepositoryImpl(
          dataSource: dataSource,
          tokens: tokenStorage,
        );

        await expectLater(
          repository.requestPasswordReset('test@example.com'),
          completes,
        );
      });

      test('throws exception when data source fails', () async {
        final dataSource = FakeAuthDataSource()..shouldThrow = true;
        final tokenStorage = FakeTokenStorage();
        final repository = AuthRepositoryImpl(
          dataSource: dataSource,
          tokens: tokenStorage,
        );

        await expectLater(
          () => repository.requestPasswordReset('test@example.com'),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
