import 'dart:convert';
import 'package:machine_test_practice/core/errors/server_exception.dart';
import 'package:machine_test_practice/features/home/data/models/data_model.dart';
import 'package:http/http.dart' as http;

abstract interface class DataRemoteDataSource {
  Future<List<DataModel>> loadRemoteData();
}

class DataRemoteDataSourceImpl implements DataRemoteDataSource {
  @override
  Future<List<DataModel>> loadRemoteData() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));

      if (response.statusCode == 200) {
        List<DataModel> data = [];

        List result = jsonDecode(response.body);

        result.map((e) => data.add(DataModel.fromJson(e))).toList();

        return data;
      } else {
        throw ServerException("Something went wrong!");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
