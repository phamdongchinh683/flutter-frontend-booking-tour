import 'package:flutter/material.dart';

class FieldInput extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? nameField;
  final bool obscureText;

  final List<String>? dropdownItems;
  final String? selectedValue;
  final void Function(String?)? onChanged;

  const FieldInput({
    super.key,
    this.controller,
    required this.hintText,
    this.obscureText = false,
    this.dropdownItems,
    this.selectedValue,
    this.onChanged,
    this.nameField,
  });

  @override
  Widget build(BuildContext context) {
    if (dropdownItems != null) {
      return SizedBox(
        child: DropdownButtonFormField<String>(
          value: selectedValue,
          onChanged: onChanged,
          items: dropdownItems!.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFFB6B6B6)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Color(0xFFFF9900),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Color(0xFFFF9900),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Color(0xFFFF9900),
              ),
            ),
            fillColor: Colors.transparent,
            filled: true,
          ),
        ),
      );
    } else {
      return SizedBox(
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: nameField,
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFFB6B6B6)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 42.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Color(0xFFFF9900),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Color(0xFFFF9900),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Color(0xFFFF9900),
              ),
            ),
            fillColor: Colors.transparent,
            filled: true,
          ),
        ),
      );
    }
  }
}
