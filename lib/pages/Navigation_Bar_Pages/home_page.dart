

import 'package:bnchinamart/widgits/Item_Lests/product_item_page.dart';
import 'package:bnchinamart/pages/categories_page.dart';
import 'package:bnchinamart/utils/assets.dart';
import 'package:bnchinamart/utils/colors.dart';
import 'package:bnchinamart/utils/data.dart';



import 'package:bnchinamart/widgits/categorycard/categorycardlist.dart';
import 'package:bnchinamart/widgits/Item_Lests/product_vertical_list.dart';
import 'package:bnchinamart/widgits/Item_Lests/tranding_now_list.dart';
import 'package:flutter/material.dart';



class HomePage extends StatelessWidget {
   const HomePage({super.key});

  @override
  
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:
      
       Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
        
          ClipRRect(borderRadius: BorderRadius.circular(8), 
          child: Image.asset(poster,width: double.infinity,fit: BoxFit.fill,filterQuality: FilterQuality.high,)),
           const SizedBox(height: 10,),
         const CategoryCard(),
         Align(alignment: Alignment.bottomRight,
           child: TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){return const CatregoriesPage();}));
           }, style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 2,vertical: 0))),
           child: 
           Text("See all catigories",style: 
             TextStyle(fontSize: 10,fontFamily: 'popins',color: primaryColor),)),
         )
         ,const SizedBox(
            height: 3,
           ),
            Text("Treading Now",style: 
           TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'popins',color: textColor),),const SizedBox(height:10,)
           ,const SizedBox(height: 210,
             child: TreandigList()
    ),const SizedBox(
            height: 3,
           ),
         Text("All Products",style: 
            TextStyle(fontFamily: 'popins',fontWeight: FontWeight.bold, fontSize: 17,color: textColor),)
           , const SizedBox(
            height: 3,
           ),
           Column(
            children: [
               for(int i=0;i<products.length;i++)
              GestureDetector(onTap: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context)
                {return ProductItem(product: products[i]);}));
              }, child: VerticalListcard(product: products[i],))
        ,const SizedBox(
            height: 3,
           )
            ]
           )
        ]
            ),
    );
     
  }
}