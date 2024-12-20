import 'dart:convert';

import 'package:book_tour_app/models/auth_profile_model.dart';
import 'package:book_tour_app/models/user_model.dart';
import 'package:book_tour_app/storage/secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl =
      'https://backend-tour-booking-node-js-mongodb.onrender.com/api/v1/auth';

  static Future<Map<String, dynamic>> signup(User user) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/sign-up'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        final errorBody = json.decode(response.body);
        return {'message': errorBody['message']};
      }
    } catch (e) {
      return {'message': 'An error occurred: ${e.toString()}'};
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

  Future<Map<String, dynamic>> sendOtp(String email) async {
    final Uri otpUrl = Uri.parse('$_baseUrl/send-otp');

    final response = await http.post(
      otpUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        final errorBody = json.decode(response.body);
        return {'message': errorBody['message']};
      }
    } catch (e) {
      return {'message': 'An error occurred: ${e.toString()}'};
    }
  }

  Future<Map<String, dynamic>> newPassword(String password, String otp) async {
    final Uri loginUrl = Uri.parse('$_baseUrl/my-book-tour');

    final response = await http.get(
      loginUrl,
      headers: {'Content-Type': 'application/json'},
    );

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        final errorBody = json.decode(response.body);
        return {'message': errorBody['message']};
      }
    } catch (e) {
      return {'message': 'An error occurred: ${e.toString()}'};
    }
  }

  Future<List<Map<String, dynamic>>> MyBookedTour() async {
    final Uri url = Uri.parse('$_baseUrl/my-book-tour');

    try {
      final token = await SecureStorage().retrieveToken();
      if (token == null || token.isEmpty) {
        throw Exception('Token is null or empty');
      }
      final response = await http.get(
        url,
        headers: {'token': token},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        final errorBody = json.decode(response.body);
        throw Exception(errorBody['message'] ?? 'Unknown error');
      }
    } catch (e) {
      throw Exception('An error occurred: ${e.toString()}');
    }
  }

  Future<List<Map<String, dynamic>>> GetGuideList() async {
    final Uri url = Uri.parse('$_baseUrl/my-book-tour');

    try {
      final token = await SecureStorage().retrieveToken();
      if (token == null || token.isEmpty) {
        throw Exception('Token is null or empty');
      }
      final response = await http.get(
        url,
        headers: {'token': token},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        final errorBody = json.decode(response.body);
        throw Exception(errorBody['message'] ?? 'Unknown error');
      }
    } catch (e) {
      throw Exception('An error occurred: ${e.toString()}');
    }
  }

  static Future<UserProfile> getUserProfile() async {
    final url = Uri.parse('$_baseUrl/profile');

    try {
      final token = await SecureStorage().retrieveToken();
      if (token == null || token.isEmpty) {
        throw Exception('Token is null or empty');
      }
      final response = await http.get(
        url,
        headers: {'token': token},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return UserProfile.fromJson(data);
      } else {
        throw Exception('Failed to fetch user profile');
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      throw Exception('Error: $e');
    }
  }
}
