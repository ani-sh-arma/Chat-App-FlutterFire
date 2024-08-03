// ignore_for_file: use_super_parameters
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const CustomInputField({
    Key? key,
    required this.labelText,
    required this.icon,
    this.obscureText = false,
    required this.controller,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      autocorrect: false,
      enableSuggestions: false,
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
