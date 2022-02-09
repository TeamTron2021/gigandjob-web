import 'dart:convert';

import 'package:http/http.dart' as http;

class GetEmployeerRequest {
  final baseUrl = "http://localhost:3000";

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
