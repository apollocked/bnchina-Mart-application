// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, avoid_print
import 'package:minimart/pages/Layout_page/layout_page.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/services/user_service.dart';
import 'package:minimart/services/notification_service.dart';
import 'package:minimart/utils/data.dart';
import 'package:minimart/widgits/Custom_Widget/custom_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:minimart/utils/assets.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  TextEditingController control = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: subTextColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Coupon image
                Center(child: Image.asset(coupon, height: 100)),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    "Enter Coupon Code",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    "Apply a coupon to get discounts on your order",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: subTextColor, fontSize: 12, height: 1.5),
                  ),
                ),
                const SizedBox(height: 20),
                // Text field
                TextFormField(
                  controller: control,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundColor,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: primaryColor.withOpacity(0.3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: primaryColor.withOpacity(0.25), width: 1.2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor, width: 1.8),
                    ),
                    hintText: "e.g. 2314",
                    hintStyle: TextStyle(color: subTextColor),
                    prefixIcon: Icon(Icons.discount_outlined,
                        color: primaryColor, size: 20),
                  ),
                ),
                const SizedBox(height: 20),
                // Button
                Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: primaryGradient,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        bool found = false;
                        for (var element in coubons) {
                          if (control.text == element["code"]) {
                            UserService().applyDiscount(element["discount"]);

                            NotificationService().addNotification(
                              title: "Coupon Activated! 🏷️",
                              message:
                                  "Coupon \"${control.text}\" applied — you get ${element["discount"]}% off your next order!",
                              type: "coupon",
                            );

                            CustomSnackbar(primaryColor, context,
                                "🏷️ ${element["discount"]}% discount applied!");
                            found = true;
                            break;
                          }
                        }

                        if (!found) {
                          CustomSnackbar(errorColor, context,
                              "Wrong coupon. Please check and try again.");
                        }

                        if (found) {
                          Navigator.pop(context,
                              MaterialPageRoute(builder: (context) {
                            return const LayoutPage();
                          }));
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    icon: Icon(Icons.check_circle_outline_rounded,
                        color: Colors.black, size: 20),
                    label: Text(
                      "Apply Coupon",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
