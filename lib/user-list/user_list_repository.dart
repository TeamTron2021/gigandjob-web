import 'dart:convert';

import 'package:gigandjob_web/user-list/user_list_model.dart';
import 'package:http/http.dart' as http;

abstract class UserListRepository {
  Future<List<UserModel>> getUsers();
  Future<void> suspend(String id);
  Future<void> reactive(String id);
}

class EndpointUserListRepository extends UserListRepository {
  final Uri uri;
  final String url;
  final http.Client httpClient;

  EndpointUserListRepository({required this.url})
      : uri = Uri.parse(url),
        httpClient = http.Client();

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List<UserModel> values = List<UserModel>.from(
          json.decode(response.body).map((data) => UserModel.fromJson(data)));
      return values;
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Future<void> suspend(String id) async {
    print("$url/$id/suspend");
    final response = await http.post(Uri.parse("$url/$id/suspend"), body: {});
    if (response.statusCode >= 400) {
      throw Exception('Failed to suspend users');
    }
  }

  @override
  Future<void> reactive(String id) async {
    final response = await http.post(Uri.parse("$url/$id/reactive"), body: {});
    if (response.statusCode >= 400) {
      throw Exception('Failed to suspend users');
    }
  }
}
