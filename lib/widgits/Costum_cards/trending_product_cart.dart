import 'package:minimart/utils/colors.dart';
import 'package:minimart/widgits/Functions/adding_item.dart';
import 'package:minimart/pages/Product_page/product_item_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  ProductCard({super.key, required this.product});
  Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductItem(product: product);
        }));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: darkGreyColor),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      product["imgPath"],
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: FloatingActionButton.small(
                        heroTag: "${product['imgPath']}",
                        onPressed: () {
                          addToBasket(context, product);
                        },
                        backgroundColor: primaryColor,
                        shape: const CircleBorder(),
                        child: Icon(
                          Icons.add,
                          color: inblack,
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              product["name"],
              style: TextStyle(
                  color: textColor, fontSize: 18, fontWeight: FontWeight.w900),
            ),
            Text.rich(TextSpan(
              children: [
                TextSpan(
                  text: "${product["price"]}",
                  style: TextStyle(
                      color: textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w900),
                ),
                TextSpan(children: [
                  TextSpan(
                    text: " IQD",
                    style: TextStyle(
                        color: darkGreyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w900),
                  ),
                ]),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
