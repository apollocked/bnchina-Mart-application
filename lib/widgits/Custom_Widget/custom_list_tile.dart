
import 'package:MiniMart/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  const CustomTile(
      {super.key,
      required this.testname,
      required this.icon,
      required this.ontap});

  final Widget icon;
  final VoidCallback ontap;
  final String testname;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: darkGreyColor,
        borderRadius: BorderRadius.circular(7),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: icon,
        focusColor: inblack,
        title: Text(
          testname,
          style: TextStyle(color: textColor),
        ),
        onTap: () {
          ontap();
        },
      ),
    );
  }
}
