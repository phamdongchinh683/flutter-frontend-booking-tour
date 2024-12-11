import 'dart:convert';

import 'package:book_tour_app/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl =
      'https://backend-tour-booking-node-js-mongodb.onrender.com/api/v1/auth';

  static Future<bool> signup(User user) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/sign-up'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Signup failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during signup: $e');
    }
  }

  Future<String> login(String username, String password) async {
    final Uri loginUrl = Uri.parse('$_baseUrl/login');

    final response = await http.post(
      loginUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['data'];
    } else {
      final error = jsonDecode(response.body)['message'];
      throw Exception(error ?? 'Login failed');
    }
  }
}
