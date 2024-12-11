import 'package:book_tour_app/services/auth_service.dart';
import 'package:book_tour_app/storage/secure_storage.dart';
import 'package:flutter/material.dart';

class AuthLogin extends StatefulWidget {
  const AuthLogin({super.key});

  @override
  State<AuthLogin> createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  String errorMessage = '';
  final AuthService _authService = AuthService();

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
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
      final token = await _authService.login(username, password);
      await SecureStorage().saveToken(token);

      Navigator.pushReplacementNamed(context, '/dashboard');
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
      appBar: AppBar(title: const Text('Login Page', style: TextStyle(
        color: Colors.orange,
        fontSize: 16,
      ),)),
      // Mau background 
      
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/avatar.png'),  // Sử dụng AssetImage trực tiếp
            fit: BoxFit.cover,  // Hình nền phủ toàn bộ màn hình
          ),
        ),
        child: Center(
          child:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [  
           Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, 
                crossAxisAlignment: CrossAxisAlignment.center, 
                children: [
                  Text(
                    'EXPLORA',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    '- IF NOT NOW, WHEN? -',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
           // Username
           TextField(
             controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',hintStyle: TextStyle(
                      color:  Color.fromARGB(255, 52, 235, 91)
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
            const SizedBox(height: 30),
            // Password
            TextField(
              controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',hintStyle: TextStyle(
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
                obscureText: true,// An noi dung van ban
              ),
            const SizedBox(height: 50),
              // Login Button
             isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
                        ),
                        child: const Text(
                          'LOG IN',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.orange,

                ),),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text('Sign Up', style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 52, 235, 91)
                  ),),
                ),
              ],
            ),
          ],
        ),
      ),
        ),
      ),
    );
  }
}
