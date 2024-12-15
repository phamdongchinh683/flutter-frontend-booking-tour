// error_text_widget.dart

import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String errorText;

  const ErrorText({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        errorText,
        style: const TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }
}
