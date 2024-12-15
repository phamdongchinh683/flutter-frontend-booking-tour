import 'package:book_tour_app/models/user_model.dart';
import 'package:book_tour_app/screens/auth/widgets/branding_text.dart';
import 'package:book_tour_app/screens/auth/widgets/elevated_button_auth.dart';
import 'package:book_tour_app/screens/auth/widgets/field_input.dart';
import 'package:book_tour_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthSignup extends StatefulWidget {
  const AuthSignup({super.key});

  @override
  _AuthSignupState createState() => _AuthSignupState();
}

class _AuthSignupState extends State<AuthSignup> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  String _role = 'Traveler';
  bool _isLoading = false;
  String _errorMessage = '';
  String? _usernameError;
  String? _passwordError;
  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _phoneError;
  String? _ageError;
  String? _cityError;

  Future<void> _signup() async {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all required fields.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final user = User(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      phone: _phoneController.text,
      age: int.tryParse(_ageController.text) ?? 0,
      role: _role,
      city: _cityController.text,
    );

    try {
      final signup = await AuthService.signup(user);
      if (signup['status'] == 'success') {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        setState(() {
          _isLoading = false;
          _usernameError = '';
          _passwordError = '';
          _firstNameError = '';
          _lastNameError = '';
          _emailError = '';
          _phoneError = '';
          _ageError = '';
          _cityError = '';

          List<String> errors = signup['message'].split(', ');
          for (var error in errors) {
            if (error.contains('Username')) {
              _usernameError = error.trim();
            }
            if (error.contains('Password')) {
              _passwordError = error.trim();
            }
            if (error.contains('First name')) {
              _firstNameError = error.trim();
            }
            if (error.contains('Last name')) {
              _lastNameError = error.trim();
            }
            if (error.contains('Email')) {
              _emailError = error.trim();
            }
            if (error.contains('Phone number')) {
              _phoneError = error.trim();
            }
            if (error.contains('Age')) {
              _ageError = error.trim();
            }
            if (error.contains('City')) {
              _cityError = error.trim();
            }
          }
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'An error occurred: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up',
            style: TextStyle(color: Colors.orange, fontSize: 16)),
        elevation: 0,
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const BrandingText(),
          const SizedBox(height: 60),
          SizedBox(
            height: 286,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FieldInput(
                      nameField: "Role",
                      hintText: 'Select Role',
                      dropdownItems: const ['Traveler', 'Guide'],
                      selectedValue: _role,
                      onChanged: (String? newValue) {
                        setState(() {
                          _role = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    FieldInput(
                      nameField: "First Name",
                      controller: _firstNameController,
                      hintText: 'Your first name',
                    ),
                    if (_firstNameError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _firstNameError!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    const SizedBox(height: 16),
                    FieldInput(
                      nameField: "Last Name",
                      controller: _lastNameController,
                      hintText: 'Your last name',
                    ),
                    if (_lastNameError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _lastNameError!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    const SizedBox(height: 16),
                    FieldInput(
                      nameField: "Username",
                      controller: _usernameController,
                      hintText: 'Your username',
                    ),
                    if (_usernameError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _usernameError!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    const SizedBox(height: 16),
                    FieldInput(
                      nameField: "Email",
                      controller: _emailController,
                      hintText: 'Your mail',
                    ),
                    if (_emailError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _emailError!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    const SizedBox(height: 16),
                    FieldInput(
                      nameField: "Phone Number",
                      controller: _phoneController,
                      hintText: 'Your phone number',
                    ),
                    if (_phoneError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _phoneError!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    const SizedBox(height: 16),
                    FieldInput(
                      nameField: "Age",
                      controller: _ageController,
                      hintText: 'Your age',
                    ),
                    if (_ageError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _ageError!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    const SizedBox(height: 16),
                    FieldInput(
                      nameField: "City",
                      controller: _cityController,
                      hintText: 'Your city',
                    ),
                    if (_cityError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _cityError!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    const SizedBox(height: 16),
                    FieldInput(
                      nameField: "Password",
                      controller: _passwordController,
                      hintText: 'Your password',
                      obscureText: true,
                    ),
                    if (_passwordError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _passwordError!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          _isLoading
              ? const CircularProgressIndicator()
              : ElevatedButtonAuth(
                  onPressed: _signup,
                  buttonText: 'SIGN UP',
                ),
          if (_errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Text(
                _errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      )),
    );
  }
}
