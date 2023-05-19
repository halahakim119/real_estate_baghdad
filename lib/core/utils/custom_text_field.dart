import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final Function(String) onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? prefixText;


  const CustomTextField({
    required this.labelText,
    required this.onChanged,
    required this.validator,
    this.keyboardType,
    this.onSaved,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
    this.prefixText,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = Color.fromARGB(255, 138, 78, 24);
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
      borderSide: BorderSide(
        color: borderColor,
        width: 1.0,
      ),
    );

    return TextFormField(
      decoration: InputDecoration(
          labelText: labelText,
          prefixText: prefixText,
          border: inputBorder,
          labelStyle: TextStyle(color: borderColor),
          enabledBorder: inputBorder,
          focusedBorder: inputBorder,
          suffixIcon: suffixIcon,
          suffixIconColor: const Color.fromARGB(255, 181, 156, 138)),
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      cursorColor: borderColor,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      onSaved: onSaved,
    );
  }
}
