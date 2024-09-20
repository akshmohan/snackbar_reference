import 'package:fpdart/fpdart.dart';
import 'package:machine_test_practice/core/errors/failure.dart';
import 'package:machine_test_practice/features/home/domain/entities/data_entity.dart';

abstract interface class DataRepository {
  Future<Either<Failure, List<DataEntity>>> getData();
}
