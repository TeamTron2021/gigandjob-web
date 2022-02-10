import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gigandjob_web/storage/jwt_model.dart';

class TokenStorage {
  final _storage = const FlutterSecureStorage();

  Future writeSecureData(JwtToken data) async {
    await _storage.write(
        key: 'token', value: data.token.toString()
    );
  }


  Future<String> getToken() async{
    return await _storage.read(key: 'token') as String ;
  }

  closeSession() async {
    await _storage.deleteAll();
  }
}