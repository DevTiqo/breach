import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String about;
  @HiveField(5)
  String? token;
  @HiveField(6)
  String? refreshtoken;
  @HiveField(7)
  String? imageUrl;

  @override
  bool operator ==(Object other) {
    return other is User &&
        runtimeType == other.runtimeType &&
        id == other.id &&
        email == other.email;
  }

  User({
    required this.id,
    required this.name,
    this.email,

    this.token = "",
    this.about = "",
    this.imageUrl = "",
    this.refreshtoken = "",
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    ;

    return User(
      id: responseData['userId'],
      name: responseData['name'] ?? 'Devtiqo',
      email: responseData['email'] ?? 'user@gmail.com',

      imageUrl: responseData['imageurl'] ?? '',

      about: responseData['about'] ?? "",

      token: responseData['token'] ?? "",
      refreshtoken: responseData['refreshtoken'] ?? "",
    );
  }
}
