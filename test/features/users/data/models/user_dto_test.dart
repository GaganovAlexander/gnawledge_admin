import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/users/domain/entities/user.dart';
import 'package:gnawledge_admin/features/users/data/models/user_dto.dart';

void main() {
  group('UserDto', () {
    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = {
          'id': 42,
          'name': 'John',
          'surname': 'Doe',
          'middle_name': 'Smith',
          'email': 'john@example.com',
          'role_level': 2,
          'birth_date': '2000-01-01',
          'student_group': 'CS-101',
        };

        final dto = UserDto.fromJson(json);

        expect(dto.id, 42);
        expect(dto.firstName, 'John');
        expect(dto.lastName, 'Doe');
        expect(dto.middleName, 'Smith');
        expect(dto.email, 'john@example.com');
        expect(dto.roleLevel, 2);
        expect(dto.birthDate, '2000-01-01');
        expect(dto.studentGroup, 'CS-101');
      });

      test('handles missing optional fields', () {
        final json = {
          'id': 42,
          'name': 'John',
          'surname': 'Doe',
          'email': 'john@example.com',
        };

        final dto = UserDto.fromJson(json);

        expect(dto.id, 42);
        expect(dto.firstName, 'John');
        expect(dto.lastName, 'Doe');
        expect(dto.email, 'john@example.com');
        expect(dto.roleLevel, 0);
        expect(dto.birthDate, isNull);
        expect(dto.middleName, isNull);
        expect(dto.studentGroup, isNull);
      });
    });

    group('fromEntity', () {
      test('converts entity to DTO correctly', () {
        final user = AppUser(
          id: 42,
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          role: 'Admin',
          status: 'active',
          joinDate: DateTime(2024, 1, 1),
        );

        final dto = UserDto.fromEntity(user);

        expect(dto.id, 42);
        expect(dto.firstName, 'John');
        expect(dto.lastName, 'Doe');
        expect(dto.email, 'john@example.com');
        expect(dto.roleLevel, 2); // Admin = 2
      });
    });

    group('toEntity', () {
      test('converts DTO to entity correctly', () {
        const dto = UserDto(
          id: 42,
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          roleLevel: 2,
          birthDate: '2000-01-01',
        );

        final entity = dto.toEntity();

        expect(entity.id, 42);
        expect(entity.firstName, 'John');
        expect(entity.lastName, 'Doe');
        expect(entity.email, 'john@example.com');
        expect(entity.role, 'Admin');
        expect(entity.status, 'active');
        expect(entity.joinDate, DateTime(2000, 1, 1));
      });

      test('uses default date when birthDate is invalid', () {
        const dto = UserDto(
          id: 42,
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          roleLevel: 0,
          birthDate: 'invalid',
        );

        final entity = dto.toEntity();

        expect(entity.joinDate, DateTime(1970));
      });
    });

    group('roleFromLevel', () {
      test('returns Admin for level >= 2', () {
        const dto = UserDto(
          id: 1,
          firstName: 'Test',
          lastName: 'User',
          email: 'test@example.com',
          roleLevel: 2,
        );

        expect(dto.toEntity().role, 'Admin');
      });

      test('returns Manager for level 1', () {
        const dto = UserDto(
          id: 1,
          firstName: 'Test',
          lastName: 'User',
          email: 'test@example.com',
          roleLevel: 1,
        );

        expect(dto.toEntity().role, 'Manager');
      });

      test('returns User for level 0', () {
        const dto = UserDto(
          id: 1,
          firstName: 'Test',
          lastName: 'User',
          email: 'test@example.com',
          roleLevel: 0,
        );

        expect(dto.toEntity().role, 'User');
      });
    });

    group('levelFromRole', () {
      test('returns 2 for Admin', () {
        expect(UserDto.levelFromRole('Admin'), 2);
      });

      test('returns 1 for Manager', () {
        expect(UserDto.levelFromRole('Manager'), 1);
      });

      test('returns 0 for User', () {
        expect(UserDto.levelFromRole('User'), 0);
      });

      test('returns 0 for unknown role', () {
        expect(UserDto.levelFromRole('Unknown'), 0);
      });
    });

    group('toUpdateRequest', () {
      test('creates update request with all fields', () {
        const dto = UserDto(
          id: 42,
          firstName: 'John',
          lastName: 'Doe',
          middleName: 'Smith',
          email: 'john@example.com',
          roleLevel: 2,
          birthDate: '2000-01-01',
          studentGroup: 'CS-101',
        );

        final request = dto.toUpdateRequest();

        expect(request['user_id'], 42);
        expect(request['new_data']['email'], 'john@example.com');
        expect(request['new_data']['name'], 'John');
        expect(request['new_data']['surname'], 'Doe');
        expect(request['new_data']['middle_name'], 'Smith');
        expect(request['new_data']['role_level'], 2);
        expect(request['new_data']['birth_date'], '2000-01-01');
        expect(request['new_data']['student_group'], 'CS-101');
      });
    });
  });
}
