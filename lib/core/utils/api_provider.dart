import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiProvider {
  static final String baseUrl = 'http://35.180.62.182/api';

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post to endpoint: $endpoint');
    }
  }
}
