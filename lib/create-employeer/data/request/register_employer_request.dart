import 'package:gigandjob_web/create-employeer/data/models/employeer.dart';
import 'package:http/http.dart' as http;

class RegisterEmployerRequest {
  final String baseUrl = "https://gigandjob-backend.herokuapp.com";

  Future<int?> addEmployeer(String employeer) async {
    try {
      final response = await http
          .post(Uri.parse(baseUrl + "/employeer"), body: employeer, headers: {
        "Content-type": "application/json",
      });
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
