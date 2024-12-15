import 'package:flutter/material.dart';

class FieldInput extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
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
  });

  @override
  Widget build(BuildContext context) {
    if (dropdownItems != null) {
      return SizedBox(
       width: double.infinity,
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
            hintStyle: const TextStyle(color: Color.fromARGB(255, 56, 241, 49)),
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
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      );
    } else {
      return SizedBox(
        width: double.infinity,
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Color.fromARGB(255, 56, 241, 49)),
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
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      );
    }
  }
}
