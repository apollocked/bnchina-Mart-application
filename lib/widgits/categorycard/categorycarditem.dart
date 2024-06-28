import 'package:minimart/utils/colors.dart';
import 'package:minimart/widgits/Custom_Widget/products.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryItem extends StatelessWidget {
  CategoryItem({super.key, required this.categories});
  Map<String, dynamic> categories;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductPage(
            category: categories['name'],
          );
        }));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0.1, horizontal: 8),
        decoration: BoxDecoration(
            color: darkGreyColor, borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categories['name'],
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'popins',
                      fontSize: 16,
                      color: textColor),
                ),
                if (categories["discount"] != 0)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: primaryColor),
                    child: Row(
                      children: [
                        Text(
                          categories["discount"].toString(),
                          style: TextStyle(fontSize: 10, color: inblack),
                        ),
                        Text(
                          "% discount",
                          style: TextStyle(fontSize: 12, color: inblack),
                        ),
                      ],
                    ),
                  )
                else
                  (Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ))
              ],
            ),
            const Spacer(
              flex: 3,
            ),
            Image.asset(
              categories["imgPath"],
              fit: BoxFit.contain,
              height: 50,
              width: 65,
            )
          ],
        ),
      ),
    );
  }
}
