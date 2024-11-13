import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  String hint;
  TextInputType keyboardType;
  bool isSecureText;
  Validator? validator;
  TextEditingController? controller;

  CustomTextFormField(
      {required this.hint,
        this.keyboardType = TextInputType.text,
        this.isSecureText = false,
        this.validator,
        this.controller});

  @override
  Widget build(BuildContext context) {
    // not textField
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        controller: controller,
        validator: validator,
        obscureText: isSecureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: hint,
          labelStyle: TextStyle(
            fontSize: 12,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.blue, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2)),
        ),
      ),
    );
  }
}