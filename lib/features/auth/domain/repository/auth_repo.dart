import 'package:fpdart/fpdart.dart';
import 'package:machine_test_practice/core/errors/failure.dart';
import 'package:machine_test_practice/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> storeToHive();

  Either<Failure, UserEntity> isLoggedIn();

  Future<void> signoutUser();
}
