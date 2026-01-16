import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/account/data/models/user_dto.dart';

void main() {
  group('UserDto', () {
    group('fromJson', () {
      test('parses full name from surname, name, and middle_name', () {
        final json = {
          'book_id': '123',
          'email': 'test@example.com',
          'surname': 'Doe',
          'name': 'John',
          'middle_name': 'Smith',
        };

        final dto = UserDto.fromJson(json);

        expect(dto.id, '123');
        expect(dto.email, 'test@example.com');
        expect(dto.fullName, 'Doe John Smith');
      });

      test('handles missing middle_name', () {
        final json = {
          'book_id': '123',
          'email': 'test@example.com',
          'surname': 'Doe',
          'name': 'John',
        };

        final dto = UserDto.fromJson(json);

        expect(dto.fullName, 'Doe John');
      });

      test('handles missing surname', () {
        final json = {
          'book_id': '123',
          'email': 'test@example.com',
          'name': 'John',
        };

        final dto = UserDto.fromJson(json);

        expect(dto.fullName, 'John');
      });

      test('uses email as id when book_id is missing', () {
        final json = {
          'email': 'test@example.com',
          'surname': 'Doe',
          'name': 'John',
        };

        final dto = UserDto.fromJson(json);

        expect(dto.id, 'test@example.com');
      });

      test('filters out empty name parts', () {
        final json = {
          'book_id': '123',
          'email': 'test@example.com',
          'surname': '',
          'name': 'John',
          'middle_name': '  ',
        };

        final dto = UserDto.fromJson(json);

        expect(dto.fullName, 'John');
      });
    });

    group('toEntity', () {
      test('converts DTO to entity correctly', () {
        const dto = UserDto(
          id: '123',
          email: 'test@example.com',
          fullName: 'John Doe',
        );

        final entity = dto.toEntity();

        expect(entity.id, '123');
        expect(entity.email, 'test@example.com');
        expect(entity.fullName, 'John Doe');
      });
    });
  });
}
