// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, avoid_print
import 'package:minimart/pages/Layout_page/layout_page.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/widgits/Functions/adding_discount.dart';
import 'package:flutter/material.dart';
import 'package:minimart/utils/assets.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  TextEditingController control = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(children: [
          Image.asset(coupon),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Enter Coupon Code",
            style: TextStyle(color: textColor, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              TextFormField(
                controller: control,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    hintText: "Coupon Code",
                    hintStyle: TextStyle(color: darkGreyColor)),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      AddingDiscount(control.text, context);
                      Navigator.pop(context,
                          MaterialPageRoute(builder: (context) {
                        return const LayoutPage();
                      }));
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minimumSize: const Size(double.infinity, 50)),
                  child: Text(
                    "Check Coupon Code",
                    style: TextStyle(color: textColor),
                  ))
            ],
          )
        ]),
      ),
    );
  }
}
