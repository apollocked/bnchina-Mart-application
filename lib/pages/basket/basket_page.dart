

// ignore_for_file: use_function_type_syntax_for_parameters

import 'package:bnchinamart/pages/basket/basket_cart.dart';
import 'package:bnchinamart/utils/colors.dart';
import 'package:bnchinamart/utils/data.dart';
import 'package:flutter/material.dart';

class BasketPage extends StatefulWidget {
    const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
 


  double? addtototal(){
   double x=0;
   for (var i = 0; i < basketItems.length; i++) {
     x+=basketItems[i]["totalPrice"];
   }

return x;
}


  @override
  Widget build(BuildContext context) {


    return Column(crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: ListView.builder(itemCount: basketItems.length,
          itemBuilder: (context,index ){
           
            return BasketCard(product:  basketItems[index],
            onMinus:  () {setState(() {
              
            
              
              if (basketItems[index]["quantity"]!=0) {
                               
                              
                               basketItems[index]["quantity"]=basketItems[index]["quantity"]-1;
                                basketItems[index]["totalPrice"]=basketItems[index]["quantity"] * basketItems[index]["price"];
                         
                                
                                } });} ,
                                 onplus:  () { 

                                  setState(() {
                                     basketItems[index]["quantity"]=basketItems[index]["quantity"]+1;
                                basketItems[index]["totalPrice"]=basketItems[index]["quantity"] * basketItems[index]["price"];
                           
                                  });
                                 }, 
            
            
            );
      
        }),
         
      ),
       const Divider(),
  
     
      Text("Total",style: TextStyle(fontSize:16,fontWeight: FontWeight.bold,fontFamily: 'popins',color: textColor)),
         Text.rich(TextSpan(
                 
                          children: [TextSpan(text:
                          addtototal().toString(),style: 
                           TextStyle(fontSize:20,fontWeight: FontWeight.bold,fontFamily: 'popins',color: textColor),
      
                          ),TextSpan(text: " IQD",style: 
                           TextStyle(fontSize:15,fontFamily: 'popins',color: textColor),
      
                          )
                        ]) 
                        ,),

    ],)
    ;
  }
}