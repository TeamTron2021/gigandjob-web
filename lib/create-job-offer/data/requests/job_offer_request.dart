import 'dart:convert';

import 'package:gigandjob_web/storage/token_storage.dart';
import 'package:http/http.dart' as http;

class JobOfferRequest {
  final baseUrl = "https://gigandjob-backend.herokuapp.com";

  Future<int?> addJobOffer(String jobOffer, String employeerId) async {
    try {
      final token = await TokenStorage().getToken();
      final response = await http.post(
          Uri.parse(
              baseUrl + "/job-offer/$employeerId"),
          body: jobOffer,
          headers: {
            "Content-type": "application/json",
            'Authorization': 'Bearer $token',
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
