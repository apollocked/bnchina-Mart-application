import 'package:apollo/utils/colors.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> CustomSnackbar(
    Color color, BuildContext context, String massege) {
  ScaffoldMessenger.of(context).clearSnackBars();
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: color,
      content: Center(
          child: Text(
        massege,
        style: TextStyle(
            fontSize: 15, color: color == primaryColor ? inblack : textColor),
      ))));
}