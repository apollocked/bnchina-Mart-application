import 'package:minimart/pages/Basket_Page/basket_cart.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/services/cart_service.dart';
import 'package:minimart/services/order_service.dart';
import 'package:minimart/services/user_service.dart';
import 'package:minimart/services/notification_service.dart';
import 'package:minimart/widgits/Custom_Widget/custom_snackBar.dart';
import 'package:flutter/material.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: CartService(),
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CartService().basketItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: CartService().basketItems.length,
                      itemBuilder: (context, index) {
                        final item = CartService().basketItems[index];

                        return BasketCard(
                          product: item,
                          onMinus: () {
                            setState(() {
                              CartService().decreaseQuantity(index);
                            });
                          },
                          onPlus: () {
                            setState(() {
                              CartService().increaseQuantity(index);
                            });
                          },
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: surfaceColor,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              "assets/images/empty.png",
                              height: 80,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Your basket is empty",
                            style: TextStyle(
                              fontSize: 18,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Add items to get started",
                            style: TextStyle(
                              fontSize: 13,
                              color: subTextColor,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                    ),
            ),

            // Total summary area
            if (CartService().basketItems.isNotEmpty) ...[
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: primaryColor.withOpacity(0.15), width: 1),
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
                                style: TextStyle(
                                    fontSize: 13, color: subTextColor),
                              ),
                              TextSpan(
                                text:
                                    "(${UserService().currentUser["discount"]}% off)",
                                style:
                                    TextStyle(fontSize: 12, color: accentColor),
                              ),
                            ])
                          : TextSpan(children: [
                              TextSpan(
                                text:
                                    CartService().getTotal().toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              TextSpan(
                                text: " IQD",
                                style: TextStyle(
                                    fontSize: 13, color: subTextColor),
                              ),
                            ]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Checkout button
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
                  onPressed: () {
                    setState(() {
                      double finalTotal = CartService().getDiscountedTotal(
                          UserService().currentUser["discount"] ?? 0);

                      OrderService().placeOrder(
                        basketItems: CartService().basketItems,
                        finalTotal: finalTotal,
                      );

                      CartService().clearCart();
                      UserService().clearDiscount();

                      NotificationService().addNotification(
                        title: "Order Placed! 🎉",
                        message:
                            "Your order of ${finalTotal.toStringAsFixed(2)} IQD was placed successfully.",
                        type: "purchase",
                      );

                      CustomSnackbar(primaryColor, context,
                          "🎉 Order placed successfully!");
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  icon: Icon(Icons.check_circle_rounded,
                      color: Colors.black, size: 20),
                  label: Text(
                    "Checkout",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ] else
              const SizedBox(height: 5),
          ],
        );
      },
    );
  }
}
