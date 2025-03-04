import 'package:book_tour_app/screens/auth/widgets/branding_text.dart';
import 'package:book_tour_app/screens/auth/widgets/elevated_button_auth.dart';
import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Tour App'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: CldImageWidget(
              publicId: 'tourImages/kcv6bjdq4p2gqw2zjh1i',
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 0.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 0),
                  const BrandingText(),
                  Container(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                  SizedBox(height: 0),
                  SizedBox(height: 0),
                  SizedBox(height: 0),
                  SizedBox(height: 0),
                  SizedBox(height: 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
