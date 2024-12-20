import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckoutScreen extends StatefulWidget {
  final String tourId; // ID của tour truyền từ màn hình trước
  const CheckoutScreen({Key? key, required this.tourId}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _guideIdController = TextEditingController();
  final _cardNumberController = TextEditingController();
  DateTime? selectedDate;
  int guestCount = 1;
  double totalAmount = 250.0; // Giá mặc định

  // Hàm chọn ngày
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Hàm POST dữ liệu booking đến backend
  Future<void> _submitBooking() async {
    if (_formKey.currentState!.validate()) {
      if (selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a date!")),
        );
        return;
      }

      // Chuẩn bị dữ liệu gửi đi
      final data = {
        "guideId": _guideIdController.text,
        "numberVisitor": guestCount,
        "startTour": selectedDate?.toIso8601String(),
        "cardNumber": _cardNumberController.text,
        "totalAmount": totalAmount,
      };

      try {
        final url =
            'https://backend-tour-booking-node-js-mongodb.onrender.com/api/v1/auth/book-tour/${widget.tourId}';
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Booking successful!")),
          );
          Navigator.pop(context); // Quay về màn hình trước
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to book: ${response.body}")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Field nhập Guide ID
              TextFormField(
                controller: _guideIdController,
                decoration: const InputDecoration(
                  labelText: 'Guide ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Guide is required';
                  } else if (value.length < 8 || value.length > 30) {
                    return 'Guide ID must be between 8 and 30 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Non-refundable text
              const Text(
                'Non-refundable',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Text(
                'You cannot refund your payment when you cancel.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),

              // Select a date
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate != null
                          ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                          : "Select a date",
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const Icon(Icons.calendar_today, color: Colors.orange),
                  ],
                ),
              ),
              const Divider(height: 32, color: Colors.grey),

              // Số lượng khách
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Guests',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (guestCount > 1) {
                            setState(() {
                              guestCount--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove_circle_outline,
                            color: Colors.orange),
                      ),
                      Text(
                        '$guestCount',
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            guestCount++;
                          });
                        },
                        icon: const Icon(Icons.add_circle_outline,
                            color: Colors.orange),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 32, color: Colors.grey),

              // Payment Info
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Card number is required';
                  } else if (value.length < 8 || value.length > 30) {
                    return 'Card number must be between 8 and 30 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Nút thanh toán
              ElevatedButton(
                onPressed: _submitBooking,
                child: const Text("Buy Ticket"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
