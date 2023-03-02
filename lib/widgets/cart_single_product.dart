import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taiwo_ecommerce_app/provider/cart_provider.dart';
import 'package:taiwo_ecommerce_app/provider/product_provider.dart';
import 'package:provider/provider.dart';

import '../model/cart_model.dart';
class CartSingleProduct extends StatefulWidget {
  CartModel model;
  final int index;



  CartSingleProduct({
    required this.model,
    required this.index
  });


  @override
  State<CartSingleProduct> createState() => _CartSingleProductState();
}

class _CartSingleProductState extends State<CartSingleProduct> {
  @override
  Widget build(BuildContext context) {
    var formatter=NumberFormat.decimalPattern('en_us');
    var provider=Provider.of<CartProvider>(context);

    return Container(
          height: 190,
          width: double.infinity,
          child: Card(
            child: Row(
              children: [
                Container(
                    width: 140,
                    height: 130,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(widget.model.model!.image.toString()))
                    )
                ),

                Expanded(
                  child: Container(
                    height: 190,
                    width: 190,
                    child: ListTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(widget.model.model!.itemTitle!,style: TextStyle(fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                              ),

                              Expanded(
                                child: IconButton(onPressed:
                                    (){
                                      provider.deleteCartProduct(widget.index);
                                    },
                                    icon: Icon(Icons.cancel,color: Colors.black)),
                              )
                            ]
                          ),
                          Text("₦${formatter.format(double.parse(widget.model.model!.price.toString()))}" ,style: TextStyle(fontSize: 18,
                              fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent)),

                      Container(
                        height: 40,
                        width: 110,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Quantity:",style:TextStyle(color: Colors.black,fontSize: 17),),

                              Text(widget.model.quantity .toString() , style: TextStyle(fontSize: 18),),

                            ],
                          ),
                        ),

                      ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                            Text("Size:",style:TextStyle(color: Colors.black,fontSize: 17, fontWeight: FontWeight.bold),),
                              SizedBox(width:25),
                            Text(widget.model.size! , style: TextStyle(fontSize: 18),),

                          ],),
                      ]
                      )
                    ),
                  ),
                )
              ],
            ),
          ),

    );
  }
}
