import 'package:breach/models/user_model.dart';
import 'package:breach/utils/hive_const.dart';

import 'package:hive/hive.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final Box box = await Hive.openBox(HiveConst.currentUser);

    box.put('id', user.id);
    box.put('name', user.name);

    box.put('email', user.email);

    box.put('isLoggedIn', true);
    box.put('firsttime', false);

    box.put('image', user.imageUrl);

    box.put('token', user.token);
    box.put('refreshtoken', user.refreshtoken);

    return true;
  }

  Future<User> getUser() async {
    final Box box = await Hive.openBox(HiveConst.currentUser);

    int? id = box.get('id');
    String? name = box.get('name');
    String? phone = box.get('phone');
    String? email = box.get('email');
    DateTime? email_verified_at = box.get('email_verified_at');
    String? image = box.get('image');

    DateTime? created_at = box.get('created_at');
    String? handle = box.get('handle');

    int? followers = box.get('followers');

    int? following = box.get('following');
    String? token = box.get('token');
    String? refreshtoken = box.get('refreshtoken');
    bool ishost = box.get('ishost') ?? false;
    bool? firsttime = box.get('firsttime') ?? false;

    return User(
      id: id ?? 0,
      name: name ?? "",
      email: email,

      imageUrl: image,

      token: token ?? '',

      refreshtoken: refreshtoken ?? '',
    );
  }

  Future<bool> removeUser(User user) async {
    dynamic boxuser = await Hive.openBox(HiveConst.currentUser);
    boxuser.put('isLoggedIn', false);

    final Box userbox = await Hive.openBox(HiveConst.currentUser);
    await userbox.clear();
    userbox.put('isLoggedIn', false);
    userbox.put('firsttime', false);

    return true;
  }

  Future<String> getToken() async {
    final Box box = await Hive.openBox(HiveConst.currentUser);
    String? token = box.get("token") ?? '';
    return token!;
  }

  Future<String> getRefreshToken() async {
    final Box box = await Hive.openBox(HiveConst.currentUser);
    String? token = box.get("refreshtoken") ?? '';
    return token!;
  }
}
