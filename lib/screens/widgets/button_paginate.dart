import 'package:flutter/material.dart';

class ButtonPaginate extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;

  const ButtonPaginate({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF9900),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: const BorderSide(color: Color(0xFFFF9900)), // Border width
          ),
          padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 13.0),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontFamily: 'Ubuntu',
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.normal,
            fontSize: 15.0,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
