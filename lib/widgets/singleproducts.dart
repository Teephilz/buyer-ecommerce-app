import 'package:flutter/material.dart';
import 'package:taiwo_ecommerce_app/screens/detailscreen.dart';
import 'package:provider/provider.dart';

import '../provider/product_provider.dart';
class SingleProducts extends StatelessWidget {
 final String name;
 final String image;
 final num price;
 final String descript;

 SingleProducts({ required this.name,   required this.image, required this.price, required this.descript});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: (){
      Navigator.push(context, MaterialPageRoute(builder:
          (context) =>DetailScreen(image: image,
              name: name,
              price: price.toDouble(),
              descript: descript)));
     },
      child: Card(child:
      Container(
       height: 200,
       width: 200,
       child: Column(
        children:<Widget>[
         Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(image: NetworkImage(image) )
          ),
         ),
          Column(
           children: [
            Text(name, style: TextStyle(color: Colors.black, fontSize: 17)),
            SizedBox(width: 50,),
            Text("\$ ${price.toString()}", style: TextStyle(color: Colors.orange, fontSize: 17, fontWeight: FontWeight.bold),),

           ],)

           ],

       ),
      )),
    );
  }
}
