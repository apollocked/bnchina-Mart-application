// ignore_for_file: must_be_immutable

import 'package:bnchinamart/utils/colors.dart';

import 'package:bnchinamart/widgits/adding_item.dart';

import 'package:flutter/material.dart';

class VerticalListcard extends StatelessWidget {
   VerticalListcard({super.key,required this.product});
Map<String, dynamic> product ;
  @override
  Widget build(BuildContext context) {
    return   
        Container(width: double.infinity,height: 80,margin: const EdgeInsets.all(4),padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(color: darkGreyColor,borderRadius: BorderRadius.circular(8)),
                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Row(
                          children: [  Center(
                            child: Container(margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(color: backgroundColor,borderRadius: BorderRadius.circular(8)),
                              height: 75,width: 75,
                              child: Image.asset(product["imgPath"]),
                            ),
                          ),const SizedBox(width: 3,),
                          Column(mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                         Text(product["name"],style: 
                           TextStyle(fontSize:15,color: textColor,fontWeight: FontWeight.bold,fontFamily: 'popins'),),
                          Text(product["details"],style: 
                         TextStyle(fontSize:10,fontFamily: 'popins',color: textColor
                         , fontWeight: FontWeight.bold),),   
                              Text.rich(TextSpan(
                            children: [TextSpan(text:product["price"].toString(),style: 
                             TextStyle(fontSize:12,fontWeight: FontWeight.bold,fontFamily: 'popins',color: textColor),

                            ),TextSpan(text: " IQD",style: 
                             TextStyle(fontSize:10,fontFamily: 'popins',color: textColor),

                            )
                          ]) 
                          ,),
                         ],
        
                          ),],
                        )
                          ,SizedBox(height: 30,
                            child: FloatingActionButton(heroTag:"vertical ${product["imgPath"]}",onPressed: (){
                                  addToBasket(context, product);
                            },backgroundColor: primaryColor,
                            shape: const CircleBorder(),
                            child:  Icon(Icons.add,size: 19,color:inblack,),),
                          )
                        ],
                       ),
                       
                       
                       
                       
                        );
     
  }
}