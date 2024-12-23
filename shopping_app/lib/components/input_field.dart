import 'package:flutter/material.dart';

class MyCustomInputField extends StatelessWidget {
  final String labelText;
  final IconData iconData;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const MyCustomInputField({
    Key? key,
    required this.labelText,
    required this.iconData,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(iconData),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
