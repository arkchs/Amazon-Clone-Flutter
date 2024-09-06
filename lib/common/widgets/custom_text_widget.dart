import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomTextField(
      {super.key, required this.controller, required this.hintText});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: GlobalVariables.secondaryColor,
        )),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
    );
  }
}
