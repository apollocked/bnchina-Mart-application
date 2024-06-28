import 'package:MiniMart/utils/colors.dart';
import 'package:MiniMart/utils/data.dart';
import 'package:MiniMart/widgits/Custom_Widget/custom_snackBar.dart';
import 'package:flutter/material.dart';

void addToBasket(BuildContext context, Map<String, dynamic> product) {
  bool isContain = false;

  for (var basketProduct in basketItems) {
    if (basketProduct["name"] == product["name"]) {
      isContain = true;

      basketProduct["quantity"] += 1;
      basketProduct["totalPrice"] =
          basketProduct["price"] * basketProduct["quantity"];
      break;
    }
  }

  if (!isContain) {
    basketItems.add({
      "name": product["name"],
      "imgPath": product["imgPath"],
      "details": product["details"],
      "price": product["price"],
      "category": product["category"],
      "quantity": product["quantity"],
      "isTrending": product["isTrending"],
      "totalPrice": product["totalPrice"]
    });
  }

  CustomSnackbar(primaryColor, context, "Added to Basket");
}
