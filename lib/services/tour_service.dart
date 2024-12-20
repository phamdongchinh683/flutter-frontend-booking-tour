import 'dart:convert';

import 'package:book_tour_app/models/paginate_model.dart';
import 'package:book_tour_app/models/tour_detail_info_model.dart';
import 'package:book_tour_app/models/tour_model.dart';
import 'package:book_tour_app/storage/secure_storage.dart';
import 'package:http/http.dart' as http;

class TourService {
  static const String _baseUrl = 'http://localhost:8080/api/v1/auth';

  static Future<Paginate<Tour>> getTour({
    required String cursor,
    required String direction,
  }) async {
    try {
      final token = await SecureStorage().retrieveToken();
      if (token == null || token.isEmpty) {
        throw Exception('Token is null or empty');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/tour-list?cursor=$cursor&direction=$direction'),
        headers: {
          'token': token,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return Paginate<Tour>.fromJson(
          data['data'],
          (json) => Tour.fromJson(json),
        );
      } else {
        final errorBody = json.decode(response.body);
        throw Exception(errorBody['message']);
      }
    } catch (e) {
      throw Exception('An error occurred: ${e.toString()}');
    }
  }

  static Future<TourDetailInfo> getTourDetails({required String id}) async {
    try {
      final token = await SecureStorage().retrieveToken();
      if (token == null) throw Exception('Token not found');

      final response = await http.get(
        Uri.parse('$_baseUrl/tour-detail/$id'),
        headers: {
          'token': token,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        return TourDetailInfo.fromJson(data['data']);
      } else {
        final errorBody = json.decode(response.body);
        throw Exception(errorBody['message']);
      }
    } catch (e) {
      throw Exception('An error occurred: ${e.toString()}');
    }
  }

  static Future<Map<String, dynamic>> bookTour(
    String tourId, {
    required String guideId,
    required int numberOfVisitors,
    required String startTourDate,
    required String startTime,
    required String endTime,
    required int status,
    required String cardNumber,
    required double totalAmount,
  }) async {
    try {
      final token = await SecureStorage().retrieveToken();
      if (token == null) throw Exception('Token not found');

      final Map<String, dynamic> requestBody = {
        'guideId': guideId,
        'numberVisitor': numberOfVisitors,
        'startTour': startTourDate,
        'startTime': startTime,
        'endTime': endTime,
        'status': status,
        'cardNumber': cardNumber,
        'totalAmount': totalAmount,
      };

      final response = await http.post(
        Uri.parse('$_baseUrl/book-tour/$tourId'),
        headers: {
          'token': token,
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> errorBody = json.decode(response.body);
        throw Exception(errorBody['message'] ?? 'Unknown error');
      }
    } catch (e) {
      throw Exception('Error booking tour: ${e.toString()}');
    }
  }
}
