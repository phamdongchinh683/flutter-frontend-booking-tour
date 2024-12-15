import 'package:flutter/material.dart';

class BrandingText extends StatelessWidget {
  const BrandingText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'EXPLORE',
          style: TextStyle(
            fontSize: 45.0,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.bold,
            color: Color(0xFFFF9900),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          '- IF NOT NOW, WHEN? -',
          style: TextStyle(
            fontSize: 15.0,
            fontFamily: 'Ubuntu',
            color: Color(0xFFFF9900),
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}
