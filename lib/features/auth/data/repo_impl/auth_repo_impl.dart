import 'package:fpdart/fpdart.dart';
import 'package:machine_test_practice/core/errors/failure.dart';
import 'package:machine_test_practice/core/errors/server_exception.dart';
import 'package:machine_test_practice/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:machine_test_practice/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:machine_test_practice/features/auth/domain/entities/user_entity.dart';
import 'package:machine_test_practice/features/auth/domain/repository/auth_repo.dart';
import '../models/user_model.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepoImpl(this.authRemoteDataSource, this.authLocalDataSource);

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserModel userModel =
          await authRemoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      authLocalDataSource.uploadUserData(userModel);

      return Right(userModel);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> storeToHive() async {
    try {
      UserModel? userModel = await authLocalDataSource.checkUserLoggedIn();
      if (userModel != null) {
        return Right(userModel);
      } else {
        return Left(Failure(message: "User data not found"));
      }
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Either<Failure, UserEntity> isLoggedIn() {
    try {
      UserModel? userModel = authLocalDataSource.checkUserLoggedIn();
      if (userModel != null) {
        return Right(userModel);
      } else {
        return Left(Failure(message: 'User doesn\'t exist'));
      }
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<void> signoutUser() async {
    await authLocalDataSource.signoutUser();
  }
}
