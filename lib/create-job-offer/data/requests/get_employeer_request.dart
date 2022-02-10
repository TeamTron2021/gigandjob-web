import 'dart:convert';

import 'package:http/http.dart' as http;

class GetEmployeerRequest {
  final baseUrl = "https://gigandjob-backend.herokuapp.com";

  Future<List<dynamic>> fetchEmployers() async {
    try{
      final response = await http.get(Uri.parse(baseUrl + "/employeer"));
      return jsonDecode(response.body)['message'];
    }catch(error) {
      print(error);
      return [];
    }

  }
}
