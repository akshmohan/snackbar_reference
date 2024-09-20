import 'package:machine_test_practice/features/auth/domain/repository/auth_repo.dart';

class UserSignOut {
  final AuthRepository authRepository;

  UserSignOut(this.authRepository);

  call() {
    authRepository.signoutUser();
  }
}
