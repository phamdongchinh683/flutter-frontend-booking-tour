import 'package:flutter/material.dart';

class InputTourField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool readOnly;

  InputTourField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFF9900),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFF9900),
          ),
        ),
      ),
      validator: validator,
    );
  }
}
