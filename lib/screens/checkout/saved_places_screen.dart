import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'checkout_screen.dart'; // Đảm bảo đã import file CheckoutScreen

class SavedPlacesScreen extends StatefulWidget {
  const SavedPlacesScreen({Key? key}) : super(key: key);

  @override
  State<SavedPlacesScreen> createState() => _SavedPlacesScreenState();
}

class _SavedPlacesScreenState extends State<SavedPlacesScreen> {
  List<dynamic> tours = []; // Danh sách tour
  bool isLoading = true; // Trạng thái đang tải

  @override
  void initState() {
    super.initState();
    fetchTours(); // Gọi API lấy danh sách tour
  }

  // Hàm lấy danh sách tour từ API
  Future<void> fetchTours() async {
    const String url =
        "https://backend-tour-booking-node-js-mongodb.onrender.com/api/v1/auth/tour-list/cursor&direction=next";
    try {
      final response = await http.get(Uri.parse(url)); // Gọi API GET
      if (response.statusCode == 200) {
        setState(() {
          tours = jsonDecode(response.body); // Parse dữ liệu JSON
          isLoading = false; // Ngừng trạng thái loading
        });
      } else {
        print("Failed to fetch tours: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Places'), // Tiêu đề màn hình
      ),
      body: 
           ListView.builder(
              itemCount: tours.length, // Số lượng tour
              itemBuilder: (context, index) {
                final tour = tours[index];
                return ListTile(
                  title: Text(tour['name']), // Tên tour
                  subtitle: Text(tour['description']), // Mô tả tour
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Chuyển đến màn hình Checkout khi nhấn vào một tour
                    Navigator.pushNamed(
                      context,
                      '/checkout',
                      arguments: {'tourId': tour['_id']},
                    );
                  },
                );
              },
            ),
    );
  }
}
