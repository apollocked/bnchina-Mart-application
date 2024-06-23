import 'package:MiniMart/utils/colors.dart';
import 'package:MiniMart/utils/data.dart';
import 'package:MiniMart/widgits/categorycard/trending_product_cart.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable

class ProductList extends StatefulWidget {
  const ProductList({super.key, required this.category});
  final String category;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
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
