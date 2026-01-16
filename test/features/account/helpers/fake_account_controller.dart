import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/features/account/domain/entities/user.dart';
import 'package:gnawledge_admin/features/account/domain/repositories/account_repository.dart';
import 'package:gnawledge_admin/features/account/domain/usecases/change_password.dart';
import 'package:gnawledge_admin/features/account/domain/usecases/update_profile.dart';
import 'package:gnawledge_admin/features/account/presentation/controllers/account_controller.dart';

class FakeAccountController extends AccountController {
  FakeAccountController({
    required AsyncValue<UserEntity> initialMe,
    FakeUpdateProfile? updateProfileUc,
    FakeChangePassword? changePasswordUc,
  }) : updateProfileUcFake = updateProfileUc ?? FakeUpdateProfile(),
       changePasswordUcFake = changePasswordUc ?? FakeChangePassword(),
       super(
         updateProfileUc: updateProfileUc ?? FakeUpdateProfile(),
         changePasswordUc: changePasswordUc ?? FakeChangePassword(),
         repo: _FakeAccountRepository(),
       ) {
    state = state.copyWith(me: initialMe);
  }

  final FakeUpdateProfile updateProfileUcFake;
  final FakeChangePassword changePasswordUcFake;

  int refreshCalls = 0;

  @override
  Future<void> refresh() async {
    refreshCalls += 1;
  }
}

class FakeUpdateProfile extends UpdateProfile {
  FakeUpdateProfile() : super(_FakeAccountRepository());

  int calls = 0;
  String? lastName;

  @override
  Future<UserEntity> call(String fullName) async {
    calls += 1;
    lastName = fullName;

    return UserEntity(id: '1', email: 'user@example.com', fullName: fullName);
  }
}

class FakeChangePassword extends ChangePassword {
  FakeChangePassword() : super(_FakeAccountRepository());

  int calls = 0;
  String? lastCurrent;
  String? lastNext;

  @override
  Future<void> call({required String current, required String next}) async {
    calls += 1;
    lastCurrent = current;
    lastNext = next;
  }
}

class _FakeAccountRepository implements AccountRepository {
  @override
  Future<UserEntity> getMe() async {
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> updateProfile({required String fullName}) async {
    throw UnimplementedError();
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    throw UnimplementedError();
  }
}
