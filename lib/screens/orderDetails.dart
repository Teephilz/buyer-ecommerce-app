import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taiwo_ecommerce_app/model/order_model.dart';
import 'package:taiwo_ecommerce_app/widgets/status_banner_widget.dart';

import '../widgets/address_design_widget.dart';
class OrderDetailScreen extends StatefulWidget {
OrderModel? model;
OrderDetailScreen({ this.model});
  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var formatter= NumberFormat.decimalPattern('en_us');
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          height: MediaQuery.of(context).size.height*0.98,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   StatusBanner(
                     orderStatus: widget.model!.orderStatus,
                   ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Price:",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),),
                          Text(
                            "₦${formatter.format(double.parse(widget.model!.totalPrice!))}",
                            style: const TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Order ID = " + widget.model!.orderID!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Order at = " + DateFormat("dd MMMM, yyyy - hh:mm aa")
                              .format(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.model!.orderTime!))),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    const Divider(
                      thickness: 1,
                      color: Colors.blueAccent,
                    ),

                    widget.model!.orderTime!= "ended"
                        ? Image.asset("images/packing.jpg")
                        : Image.asset("images/delivered.jpg"),

                    const Divider(
                      thickness: 1,
                      color: Colors.blueAccent,
                    ),

                           AddressDesign(
                              model:widget.model
                          )


                  ],
                ),
          ),
        ),
      ));



  }
}
