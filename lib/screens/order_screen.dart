import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taiwo_ecommerce_app/provider/order_provider.dart';
import 'package:taiwo_ecommerce_app/screens/orderCard.dart';
class OrderScreen extends StatefulWidget {


  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders", style: TextStyle(color: Colors.white, fontSize: 24),),
        centerTitle: true,
        elevation:0.0,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body:  Consumer<OrderProvider>(builder: (context,provider,c){
        provider.getOrderData();
        var orderList= provider.getOrderList;
        return
          ListView.separated(itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: OrderCard(
              model: orderList[index] ,
            ),
          );

        },
            separatorBuilder: ((context, index) {
              return SizedBox(
                height: 10,
              );
            }),
            itemCount: provider.getOrderListLength);
      },)
    );
  }
}
