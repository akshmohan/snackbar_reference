import 'package:hive/hive.dart';
import 'package:machine_test_practice/features/auth/data/models/user_model.dart';

abstract interface class AuthLocalDataSource {
  void uploadUserData(UserModel user);
  UserModel? checkUserLoggedIn();
  Future<void> signoutUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box box;

  AuthLocalDataSourceImpl(this.box);

  @override
  void uploadUserData(UserModel user) {
    box.write(() {
      box.put('user', user.toJson());
    });
  }

  @override
  UserModel? checkUserLoggedIn() {
    final result = box.get('user');
    if (result != null) {
      return UserModel.fromJson(result);
    }
    return null;
  }

  @override
  Future<void> signoutUser() async {
    box.clear();
  }
}
