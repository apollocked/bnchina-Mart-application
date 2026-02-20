import 'package:minimart/utils/colors.dart';
import 'package:minimart/widgits/Functions/adding_item.dart';
import 'package:flutter/material.dart';

class VerticalListcard extends StatelessWidget {
  const VerticalListcard({super.key, required this.product});
  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 82,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: primaryColor.withOpacity(0.12),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product image
          Container(
            margin: const EdgeInsets.all(8),
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(product["imgPath"], fit: BoxFit.contain),
          ),
          const SizedBox(width: 4),
          // Product info
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product["name"],
                  style: TextStyle(
                      fontSize: 14,
                      color: textColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  product["details"],
                  style: TextStyle(
                      fontSize: 11,
                      color: subTextColor,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 3),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: product["price"].toString(),
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                    TextSpan(
                      text: " IQD",
                      style: TextStyle(fontSize: 11, color: subTextColor),
                    )
                  ]),
                ),
              ],
            ),
          ),
          // Add button
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                addToBasket(context, product);
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: primaryGradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(Icons.add, color: blackColor, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
