import 'dart:convert';

import 'package:http/http.dart';


class JobOfferRequest {
  final baseUrl = "http://10.0.2.2:3000";

  Future<int?> addJobOffer(String jobOffer) async {
    try {
      final response = await post(Uri.parse(baseUrl+"/job-offer/deea93d1-d683-4d7e-8dde-9d319d054345"), body: jobOffer);
      print(response);
      switch(response.statusCode) {
        case 201: return 201;
        default: return null;
      }
    }catch(e) {
      return null;
    }
  }
}