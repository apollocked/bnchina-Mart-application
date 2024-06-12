import 'package:bnchinamart/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar customAppBar(){
 return  AppBar(backgroundColor: backgroundColor,surfaceTintColor: backgroundColor,
      title: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your Location",style: TextStyle( fontFamily: "popins", fontSize: 18,
                    fontWeight: FontWeight.bold,color: textColor),),
                    Row(
                      children: [
                        Text("Erbil ",style: TextStyle( fontFamily: "popins", fontSize: 15,
                        fontWeight: FontWeight.w400,color: textColor)),const SizedBox(width: 3,),
                       FaIcon(FontAwesomeIcons.locationDot,color: primaryColor,size: 15,)
                      ],
                    ),
                  ], ),
    );
}

