import 'package:minimart/utils/colors.dart';
import 'package:minimart/widgets/custom_widgets/custom_appbar.dart';
import 'package:minimart/pages/categories/category_page.dart';
import 'package:minimart/widgets/category_card/category_text.dart';
import 'package:flutter/material.dart';

class CategoryProductsPage extends StatelessWidget {
  const CategoryProductsPage({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: customAppBar(),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: CategoryText(category: category)),
              const SizedBox(
                height: 15,
              ),
              CategoryProductGrid(
                category: category,
              ),
            ],
          )),
    );
  }
}





