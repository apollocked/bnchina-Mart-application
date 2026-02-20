import 'package:minimart/utils/colors.dart';
import 'package:minimart/services/cart_service.dart';
import 'package:minimart/widgits/Custom_Widget/custom_appbar.dart';
import 'package:minimart/widgits/Custom_Widget/custom_snackBar.dart';
import 'package:minimart/widgits/categorycard/category_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductItem extends StatelessWidget {
  ProductItem({super.key, required this.product});
  Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(),
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero product image
                Container(
                  width: double.infinity,
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: surfaceColor,
                    border: Border.all(
                      color: primaryColor.withOpacity(0.15),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        // Subtle gradient overlay bottom
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  backgroundColor.withOpacity(0.3),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            product["imgPath"],
                            height: 180,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Category badge
                CategoryText(category: product["category"]),
                const SizedBox(height: 12),

                // Product name
                Text(
                  product["name"],
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: textColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Details
                Text(
                  product["details"],
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      color: subTextColor,
                      height: 1.5),
                ),
                const SizedBox(height: 16),

                // Price
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      product["price"].toString(),
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                    const SizedBox(width: 4),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        "IQD",
                        style: TextStyle(fontSize: 16, color: subTextColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 90), // space for bottom button
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          color: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Container(
            height: 54,
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
                CartService().addToCart(product);
                CustomSnackbar(
                    primaryColor, context, "Added to your basket 🛒");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              icon: Icon(Icons.shopping_basket_rounded,
                  color: blackColor, size: 20),
              label: Text(
                "Add to Basket",
                style: TextStyle(
                    color: blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ));
  }
}
