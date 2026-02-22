import 'package:minimart/pages/cart/components/basket_summary.dart';
import 'package:minimart/pages/cart/components/order_confirmation_sheet.dart';
import 'package:minimart/widgets/custom_cards/basket_card.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/services/cart_service.dart';
import 'package:minimart/services/order_service.dart';
import 'package:minimart/services/user_service.dart';
import 'package:minimart/services/notification_service.dart';
import 'package:minimart/widgets/custom_widgets/custom_snackBar.dart';
import 'package:flutter/material.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  void _handleCheckout() {
    final double finalTotal = CartService()
        .getDiscountedTotal(UserService().currentUser["discount"] ?? 0);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => OrderConfirmationSheet(
        basketItems: CartService().basketItems,
        finalTotal: finalTotal,
      ),
    ).then((confirmed) {
      if (confirmed == true && mounted) {
        setState(() {
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

          CustomSnackbar(
              primaryColor, context, "🎉 Order placed successfully!");
        });
      }
    });
  }

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
            if (CartService().basketItems.isNotEmpty)
              BasketSummary(onCheckout: _handleCheckout)
            else
              const SizedBox(height: 5),
          ],
        );
      },
    );
  }
}
