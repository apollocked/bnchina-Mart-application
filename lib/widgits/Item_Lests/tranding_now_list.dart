

import 'package:bnchinamart/utils/data.dart';
import 'package:bnchinamart/widgits/Item_Lests/trending_product_cart.dart';
import 'package:flutter/material.dart';

class TreandigList extends StatefulWidget {
  const TreandigList({super.key});

  @override
  State<TreandigList> createState() => _TreandigListState();
}

class _TreandigListState extends State<TreandigList> {
      List<Map<String, dynamic>>trendPro=[];

  @override
  void initState() {

    super.initState();
 
  trendPro= products.where((a) {
    return a["isTrending"] != false;
}).toList();
  
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
                    scrollDirection: Axis.horizontal,itemCount: trendPro.length,
                     itemBuilder:(BuildContext context,  index) { 
                   return ProductCard( product:trendPro[index]);}
            );
  }
}