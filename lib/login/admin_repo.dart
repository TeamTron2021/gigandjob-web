import 'dart:convert';

import 'package:gigandjob_web/constants.dart';
import 'package:gigandjob_web/login/auth_request.dart';
import 'package:gigandjob_web/storage/jwt_model.dart';
import 'package:gigandjob_web/storage/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminRepository {

  final AuthRequest request = AuthRequest() ;


  AdminRepository();

  Future<String> authenticate({required String username, required String password}) async {
    final auth = jsonEncode(
      <String, String>{"email": username, "password": password}
    );

    final response = await request.authAdmin(auth);
    print(response);
    if(response == null){
      return 'failed';
    }else {
      return 'success';
    }

  }

  Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await TokenStorage().closeSession();
    return;
  }

  Future<void> persistToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(tokenValue, token);
    return; 
  }

  Future<bool> hasToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Future.delayed(const Duration(seconds: 2));
  String? token = prefs.getString(tokenValue);
  //print(token);
  if (token != null ) {
    return true;
  } 
  return false;
}


}

class FakeAuthenticationRepository extends AdminRepository {
  FakeAuthenticationRepository() : super();
}