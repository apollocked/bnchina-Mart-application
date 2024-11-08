import 'package:minimart/utils/colors.dart';
import 'package:minimart/utils/data.dart';
import 'package:minimart/widgits/Custom_Widget/custom_appbar.dart';
import 'package:minimart/widgits/categorycard/categorycarditem.dart';

import 'package:flutter/material.dart';

class CatregoriesPage extends StatelessWidget {
  const CatregoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                "All Categories",
                style: TextStyle(
                    color: textColor, fontSize: 25, fontFamily: "poppins"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 16 / 9,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 80,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryItem(categories: categories[index]);
                }),
          ],
        ),
      ),
    );
  }
}
