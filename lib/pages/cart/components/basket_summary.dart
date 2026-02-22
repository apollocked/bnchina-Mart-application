import 'package:flutter/material.dart';
import 'package:minimart/services/cart_service.dart';
import 'package:minimart/services/user_service.dart';
import 'package:minimart/utils/colors.dart';

class BasketSummary extends StatelessWidget {
  final VoidCallback onCheckout;

  const BasketSummary({super.key, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: primaryColor.withOpacity(0.15), width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: subTextColor,
                ),
              ),
              Text.rich(
                (UserService().currentUser["discount"] as num? ?? 0) != 0
                    ? TextSpan(children: [
                        TextSpan(
                          text: CartService()
                              .getDiscountedTotal(
                                  UserService().currentUser["discount"])
                              .toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: " IQD ",
                          style: TextStyle(fontSize: 13, color: subTextColor),
                        ),
                        TextSpan(
                          text:
                              "(${UserService().currentUser["discount"]}% off)",
                          style: TextStyle(fontSize: 12, color: accentColor),
                        ),
                      ])
                    : TextSpan(children: [
                        TextSpan(
                          text: CartService().getTotal().toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: " IQD",
                          style: TextStyle(fontSize: 13, color: subTextColor),
                        ),
                      ]),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 54,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: primaryGradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.4),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ElevatedButton.icon(
            onPressed: onCheckout,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
            icon:
                Icon(Icons.check_circle_rounded, color: Colors.black, size: 20),
            label: Text(
              "Checkout",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
