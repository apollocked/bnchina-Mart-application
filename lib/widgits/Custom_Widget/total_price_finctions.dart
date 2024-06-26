import 'package:MiniMart/utils/data.dart';

double? discount() {
  double discountPrice = 0;
  if (currentUser["discount"] != 0) {
    discountPrice = (addtototal()! * ((100 - currentUser["discount"]) / 100));
  }
  return discountPrice;
}

double? addtototal() {
  double Totalprice = 0;

  if (basketItems.isEmpty) {
    return Totalprice;
  }

  for (var i = 0; i < basketItems.length; i++) {
    Totalprice += basketItems[i]["totalPrice"];
  }

  return Totalprice;
}
