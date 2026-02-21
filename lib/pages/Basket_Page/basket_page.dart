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
                    final double finalTotal = CartService().getDiscountedTotal(
                        UserService().currentUser["discount"] ?? 0);

                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) => Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(32)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, -5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 40,
                              height: 4,
                              margin: const EdgeInsets.only(bottom: 24),
                              decoration: BoxDecoration(
                                color: subTextColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.shopping_bag_outlined,
                                color: primaryColor,
                                size: 32,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Confirm Order",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                fontFamily: "Poppins",
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Please review your order total before proceeding.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: subTextColor,
                                fontFamily: "Poppins",
                              ),
                            ),
                            const SizedBox(height: 32),
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: primaryColor.withOpacity(0.1),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Items",
                                        style: TextStyle(color: subTextColor),
                                      ),
                                      Text(
                                        "${CartService().basketItems.length} items",
                                        style: TextStyle(
                                            color: textColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  if ((UserService().currentUser["discount"]
                                              as num? ??
                                          0) !=
                                      0) ...[
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Discount",
                                          style: TextStyle(color: accentColor),
                                        ),
                                        Text(
                                          "-${UserService().currentUser["discount"]}%",
                                          style: TextStyle(
                                              color: accentColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: Divider(height: 1),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total Amount",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                        ),
                                      ),
                                      Text(
                                        "${finalTotal.toStringAsFixed(2)} IQD",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: subTextColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Container(
                                    height: 54,
                                    decoration: BoxDecoration(
                                      gradient: primaryGradient,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: primaryColor.withOpacity(0.3),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          OrderService().placeOrder(
                                            basketItems:
                                                CartService().basketItems,
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
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: const Text(
                                        "Confirm",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    );
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
