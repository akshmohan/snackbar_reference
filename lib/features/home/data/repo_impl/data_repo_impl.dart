import 'package:fpdart/fpdart.dart';
import 'package:machine_test_practice/core/errors/failure.dart';
import 'package:machine_test_practice/core/errors/server_exception.dart';
import 'package:machine_test_practice/features/home/data/data_sources/data_remote_data_source.dart';
import 'package:machine_test_practice/features/home/domain/entities/data_entity.dart';
import 'package:machine_test_practice/features/home/domain/repositories/data_repository.dart';

class DataRepoImpl implements DataRepository {
  final DataRemoteDataSource _dataRemoteDataSource;

  DataRepoImpl(this._dataRemoteDataSource);
  @override
  Future<Either<Failure, List<DataEntity>>> getData() async {
    try {
      final data = await _dataRemoteDataSource.loadRemoteData();

      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}
