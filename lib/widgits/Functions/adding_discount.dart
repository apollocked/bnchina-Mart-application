// ignore: non_constant_identifier_names
import 'package:minimart/utils/colors.dart';
import 'package:minimart/utils/data.dart';
import 'package:minimart/widgits/Custom_Widget/custom_snackBar.dart';

void AddingDiscount(String value, context) async {
  for (var element in coubons) {
    if (value == element["code"]) {
      currentUser["discount"] = element["discount"];

      CustomSnackbar(primaryColor, context,
          "Enjoy your % ${currentUser["discount"]} Discount");
      break;
    } else {
      CustomSnackbar(
          errorColor, context, "Wrong coupon, Please enter coupon correctly ");
    }
  }
}
