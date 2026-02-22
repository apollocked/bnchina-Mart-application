import 'package:minimart/utils/colors.dart';
import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
  const CategoryText({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            primaryColor.withOpacity(0.2),
            accentColor.withOpacity(0.1),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        border: Border.all(
          color: primaryColor.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Text(
        category,
        style: TextStyle(
            color: primaryColor, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
