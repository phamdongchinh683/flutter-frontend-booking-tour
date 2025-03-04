import 'dart:async';

import 'package:book_tour_app/routers/router_app.dart';
import 'package:book_tour_app/screens/auth/widgets/auth_alert.dart';
import 'package:book_tour_app/screens/widgets/input_tour_field.dart';
import 'package:book_tour_app/services/auth_service.dart';
import 'package:book_tour_app/services/tour_service.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BookTourScreen extends StatefulWidget {
  final String tourId;
  final int totalPrice;
  final int totalPeople;

  const BookTourScreen(
      {Key? key,
      required this.tourId,
      required this.totalPrice,
      required this.totalPeople})
      : super(key: key);

  @override
  _BookTourPageState createState() => _BookTourPageState();
}

class _BookTourPageState extends State<BookTourScreen> {
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> _guides = [];
  String? _selectedGuideId;

  final TextEditingController _numberOfVisitorsController =
      TextEditingController();
  final TextEditingController _startTourDateController =
      TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();

  final int _status = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _totalAmountController.text = widget.totalPrice.toString();
    _numberOfVisitorsController.text = widget.totalPeople.toString();
    _fetchGuides();
  }

  Future<void> _fetchGuides() async {
    try {
      final response = await AuthService().getGuideList();
      setState(() {
        _guides = response;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _startTourDateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(TextEditingController controller) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        controller.text = picked.format(context);
      });
    }
  }

  void _bookTour() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedGuideId == null) {
        AuthAlert(
          title: "Error",
          description: "Please select a guide.",
          type: AlertType.error,
        ).show(context);
        return;
      }

      try {
        final response = await TourService.bookTour(
          widget.tourId,
          guideId: _selectedGuideId!,
          numberOfVisitors: int.parse(_numberOfVisitorsController.text),
          startTourDate: _startTourDateController.text,
          startTime: _startTimeController.text,
          endTime: _endTimeController.text,
          status: _status,
          cardNumber: _cardNumberController.text,
          totalAmount: double.parse(_totalAmountController.text),
        );

        if (response['status'] == 'success') {
          AuthAlert(
            title: "Success",
            description: "Tour booked successfully!",
            type: AlertType.success,
          ).show(context);
          Timer(const Duration(seconds: 1), () {
            Navigator.pushReplacementNamed(context, RouterApp.dashboardRoute);
          });
        }
      } catch (e) {
        AuthAlert(
          title: "Failed",
          description: "Please check your information.",
          type: AlertType.error,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Tour',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF9900),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _isLoading
                  ? const CircularProgressIndicator()
                  : _guides.isEmpty
                      ? const Text('No guides available')
                      : DropdownButtonFormField<String>(
                          value: _selectedGuideId,
                          hint: const Text('Select a Guide'),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedGuideId = newValue;
                            });
                          },
                          validator: (value) =>
                              value == null ? 'Please select a guide' : null,
                          items: _guides.map<DropdownMenuItem<String>>((guide) {
                            return DropdownMenuItem<String>(
                              value: guide['_id'].toString(),
                              child: Text(
                                  '${guide['fullName']['firstName']} ${guide['fullName']['lastName']}'),
                            );
                          }).toList(),
                        ),
              const SizedBox(height: 16),
              InputTourField(
                  controller: _numberOfVisitorsController,
                  labelText: 'Number of Visitors',
                  keyboardType: TextInputType.number,
                  readOnly: true,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the number of visitors'
                      : int.tryParse(value) == null
                          ? 'Enter a valid number'
                          : null),
              const SizedBox(height: 16),
              TextFormField(
                controller: _startTourDateController,
                readOnly: true,
                onTap: _selectDate,
                decoration: const InputDecoration(
                  labelText: "Start Tour Date",
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select a date'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _startTimeController,
                readOnly: true,
                onTap: () => _selectTime(_startTimeController),
                decoration: const InputDecoration(
                  labelText: "Start Time",
                  suffixIcon: Icon(Icons.access_time),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select a start time'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _endTimeController,
                readOnly: true,
                onTap: () => _selectTime(_endTimeController),
                decoration: const InputDecoration(
                  labelText: "End Time",
                  suffixIcon: Icon(Icons.access_time),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select a end time'
                    : null,
              ),
              const SizedBox(height: 16),
              InputTourField(
                  controller: _cardNumberController,
                  labelText: 'Card Number',
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the card number'
                      : null),
              const SizedBox(height: 16),
              InputTourField(
                  controller: _totalAmountController,
                  labelText: 'Total Amount',
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the total amount'
                      : double.tryParse(value) == null
                          ? 'Enter a valid amount'
                          : null),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _bookTour,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9900),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  padding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 60.0),
                ),
                child: const Text("Book Now",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
