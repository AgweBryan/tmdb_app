import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final IconData icon;
  TextInputField(
      {required this.controller,
      required this.icon,
      this.isObscure = false,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        labelStyle: TextStyle(
          fontSize: 20,
        ),
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        border: inputBorder,
      ),
      obscureText: isObscure,
    );
  }
}
