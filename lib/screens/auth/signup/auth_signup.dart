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
        title: const Text('Sign Up',
            style: TextStyle(color: Colors.orange, fontSize: 16)),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(child: 
          Image.asset("assets/images/avatar.png",
          fit: BoxFit.cover,),
          ),
          Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,child: 
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
                ),
                const SizedBox(height: 16),
                // First name
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    hintText: 'First Name', hintStyle: TextStyle(
                      color: Color.fromARGB(255, 52, 235, 91)
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),fillColor: Colors.white,  
                    filled: true, 
                  ),
                ),
                if (_firstNameError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _firstNameError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 16),
                // Last name
                 TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    hintText: 'Last name',hintStyle: TextStyle(
                      color: Color.fromARGB(255, 52, 235, 91)
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),fillColor: Colors.white,  
                    filled: true, 
                  ),
                ),
                if (_lastNameError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _lastNameError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 16),
                // User name
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Username',hintStyle: TextStyle(
                      color: Color.fromARGB(255, 52, 235, 91)
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),fillColor: Colors.white,  
                    filled: true, 
                  ),
                ),
                if (_usernameError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _usernameError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 16),
                // Email
                 TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',hintStyle: TextStyle(
                      color:Color.fromARGB(255, 52, 235, 91)
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),fillColor: Colors.white,  
                    filled: true, 
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                if (_emailError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _emailError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 16),
                // Phone number
               TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: 'Phone number',hintStyle: TextStyle(
                      color: Color.fromARGB(255, 52, 235, 91)
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),fillColor: Colors.white,  
                    filled: true, 
                  ),
                ),
                if (_phoneError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _phoneError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 16),
                // Age
               TextField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    hintText: 'Age',hintStyle: TextStyle(
                      color: Color.fromARGB(255, 52, 235, 91)
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    fillColor: Colors.white,  
                    filled: true, 
                  ),
                ),
                if (_ageError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _ageError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 16),
                //City name
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    hintText: 'City Name',hintStyle: TextStyle(
                      color: Color.fromARGB(255, 52, 235, 91)
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    fillColor: Colors.white,  
                    filled: true, 
                  ),
                ),
                if (_cityError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _cityError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 16),
                // Password
               TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',hintStyle: TextStyle(
                      color: Color.fromARGB(255, 52, 235, 91),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),fillColor: Colors.white,  
                    filled: true, 
                  ),
                  obscureText: true,
                ),
                if (_passwordError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _passwordError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 16),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButtonAuth(
                        onPressed: _signup,
                        buttonText: 'SIGN UP',
                      ),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
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
            ),
          ),
        ),
        ),
        ],
      
      ),
    );
  }
}
