import 'package:fpdart/fpdart.dart';
import 'package:machine_test_practice/core/errors/failure.dart';
import 'package:machine_test_practice/core/usecase/usecase.dart';
import 'package:machine_test_practice/features/auth/domain/entities/user_entity.dart';
import 'package:machine_test_practice/features/auth/domain/repository/auth_repo.dart';

class IsLoggedInCheck implements Usecase<UserEntity, NoParams> {
  final AuthRepository authRepository;

  IsLoggedInCheck(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await authRepository.isLoggedIn();
  }
}
