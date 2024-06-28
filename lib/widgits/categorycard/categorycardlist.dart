import 'package:minimart/utils/data.dart';
import 'package:minimart/widgits/categorycard/categorycarditem.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({super.key});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
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
          return CategoryItem(categories: topcate[index]);
        });
  }
}
