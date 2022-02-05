import 'package:gigandjob_web/constants.dart';
import 'package:gigandjob_web/login/admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminRepository {

  Future<void> singOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return;
  }


  Future<Admin?> authenticate({required String username, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));

    if (username == 'admin' && password == 'admin') {
      return Admin(username, password);
    }
    return null;
  }

  Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
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
  if (token != null && token.length > 10) {
    return true;
  } 
  return false;
}


}

class FakeAuthenticationRepository extends AdminRepository {}