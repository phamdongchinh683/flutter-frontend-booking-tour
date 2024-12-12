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
          'EXPLORA',
          style: TextStyle(
            fontSize: 45.0,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w900,
            color: Color(0xFFFF9900),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          '- IF NOT NOW, WHEN? -',
          style: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Ubuntu',
            color: Color(0xFFFF9900),
          ),
        ),
      ],
    );
  }
}
