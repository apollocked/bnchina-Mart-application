import 'package:minimart/utils/data.dart';
import 'package:minimart/widgets/category_card/category_card_item.dart';
import 'package:flutter/material.dart';

class CategoryCardGrid extends StatefulWidget {
  const CategoryCardGrid({super.key});

  @override
  State<CategoryCardGrid> createState() => _CategoryCardGridState();
}

class _CategoryCardGridState extends State<CategoryCardGrid> {
  List<Map<String, dynamic>> topcate = [];

  @override
  void initState() {
    super.initState();

    topcate = categories.where((a) {
      return a["isTop"] != false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 16 / 9,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 80,
        ),
        itemCount: topcate.length,
        itemBuilder: (context, index) {
          return CategoryCardItem(categories: topcate[index]);
        });
  }
}








