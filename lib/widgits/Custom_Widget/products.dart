
import 'package:MiniMart/utils/colors.dart';
import 'package:MiniMart/widgits/Custom_Widget/custom_appbar.dart';
import 'package:MiniMart/widgits/Item_Lests/category_page.dart';
import 'package:MiniMart/widgits/categorycard/category_text.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key, required this.category});
  final String category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: customAppBar(),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: CategoryText(category: category)),
              const SizedBox(
                height: 10,
              ),
              ProductList(
                category: category,
              ),
            ],
          )),
    );
  }
}
