import 'dart:convert';

import 'package:http/http.dart' as http;

class GetPostulationRequest {
  final baseUrl = "https://gigandjob-backend.herokuapp.com";

  Future<List<dynamic>> fetchPostulations() async {
    try{
      final response = await http.get(Uri.parse(baseUrl + "/postulation"));
      return jsonDecode(response.body)['message'];
    }catch(error) {
      print(error);
      return [];
    }

  }
}
