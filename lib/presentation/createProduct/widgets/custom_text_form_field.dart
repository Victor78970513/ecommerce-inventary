import 'package:flutter/material.dart';

class CustomInputTextFormField extends StatelessWidget {
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final String? initialValue;
  final TextEditingController? textController;

  const CustomInputTextFormField({
    super.key,
    this.keyboardType,
    this.obscureText = false,
    this.hintText,
    this.labelText,
    this.helperText,
    this.initialValue,
    this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: TextFormField(
        initialValue: initialValue,
        autofocus: false,
        controller: textController,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.grey),
            labelStyle: const TextStyle(color: Colors.grey),
            hintText: hintText,
            labelText: labelText,
            helperText: helperText,
            floatingLabelStyle: const TextStyle(color: Colors.black),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              // borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10),
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
