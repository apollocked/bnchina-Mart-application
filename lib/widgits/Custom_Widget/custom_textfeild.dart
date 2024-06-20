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
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            hintText: name,
            hintStyle: TextStyle(color: darkGreyColor),
            suffixIcon: Image.asset(path)),
        onSaved: onsave,
        validator: onvalidad);
  }
}
