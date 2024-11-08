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
                      return BasketCard(
                        product: basketItems[index],
                        onMinus: () {
                          setState(() {
                            if (basketItems[index]["quantity"] != 0) {
                              basketItems[index]["quantity"] =
                                  basketItems[index]["quantity"] - 1;
                              basketItems[index]["totalPrice"] =
                                  basketItems[index]["quantity"] *
                                      basketItems[index]["price"];
                              if (addtototal() == 0) {
                                basketItems = [];
                                return;
                              }
                            }
                            setState(() {
                              if (basketItems[index]["quantity"] == 0) {
                                basketItems.removeAt(index);
                              }
                            });
                          });
                        },
                        onplus: () {
                          setState(() {
                            basketItems[index]["quantity"] =
                                basketItems[index]["quantity"] + 1;
                            basketItems[index]["totalPrice"] =
                                basketItems[index]["quantity"] *
                                    basketItems[index]["price"];
                          });
                        },
                      );
                    })
                : Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/empty.png",
                        height: 120,
                        color: primaryColor,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Text(
                        " Please Add some items",
                        style: TextStyle(
                            fontSize: 18,
                            color: primaryColor,
                            fontFamily: "Poppins"),
                      )
                    ],
                  ))),
        const Divider(),
        basketItems.isNotEmpty
            ? ElevatedButton(
                onPressed: () {
                  setState(() {
                    orders.add({
                      "OrderID": shortid.generate(),
                      "date": DateFormat.yMd().format(DateTime.now()),
                      "TotalPrice": currentUser["discount"] != 0
                          ? discount().toString()
                          : addtototal().toString(),
                      "Data": basketItems,
                    });

                    basketItems = [];
                    currentUser["discount"] = 0;
                    CustomSnackbar(
                        primaryColor, context, "Thaks for your purches");
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: primaryColor,
                ),
                child: Text(
                  "check out",
                  style: TextStyle(
                      color: inblack,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              )
            : SizedBox(
                height: 5,
              ),
        Text("Total",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'popins',
                color: primaryColor)),
        Text.rich(
          currentUser["discount"] != 0
              ? TextSpan(children: [
                  TextSpan(
                    text: discount().toString(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'popins',
                        color: textColor),
                  ),
                  TextSpan(
                    text: " IQD",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'popins',
                        color: primaryColor),
                  ),
                  TextSpan(
                    text: " after % ${currentUser["discount"]} discount",
                    style: TextStyle(
                        fontSize: 15, fontFamily: 'popins', color: textColor),
                  )
                ])
              : TextSpan(children: [
                  TextSpan(
                    text: addtototal().toString(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'popins',
                        color: textColor),
                  ),
                  TextSpan(
                    text: " IQD",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'popins',
                        color: primaryColor),
                  )
                ]),
        ),
      ],
    );
  }
}
