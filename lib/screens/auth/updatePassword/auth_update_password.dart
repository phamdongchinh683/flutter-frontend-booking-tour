import 'dart:async';

import 'package:book_tour_app/screens/auth/widgets/auth_alert.dart';
import 'package:book_tour_app/screens/auth/widgets/branding_text.dart';
import 'package:book_tour_app/screens/auth/widgets/elevated_button_auth.dart';
import 'package:book_tour_app/screens/auth/widgets/field_input.dart';
import 'package:book_tour_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AuthUpdatePassword extends StatefulWidget {
  const AuthUpdatePassword({super.key});

  @override
  State<AuthUpdatePassword> createState() => _AuthUpdatePasswordState();
}

class _AuthUpdatePasswordState extends State<AuthUpdatePassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool isLoading = false;
  String errorMessage = '';
  final AuthService _authService = AuthService();

  Future<void> _sendOTP() async {
    final password = _passwordController.text.trim();
    final otp = _otpController.text.trim();
    if (password.isEmpty || otp.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all fields.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final newPassword = await _authService.newPassword(password, otp);
      if (newPassword['status'] == 'success') {
        const AuthAlert(
          title: "Notification",
          description: "Updated your password",
          type: AlertType.success,
        ).show(context);
        final _timer = Timer(const Duration(seconds: 1),
            () => Navigator.pushReplacementNamed(context, '/login'));
      } else {
        AuthAlert(
          title: "Notification",
          description: newPassword['message'],
          type: AlertType.error,
        ).show(context);
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
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
                  "Please enter your otp from email and your new password",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFB6B6B6),
                  ),
                ),
                const SizedBox(height: 12),
                FieldInput(
                  nameField: "OTP",
                  controller: _otpController,
                  hintText: 'Enter your otp code here',
                ),
                const SizedBox(height: 12),
                FieldInput(
                  nameField: "New Password",
                  controller: _passwordController,
                  hintText: 'Your new password',
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
                              buttonText: 'Update',
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
