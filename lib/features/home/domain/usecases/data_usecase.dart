import 'package:fpdart/fpdart.dart';
import 'package:machine_test_practice/core/errors/failure.dart';
import 'package:machine_test_practice/core/usecase/usecase.dart';
import 'package:machine_test_practice/features/home/domain/entities/data_entity.dart';
import 'package:machine_test_practice/features/home/domain/repositories/data_repository.dart';

class DataLoad implements Usecase<List<DataEntity>, NoParams> {
  final DataRepository _dataRepository;

  DataLoad(this._dataRepository);

  @override
  Future<Either<Failure, List<DataEntity>>> call(NoParams params) async {
    return await _dataRepository.getData();
  }
}
