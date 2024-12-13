import 'package:book_tour_app/screens/auth/widgets/branding_text.dart';
import 'package:book_tour_app/screens/auth/widgets/elevated_button_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccessPage extends StatefulWidget {
  const AccessPage({super.key});

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
              child: Image(
                image: AssetImage("assets/images/avatar.png"),
                fit: BoxFit.cover,
                
              ),
            ),
          

          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [BrandingText()],
                  ),
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.all(30.0),
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButtonAuth(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          buttonText: 'LOG IN',
                        ),
                        const SizedBox(height: 17),
                        ElevatedButtonAuth(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          buttonText: 'SIGN UP',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
