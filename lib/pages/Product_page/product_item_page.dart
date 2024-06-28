import 'package:minimart/utils/colors.dart';
import 'package:minimart/widgits/Functions/adding_item.dart';
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
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: darkGreyColor),
                  child: Image.asset(
                    product["imgPath"],
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CategoryText(category: product["category"]),
              const SizedBox(
                height: 15,
              ),
              Text(
                product["name"],
                style: TextStyle(
                    fontFamily: 'popins', color: textColor, fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                product["details"],
                style: TextStyle(
                    fontSize: 18, fontFamily: 'popins', color: textColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: product["price"].toString(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'popins',
                        color: textColor),
                  ),
                  TextSpan(
                    text: " IQD",
                    style: TextStyle(
                        fontSize: 15, fontFamily: 'popins', color: textColor),
                  )
                ]),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          color: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
            child: ElevatedButton(
              onPressed: () {
                addToBasket(context, product);
                CustomSnackbar(primaryColor, context, "added to your basket");
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: primaryColor,
              ),
              child: Text(
                "Add to basket",
                style: TextStyle(
                    color: inblack, fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ));
  }
}
