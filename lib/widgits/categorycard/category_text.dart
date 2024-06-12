

import 'package:bnchinamart/utils/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryText extends StatelessWidget {


   CategoryText({super.key, required this.category});
  // ignore: prefer_typing_uninitialized_variables
  var category;
  @override
  Widget build(BuildContext context) {
    return   Container(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(12) ,border: Border.all(color: primaryColor, ),
                ),
                child: Text(category,style: TextStyle(color: primaryColor),),);
  }
}