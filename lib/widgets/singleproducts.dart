import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taiwo_ecommerce_app/screens/detailscreen.dart';
import 'package:provider/provider.dart';

import '../model/products_model.dart';
import '../provider/product_provider.dart';
class SingleProducts extends StatelessWidget {
 // String? itemID;
 // String? itemTitle;
 // String? longDescription;
 // String? price;
 // Timestamp? publishedDate;
 // String? sellerName;
 // String? sellerUID;
 // String? image;
 ProductModel model;

 SingleProducts({

required this.model
});


  @override
  Widget build(BuildContext context) {
    var formatter=NumberFormat.decimalPattern('en_us');
    return GestureDetector(
     onTap: (){
      Navigator.push(context, MaterialPageRoute(builder:
          (context) =>DetailScreen(
        model: model,



              )));
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
              image: DecorationImage(image: NetworkImage(model.image.toString()) )
          ),
         ),
          Column(
           children: [
            Text(model.itemTitle!, style: TextStyle(color: Colors.black, fontSize: 17)),
            SizedBox(width: 50,),
            Text("₦${formatter.format(double.parse(model.price.toString()))}", style: TextStyle(color: Colors.orange, fontSize: 17, fontWeight: FontWeight.bold),),

           ],)

           ],

       ),
      )),
    );
  }
}
