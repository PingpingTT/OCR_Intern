import 'package:flutter/material.dart';

class FormfillTemplate extends StatelessWidget {
final String hintText;
  final Color fillColor;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const FormfillTemplate({
    super.key,
    required this.hintText,
    required this.fillColor,
    required this.controller, 
    this.keyboardType = TextInputType.text, 
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, 
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: fillColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
