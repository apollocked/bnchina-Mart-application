import 'package:MiniMart/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField(
      {super.key,
      required this.onvalidad,
      required this.onsave,
      required this.path,
      required this.name});
  final String? Function(String? value) onvalidad;
  final void Function(String? value) onsave;
  final String path;
  final String name;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          fillColor: whiteColor,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: primaryColor, width: 1)),
          hintText: name,
          hintStyle: TextStyle(color: darkGreyColor),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  BorderSide(color: primaryColor, width: 1, strokeAlign: 8)),
          suffixIcon: Image.asset(
            path,
            color: primaryColor,
          ),
        ),
        onSaved: onsave,
        validator: onvalidad);
  }
}
