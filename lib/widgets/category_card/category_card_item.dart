import 'package:minimart/utils/colors.dart';
import 'package:minimart/pages/categories/category_products_page.dart';
import 'package:flutter/material.dart';

class CategoryCardItem extends StatelessWidget {
  const CategoryCardItem({super.key, required this.categories});
  final Map<String, dynamic> categories;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CategoryProductsPage(
            category: categories['name'],
          );
        }));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: primaryColor.withOpacity(0.15),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categories['name'],
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: textColor),
                ),
                const SizedBox(height: 4),
                if (categories["discount"] != 0)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: primaryGradient),
                    child: Text(
                      "${categories["discount"]}% off",
                      style: TextStyle(
                          fontSize: 10,
                          color: blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )
              ],
            ),
            const Spacer(),
            Image.asset(
              categories["imgPath"],
              fit: BoxFit.contain,
              height: 52,
              width: 60,
            )
          ],
        ),
      ),
    );
  }
}
