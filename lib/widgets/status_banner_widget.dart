import 'package:flutter/material.dart';

import '../screens/home_screen.dart';


class StatusBanner extends StatelessWidget
{
  String? orderStatus;

  StatusBanner({ this.orderStatus,});



  @override
  Widget build(BuildContext context)
  {


    return Container(
      decoration: const BoxDecoration(
         color: Colors.deepOrangeAccent
      ),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          GestureDetector(
            onTap: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 30,),

          Text(
            orderStatus == "ended"
                ? "Parcel Delivered  successfully"
                : orderStatus == "shifted"
                ? "Parcel was Shifted successfully"
                : orderStatus == "normal"
                ? "Order was placed successfully"
                : "",
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),

          const SizedBox(width: 6,),

          CircleAvatar(
            radius: 10,
            backgroundColor: Colors.green,
            child: Center(
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
