// ignore: non_constant_identifier_names
import 'package:minimart/utils/colors.dart';
import 'package:minimart/utils/data.dart';
import 'package:minimart/widgits/Custom_Widget/custom_snackBar.dart';

void AddingDiscount(String value, context) async {
  for (var element in coubons) {
    if (value == element["code"]) {
      currentUser["discount"] = element["discount"];

      addNotification(
        title: "Coupon Activated! 🏷️",
        message:
            "Coupon \"$value\" applied — you get ${element["discount"]}% off your next order!",
        type: "coupon",
      );

      CustomSnackbar(primaryColor, context,
          "🏷️ ${currentUser["discount"]}% discount applied!");
      break;
    } else {
      CustomSnackbar(
          errorColor, context, "Wrong coupon. Please check and try again.");
    }
  }
}
