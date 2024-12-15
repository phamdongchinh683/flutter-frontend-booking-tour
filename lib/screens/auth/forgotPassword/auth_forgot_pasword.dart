import 'dart:async';

import 'package:book_tour_app/screens/auth/widgets/auth_alert.dart';
import 'package:book_tour_app/screens/auth/widgets/branding_text.dart';
import 'package:book_tour_app/screens/auth/widgets/elevated_button_auth.dart';
import 'package:book_tour_app/screens/auth/widgets/field_input.dart';
import 'package:book_tour_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AuthForgotPassword extends StatefulWidget {
  const AuthForgotPassword({super.key});

  @override
  State<AuthForgotPassword> createState() => _AuthForgotPasswordState();
}

class _AuthForgotPasswordState extends State<AuthForgotPassword> {
  final TextEditingController _usernameController = TextEditingController();
  bool isLoading = false;
  String errorMessage = '';
  final AuthService _authService = AuthService();

  Future<void> _sendOTP() async {
    final email = _usernameController.text.trim();

    if (email.isEmpty || email.startsWith("@") || !email.contains('@')) {
      setState(() {
        errorMessage = 'Please enter a valid email address.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final receiveOtp = await _authService.sendOtp(email);
      if (receiveOtp['status'] == 'success') {
        final success = receiveOtp['data'];
        AuthAlert(
          title: "Notification",
          description: success,
          type: AlertType.success,
        ).show(context);
        final _timer = Timer(const Duration(seconds: 2),
            () => Navigator.pushNamed(context, '/update-new-password'));
      } else {
        AuthAlert(
          title: "Notification",
          description: receiveOtp['message'],
          type: AlertType.error,
        ).show(context);
      }
    } catch (e) {
      final errorDetail = e.toString();
      final List<String> error = errorDetail.split(": ");
      AuthAlert(
        title: "Failed",
        description: error[0],
        type: AlertType.error,
      ).show(context);
    } finally {
      (setState(() {
        isLoading = false;
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 16,
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 286,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [BrandingText()],
                  ),
                ),
                const SizedBox(height: 60),
                const Text(
                  "Please enter your email to receive otp",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFB6B6B6),
                  ),
                ),
                const SizedBox(height: 12),
                FieldInput(
                  nameField: "Email",
                  controller: _usernameController,
                  hintText: 'Your email address',
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            child: ElevatedButtonAuth(
                              onPressed: _sendOTP,
                              buttonText: 'Send OTP',
                            ),
                          ),
                  ],
                ),
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
