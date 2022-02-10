import 'dart:convert';

import 'package:http/http.dart' as http;

class InterviewRequest {
  final baseUrl = "https://gigandjob-backend.herokuapp.com";

  Future<int?> addInterview(String interview, String postulationId) async {
    try {
      final response = await http.post(
          Uri.parse(
              baseUrl + "/interview/$postulationId"),
          body: interview,
          headers: {
            "Content-type": "application/json",
          });
      print(response.statusCode);
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
