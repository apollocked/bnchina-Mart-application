import 'package:bnchinamart/utils/assets.dart';
import 'package:bnchinamart/utils/colors.dart';
import 'package:bnchinamart/utils/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Accountpage extends StatelessWidget {
  const Accountpage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(height:20,),
 Center(
   child: Column(
   children: [
     CircleAvatar(
      radius: 50,
       backgroundImage: AssetImage(avatarBoy),
     ),SizedBox(height: 10,),
     Text(currentUser["username"]?? "me",style: TextStyle(color: textColor,fontSize: 20,fontFamily: "poppins"),)
   ],
      ),
 ),
 ListTile(
  leading:Icon(Icons.airplane_ticket_rounded,color: primaryColor,) ,title: Text("Orders",style: TextStyle(color: textColor),) ,
 ), ListTile(
  leading:Icon(Icons.password_sharp,color: primaryColor,) ,title: Text(style: TextStyle(color: textColor),"Change password") ,
 ), ListTile(
  leading:Icon(Icons.notifications,color: primaryColor,) ,title: Text(style: TextStyle(color: textColor),"Notfications") ,
 ), ListTile(
  leading:Icon(Icons.local_offer,color: primaryColor,) ,title: Text(style: TextStyle(color: textColor),"Discount") ,
 ), ListTile(onTap: () {
   
 },
  leading:Icon(Icons.exit_to_app,color: primaryColor,) ,title: Text(style: TextStyle(color: textColor),"Signout") ,
 ),




      ],
    );
  }
}