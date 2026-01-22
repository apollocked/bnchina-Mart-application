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
                    // Get item with null safety
                    final item = basketItems[index];

                    // Ensure numeric fields have default values
                    final quantity = (item["quantity"] as num?)?.toInt() ?? 1;
                    final price = (item["price"] as num?)?.toDouble() ?? 0.0;

                    // Update item with safe values
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
                            // Remove item if quantity is 1
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
                      Image.asset(
                        "assets/images/empty.png",
                        height: 120,
                        color: primaryColor,
                      ),
                      const SizedBox(height: 18),
                      Text(
                        "Please add some items",
                        style: TextStyle(
                          fontSize: 18,
                          color: primaryColor,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        const Divider(),
        if (basketItems.isNotEmpty)
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Create a copy of basket items
                final basketCopy = List<Map<String, dynamic>>.from(basketItems);

                // Calculate total safely
                double? total = addtototal();
                double? finalTotal = total;

                // Apply discount if available
                final discountValue =
                    (currentUser["discount"] as num?)?.toDouble() ?? 0.0;
                if (discountValue > 0) {
                  try {
                    finalTotal = discount();
                  } catch (e) {
                    // If discount calculation fails, use regular total
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
                CustomSnackbar(
                    primaryColor, context, "Thanks for your purchase");
              });
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: primaryColor,
            ),
            child: Text(
              "Check out",
              style: TextStyle(
                color: inblack,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        else
          const SizedBox(height: 5),
        const SizedBox(height: 16),
        Text(
          "Total",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'popins',
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text.rich(
          // Safely check discount value
          ((currentUser["discount"] as num?)?.toInt() ?? 0) != 0
              ? TextSpan(
                  children: [
                    TextSpan(
                      // Safely get discounted price
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
                        fontFamily: 'popins',
                        color: textColor,
                      ),
                    ),
                    TextSpan(
                      text: " IQD",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'popins',
                        color: primaryColor,
                      ),
                    ),
                    TextSpan(
                      text:
                          " after % ${(currentUser["discount"] as num?)?.toInt() ?? 0} discount",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'popins',
                        color: textColor,
                      ),
                    ),
                  ],
                )
              : TextSpan(
                  children: [
                    TextSpan(
                      text: addtototal()?.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'popins',
                        color: textColor,
                      ),
                    ),
                    TextSpan(
                      text: " IQD",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'popins',
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
