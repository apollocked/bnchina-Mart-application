import 'package:minimart/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  const CustomTile(
      {super.key, required this.text, required this.icon, required this.ontap});

  final Widget icon;
  final VoidCallback ontap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: primaryColor.withOpacity(0.10),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      child: ListTile(
        leading: SizedBox(
          width: 24,
          height: 24,
          child: icon,
        ),
        trailing:
            Icon(Icons.chevron_right_rounded, color: subTextColor, size: 20),
        title: Text(
          text,
          style: TextStyle(
              color: textColor, fontWeight: FontWeight.w500, fontSize: 14),
        ),
        onTap: () {
          ontap();
        },
      ),
    );
  }
}
