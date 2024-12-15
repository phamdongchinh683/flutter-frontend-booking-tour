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

          List<String> errors = signup['message'].split(',');
          print(errors);
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
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.orange), 
        onPressed: () {
          Navigator.pop(context); 
        },
      ),
      title: const Text(
        'Sign Up',
        style: TextStyle(color: Colors.orange, fontSize: 16),
      ),
     
    ),

      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/avatar.png",
              fit: BoxFit.cover, ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, 
                  children: [
                    FieldInput(
                      hintText: 'Select Role',
                      dropdownItems: ['Traveler', 'Guide'],
                      selectedValue: _role,
                      onChanged: (String? newValue) {
                        setState(() {
                          _role = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    // Các trường nhập du lieu
                    FieldInput(controller: _firstNameController, hintText: 'First name'),
                    if (_firstNameError != null) _buildErrorText(_firstNameError!),
                    const SizedBox(height: 16),
                    FieldInput(controller: _lastNameController, hintText: 'Last name'),
                    if (_lastNameError != null) _buildErrorText(_lastNameError!),
                    const SizedBox(height: 16),
                    FieldInput(controller: _usernameController, hintText: 'User name'),
                    if (_usernameError != null) _buildErrorText(_usernameError!),
                    const SizedBox(height: 16),
                    FieldInput(controller: _emailController, hintText: 'Email'),
                    if (_emailError != null) _buildErrorText(_emailError!),
                    const SizedBox(height: 16),
                    FieldInput(controller: _phoneController, hintText: 'Phone number'),
                    if (_phoneError != null) _buildErrorText(_phoneError!),
                    const SizedBox(height: 16),
                    FieldInput(controller: _ageController, hintText: 'Age'),
                    if (_ageError != null) _buildErrorText(_ageError!),
                    const SizedBox(height: 16),
                    FieldInput(controller: _cityController, hintText: "City name"),
                    if (_cityError != null) _buildErrorText(_cityError!),
                    const SizedBox(height: 16),
                    FieldInput(controller: _passwordController, obscureText: true, hintText: 'Password'),
                    if (_passwordError != null) _buildErrorText(_passwordError!),
                    const SizedBox(height: 16),
                    
                    _isLoading
                        ? const CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40.0), 
                            child: ElevatedButtonAuth(
                              onPressed: _signup,
                              buttonText: 'SIGN UP',
                            ),
                          ),
                    if (_errorMessage.isNotEmpty) _buildErrorText(_errorMessage),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Hiển thị thông báo lỗi
  Padding _buildErrorText(String errorText) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        errorText,
        style: const TextStyle(color: Colors.red, fontSize: 16,fontWeight: FontWeight.bold,),
      ),
    );
  }
}