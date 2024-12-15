import 'package:flutter/material.dart';

class ElevatedButtonAuth extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const ElevatedButtonAuth({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 193,
      height: 43,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF9900),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 90.0),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontFamily: 'Ubuntu',
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
}
