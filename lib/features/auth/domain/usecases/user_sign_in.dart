import 'package:fpdart/fpdart.dart';
import 'package:machine_test_practice/core/errors/failure.dart';
import 'package:machine_test_practice/core/usecase/usecase.dart';
import 'package:machine_test_practice/features/auth/domain/entities/user_entity.dart';
import 'package:machine_test_practice/features/auth/domain/repository/auth_repo.dart';

class UserSignIn implements Usecase<UserEntity, SignInParams> {
  final AuthRepository authRepository;

  UserSignIn(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(params) async {
    return await authRepository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({
    required this.email,
    required this.password,
  });
}
