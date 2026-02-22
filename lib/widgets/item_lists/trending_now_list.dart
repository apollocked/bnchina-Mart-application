import 'package:minimart/utils/data.dart';
import 'package:minimart/widgets/custom_cards/product_card.dart';
import 'package:flutter/material.dart';

class TrendingList extends StatefulWidget {
  const TrendingList({super.key});

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  List<Map<String, dynamic>> trendPro = [];

  @override
  void initState() {
    super.initState();

    trendPro = products.where((a) {
      return a["isTrending"] != false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: trendPro.length,
        itemBuilder: (BuildContext context, index) {
          return ProductCard(product: trendPro[index]);
        });
  }
}








