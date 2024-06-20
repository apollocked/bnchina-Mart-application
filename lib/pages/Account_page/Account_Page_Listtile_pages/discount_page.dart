import 'package:MiniMart/utils/colors.dart';
import 'package:flutter/material.dart';

class DiscountPage extends StatelessWidget {
  const DiscountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor),
      child: const Padding(
        padding: EdgeInsets.all(6.0),
        child: Column(children: [Text("data"), TextField()]),
      ),
    );
  }
}
