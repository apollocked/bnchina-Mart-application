import 'package:minimart/pages/Basket_Page/basket_cart.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/utils/data.dart';
import 'package:minimart/widgits/Custom_Widget/custom_snackBar.dart';
import 'package:minimart/widgits/Functions/total_price_finctions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shortid/shortid.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: basketItems.isNotEmpty
              ? ListView.builder(
                  itemCount: basketItems.length,
                  itemBuilder: (context, index) {
                    final item = basketItems[index];

                    final quantity = (item["quantity"] as num?)?.toInt() ?? 1;
                    final price = (item["price"] as num?)?.toDouble() ?? 0.0;

                    item["quantity"] = quantity;
                    item["price"] = price;
                    item["totalPrice"] = quantity * price;

                    return BasketCard(
                      product: item,
                      onMinus: () {
                        setState(() {
                          final currentQuantity =
                              (item["quantity"] as num?)?.toInt() ?? 1;
                          final currentPrice =
                              (item["price"] as num?)?.toDouble() ?? 0.0;

                          if (currentQuantity > 1) {
                            item["quantity"] = currentQuantity - 1;
                            item["totalPrice"] =
                                (currentQuantity - 1) * currentPrice;
                          } else {
                            basketItems.removeAt(index);
                          }
                        });
                      },
                      onPlus: () {
                        setState(() {
                          final currentQuantity =
                              (item["quantity"] as num?)?.toInt() ?? 0;
                          final currentPrice =
                              (item["price"] as num?)?.toDouble() ?? 0.0;

                          item["quantity"] = currentQuantity + 1;
                          item["totalPrice"] =
                              (currentQuantity + 1) * currentPrice;
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
        if (basketItems.isNotEmpty) ...[
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(14),
              border:
                  Border.all(color: primaryColor.withOpacity(0.15), width: 1),
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
                  ((currentUser["discount"] as num?)?.toInt() ?? 0) != 0
                      ? TextSpan(children: [
                          TextSpan(
                            text: (() {
                              try {
                                return discount()?.toStringAsFixed(2);
                              } catch (e) {
                                return addtototal()?.toStringAsFixed(2);
                              }
                            })(),
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
                                "(${(currentUser["discount"] as num?)?.toInt() ?? 0}% off)",
                            style: TextStyle(fontSize: 12, color: accentColor),
                          ),
                        ])
                      : TextSpan(children: [
                          TextSpan(
                            text: addtototal()?.toStringAsFixed(2),
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
                  final basketCopy =
                      List<Map<String, dynamic>>.from(basketItems);

                  double? total = addtototal();
                  double? finalTotal = total;

                  final discountValue =
                      (currentUser["discount"] as num?)?.toDouble() ?? 0.0;
                  if (discountValue > 0) {
                    try {
                      finalTotal = discount();
                    } catch (e) {
                      finalTotal = total;
                    }
                  }

                  orders.add({
                    "OrderID": shortid.generate(),
                    "date": DateFormat.yMd().format(DateTime.now()),
                    "TotalPrice": finalTotal?.toStringAsFixed(2),
                    "Data": basketCopy,
                  });

                  basketItems.clear();
                  currentUser["discount"] = 0;
                  addNotification(
                    title: "Order Placed! 🎉",
                    message:
                        "Your order of ${finalTotal?.toStringAsFixed(2)} IQD was placed successfully.",
                    type: "purchase",
                  );
                  CustomSnackbar(
                      primaryColor, context, "🎉 Order placed successfully!");
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
          const SizedBox(height: 10),
        ] else
          const SizedBox(height: 5),
      ],
    );
  }
}
