import 'dart:convert';
import 'package:machine_test_practice/core/errors/server_exception.dart';
import 'package:machine_test_practice/core/internet/connection_checker.dart';
import 'package:machine_test_practice/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ConnectionChecker internet;

  AuthRemoteDataSourceImpl(this.internet);

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      if (!(await internet.isInternetConnected)) {
        throw ServerException("NOT CONNECTED TO THE INTERNET!!!");
      }
      var response =
          await http.post(Uri.parse('https://reqres.in/api/login'), body: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        var userData = UserModel(
          email: email,
          password: password,
        );
        return userData;
      } else {
        throw ServerException("Failed to sign in: ${response.statusCode}");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
