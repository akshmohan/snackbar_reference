import 'package:fpdart/fpdart.dart';
import 'package:machine_test_practice/core/errors/failure.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
