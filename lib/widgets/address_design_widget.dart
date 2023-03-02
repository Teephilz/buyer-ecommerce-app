import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:taiwo_ecommerce_app/screens/home_screen.dart';

import '../model/order_model.dart';


class AddressDesign extends StatelessWidget
{
 OrderModel? model;

  AddressDesign({
this.model

  });


  // sendNotificationToUser(userUID, orderID) async
  // {
  //   String userDeviceToken = "";
  //
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(userUID)
  //       .get()
  //       .then((snapshot)
  //   {
  //     if(snapshot.data()!["userDeviceToken"] != null)
  //     {
  //       userDeviceToken = snapshot.data()!["userDeviceToken"].toString();
  //     }
  //   });
  //
  //   notificationFormat(
  //     userDeviceToken,
  //     orderID,
  //     sharedPreferences!.getString("name"),
  //   );
  // }
  //
  // notificationFormat(userDeviceToken, orderID, sellerName)
  // {
  //   Map<String, String> headerNotification =
  //   {
  //     'Content-Type': 'application/json',
  //     'Authorization': fcmServerToken,
  //   };
  //
  //   Map bodyNotification =
  //   {
  //     'body': "Dear user, your Parcel (# $orderID) has been shifted Successfully by seller $sellerName. \nPlease Check Now",
  //     'title': "Parcel Shifted",
  //   };
  //
  //   Map dataMap =
  //   {
  //     "click_action": "FLUTTER_NOTIFICATION_CLICK",
  //     "id": "1",
  //     "status": "done",
  //     "userOrderId": orderID,
  //   };
  //
  //   Map officialNotificationFormat =
  //   {
  //     'notification': bodyNotification,
  //     'data': dataMap,
  //     'priority': 'high',
  //     'to': userDeviceToken,
  //   };
  //
  //   http.post(
  //     Uri.parse("https://fcm.googleapis.com/fcm/send"),
  //     headers: headerNotification,
  //     body: jsonEncode(officialNotificationFormat),
  //   );
  // }

  @override
  Widget build(BuildContext context)
  {
    return Column(
      children: [

        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Shipping Details:',
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold
            ),
          ),
        ),

        const SizedBox(
          height: 6.0,
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [

              //name
              TableRow(
                children:
                [
                  const Text(
                    "Name",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    model!.userName.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              const TableRow(
                children:
                [
                   SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),

              //phone
              TableRow(
                children:
                [
                  const Text(
                    "Phone Number",
                    style: TextStyle(color: Colors.black),
                  ),
                  Expanded(
                    child: Text(
                      model!.userPhoneNumber.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            model!.userAddress.toString(),
            textAlign: TextAlign.justify,
            style: const TextStyle(
                color: Colors.black,
            ),
          ),
        ),

        GestureDetector(
          onTap: ()
          {
            if(model!.orderStatus.toString() == "normal")
          {
          //update earnings
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          }


            },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              color: Colors.deepOrangeAccent,
              width: MediaQuery.of(context).size.width - 40,
              height: model!.orderStatus == "ended" ? 60 : MediaQuery.of(context).size.height * .10,
              child: Center(
                child: Text(
                  model!.orderStatus  == "ended"
                      ? "Go Back"
                      : model!.orderStatus  == "shifted"
                      ? "Go Back"
                      : model!.orderStatus  == "normal"
                      ? "Parcel Packed & \nShifted to Nearest PickUp Point. \nClick to Confirm"
                      : "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }


}
