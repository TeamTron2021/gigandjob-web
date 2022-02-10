import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRequest {
  final baseUrl = "https://gigandjob-backend.herokuapp.com";

  Future<int?> authAdmin(String adminCredencials) async {
    try {
      final response = await http.post(Uri.parse(baseUrl + "/auth/admin"),
          body: adminCredencials,
          headers: {
            "Content-type": "application/json",
          });
      print(jsonDecode(response.body));
      switch (response.statusCode) {
        case 201:
          return 201;
        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }
}
