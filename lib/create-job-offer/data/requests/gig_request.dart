import 'package:gigandjob_web/storage/token_storage.dart';
import 'package:http/http.dart' as http;

class GigRequest {
  final baseUrl = "https://gigandjob-backend.herokuapp.com";

  Future<int?> createGig(String gig, String employeerId) async {
    try {
      final token = await TokenStorage().getToken();
      final response = await http.post(
          Uri.parse(
              baseUrl + "/job-offer/gig/$employeerId"),
          body: gig,
          headers: {
            "Content-type": "application/json",
            'Authorization': 'Bearer $token',
          });
      switch (response.statusCode) {
        case 201:
          return 201;
        default:
          return null;
      }
    }catch(e){
      return null;
    }
  }
}