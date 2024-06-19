
import 'package:apollo/utils/data.dart';
import 'package:apollo/widgits/Custom_Widget/custom_snackBar.dart';
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
      "isTrending": product["isTrending"],
      "quantity": 1,
      "totalPrice": product["price"]
    });
  }

  CustomSnackbar(context, "Added to Basket");
}
