import 'dart:async';

import 'package:book_tour_app/screens/auth/widgets/auth_alert.dart';
import 'package:book_tour_app/screens/widgets/input_tour_field.dart';
import 'package:book_tour_app/services/tour_service.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BookTourScreen extends StatefulWidget {
  final String tourId;

  const BookTourScreen({Key? key, required this.tourId}) : super(key: key);

  @override
  _BookTourPageState createState() => _BookTourPageState();
}

class _BookTourPageState extends State<BookTourScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _guideIdController = TextEditingController();
  final TextEditingController _numberOfVisitorsController =
      TextEditingController();
  final TextEditingController _startTourDateController =
      TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();

  final int _status = 0;

  void _bookTour() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final response = await TourService.bookTour(widget.tourId,
            guideId: _guideIdController.text,
            numberOfVisitors: int.parse(_numberOfVisitorsController.text),
            startTourDate: _startTourDateController.text,
            startTime: _startTimeController.text,
            endTime: _endTimeController.text,
            status: _status,
            cardNumber: _cardNumberController.text,
            totalAmount: double.parse(_totalAmountController.text));
        if (response['status'] == 'success') {
          const AuthAlert(
            title: "Notification",
            description: "Tour booked successfully!!",
            type: AlertType.success,
          ).show(context);
          Timer(const Duration(seconds: 1),
              () => Navigator.pushReplacementNamed(context, '/dashboard'));
        }
      } catch (e) {
        const AuthAlert(
          title: "Failed",
          description: "Please check your information",
          type: AlertType.error,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Tour',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF9900),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              InputTourField(
                controller: _guideIdController,
                labelText: 'Guide ID',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the guide ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InputTourField(
                controller: _numberOfVisitorsController,
                labelText: 'Number of Visitors',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of visitors';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InputTourField(
                controller: _startTourDateController,
                labelText: 'Start Tour Date (YYYY-MM-DD)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the start date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InputTourField(
                controller: _startTimeController,
                labelText: 'Start Time (HH:MM AM/PM)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the start time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InputTourField(
                controller: _endTimeController,
                labelText: 'End Time (HH:MM AM/PM)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the end time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InputTourField(
                controller: _cardNumberController,
                labelText: 'Card Number',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the card number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InputTourField(
                controller: _totalAmountController,
                labelText: 'Total Amount',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the total amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _bookTour,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9900),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14.0,
                    horizontal: 60.0,
                  ),
                ),
                child: const Text(
                  "Book Now",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
