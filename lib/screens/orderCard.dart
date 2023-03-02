
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taiwo_ecommerce_app/model/order_model.dart';

import 'orderDetails.dart';

class OrderCard extends StatelessWidget {
 OrderModel? model;
  OrderCard({this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailScreen(model:model)));
      },
      child: Card(
        color: Colors.white,
        shadowColor: Colors.white54,
        child: Container(
          color: Colors.transparent,
          height: (
              model!.orderItems!.length.toDouble())*190,
          child: ListView(
            children: model!.orderItems!.map((e) {
              return OrderItemWidget(
                  name: e["name"],
                  image: e["image"],
                  price: e["price"],
                  size: e["size"],
                  quantity: e["quantity"]
              );

            }).toList(),
          )

        ),
      ),
    );
  }
  Widget OrderItemWidget({
    String? name,
    String? image,
    String? size,
    String? color,
    String? price,
     String? quantity,

  }){
    var formatter=NumberFormat.decimalPattern('en_us');
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
                          image: NetworkImage(image!))
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
                                    child: Text(name!,style: TextStyle(fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                  ),

                                ]
                            ),
                            Text("₦${formatter.format(double.parse(price.toString()))}",style: TextStyle(fontSize: 18,
                                fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent)),

                            Row(
                              children: [

                                const Text(
                                  "x ",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),

                                Text(
                                  quantity.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Size:",style:TextStyle(color: Colors.black,fontSize: 17, fontWeight: FontWeight.bold),),
                                SizedBox(width:25),
                                Text(size!, style: TextStyle(fontSize: 18),),

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
