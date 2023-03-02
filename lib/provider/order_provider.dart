import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../model/order_model.dart';

class OrderProvider extends ChangeNotifier{
  List<OrderModel>orders=[];
  OrderModel? model;
  User? currentUser= FirebaseAuth.instance.currentUser;


  Future<void>getOrderData()async{
    List<OrderModel>newList=[];
    QuerySnapshot orderData= await FirebaseFirestore.instance.collection("User")
        .doc(currentUser!.uid).collection("My Order").orderBy("orderTime", descending: true).get();
    orderData.docs.forEach((element) {
      model=OrderModel(
        userName: element["userName"],
        userEmail: element["userEmail"],
        userUID: element["userUid"],
        userAddress: element["userAddress"],
          userPhoneNumber: element["userPhoneNumber"],
        orderID: element["orderID"],
        orderTime: element["orderTime"],
        totalPrice: element["totalPrice"],
        orderItems: element["Items"],
        orderStatus: element["orderStatus"],
        sellerUIDs: element["sellerUIDS"]
      );
      newList.add(model!);

    });
    orders=newList;
    notifyListeners();
  }

  List get getOrderList{
    return orders;
  }


  int get getOrderListLength{
    return orders.length;
  }


}