import 'package:minimart/utils/colors.dart';
import 'package:minimart/utils/data.dart';
import 'package:minimart/widgets/custom_cards/product_card.dart';
import 'package:flutter/material.dart';



class CategoryProductGrid extends StatefulWidget {
  const CategoryProductGrid({super.key, required this.category});
  final String category;

  @override
  State<CategoryProductGrid> createState() => _CategoryProductGridState();
}

class _CategoryProductGridState extends State<CategoryProductGrid> {
  List<Map<String, dynamic>> fliteredProduct = [];
  @override
  void initState() {
    super.initState();

    fliteredProduct = products.where((product) {
      return product["category"] == widget.category;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (fliteredProduct.isEmpty) {
      return Center(
        child: Text(
          "There are not any product for the selected category",
          style: TextStyle(color: primaryColor),
        ),
      );
    }
    return GridView.builder(
      itemCount: fliteredProduct.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 5),
      itemBuilder: (context, index) {
        return ProductCard(
          product: fliteredProduct[index],
        );
      },
    );
  }
}





