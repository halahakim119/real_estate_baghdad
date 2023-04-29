import 'package:flutter/material.dart';

import 'validation.dart';

class CustomTextField extends StatelessWidget {
  final controller;
  String type;
  String label;

  CustomTextField(
      {super.key,
      required this.controller,
      required this.type,
      required this.label});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      textAlign: TextAlign.center,
      validator: type == "email"
          ? validateEmail
          : type == "phoneNumber"
              ? validatePhone
              : type == "text"
                  ? validateText
                  : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        alignLabelWithHint: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 138, 78, 24),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(50.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 138, 78, 24),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}

class ConfirmPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String Function(String?)? validator;

  const ConfirmPasswordField({
    Key? key,
    required this.controller,
    required this.label,
    required this.validator,
  }) : super(key: key);

  @override
  _ConfirmPasswordFieldState createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      textAlign: TextAlign.center,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        alignLabelWithHint: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 138, 78, 24),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(50.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 138, 78, 24),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(50.0),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
