
import 'package:bnchinamart/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox( height: 300,width: double.infinity,
                  child: Container(color: primaryColor,width: 40,
               child: Center(
                child :Image.asset("assets/images/france.png",width: 150,)
               ),
                  ),
                );
  }
}