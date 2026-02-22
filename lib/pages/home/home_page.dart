import 'package:minimart/pages/categories/categories_page.dart';
import 'package:minimart/utils/assets.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/utils/data.dart';
import 'package:minimart/pages/product/product_item_page.dart';
import 'package:minimart/widgets/item_lists/product_vertical_list.dart';
import 'package:minimart/widgets/item_lists/trending_now_list.dart';
import 'package:minimart/widgets/category_card/category_card_grid.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _sectionHeader(String title, {VoidCallback? onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
            ),
          ],
        ),
        if (onSeeAll != null)
          TextButton(
              onPressed: onSeeAll,
              style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 2, vertical: 0))),
              child: Text(
                "See all",
                style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600),
              )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Poster banner
        ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              poster,
              width: double.infinity,
              fit: BoxFit.fill,
              filterQuality: FilterQuality.high,
            )),
        const SizedBox(height: 20),

        // Categories header
        _sectionHeader("Categories", onSeeAll: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const CategoriesPage();
          }));
        }),
        const SizedBox(height: 12),
        const CategoryCardGrid(),
        const SizedBox(height: 20),

        // Trending now
        _sectionHeader("Trending Now"),
        const SizedBox(height: 12),
        const SizedBox(height: 210, child: TrendingList()),
        const SizedBox(height: 20),

        // All products
        _sectionHeader("All Products"),
        const SizedBox(height: 12),
        Column(children: [
          for (int i = 0; i < products.length; i++)
            GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProductItem(product: products[i]);
                  }));
                },
                child: VerticalListcard(
                  product: products[i],
                )),
          const SizedBox(height: 10)
        ])
      ]),
    );
  }
}








