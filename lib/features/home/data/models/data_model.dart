import 'package:machine_test_practice/features/home/domain/entities/data_entity.dart';

class DataModel extends DataEntity {
  DataModel({
    required super.email,
    required super.name,
    required super.body,
  });

  factory DataModel.fromJson(Map<String, dynamic> map) {
    return DataModel(
      name: map['name'] as String,
      email: map['email'] as String,
      body: map['body'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'body': body,
    };
  }

  DataModel copyWith({
    String? email,
    String? name,
    String? body,
  }) {
    return DataModel(
      email: email ?? this.email,
      name: name ?? this.name,
      body: body ?? this.body,
    );
  }
}
