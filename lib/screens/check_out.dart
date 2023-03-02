import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taiwo_ecommerce_app/model/cart_model.dart';
import 'package:taiwo_ecommerce_app/model/user_model.dart';
import 'package:taiwo_ecommerce_app/provider/cart_provider.dart';
import 'package:taiwo_ecommerce_app/provider/product_provider.dart';
import 'package:taiwo_ecommerce_app/provider/user_provider.dart';
import 'package:taiwo_ecommerce_app/widgets/cart_single_product.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {



  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {

  Widget _buildBottomDetail({required String startname, required String endname}){
    return  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Text(startname, style: TextStyle(fontSize: 16),),
          Text(endname, style: TextStyle(fontSize: 16)),]
    );
  }


  double? total;
  User? user= FirebaseAuth.instance.currentUser;

  Widget _buildButton(){
    String orderID= DateTime.now().millisecondsSinceEpoch.toString();
    String orderTime= DateTime.now().millisecondsSinceEpoch.toString();

    return Consumer2<CartProvider,UserProvider>(builder: (context, cartProvider, userProvider,c){
      final checkoutList= cartProvider.getCartModelList;
      final usermodelList=userProvider.getUsermodelList;
      return Column(
        children:usermodelList.map((e) {
          return  Container(
              height: 70,
              width: 150,
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.only(bottom: 10),
              child:
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrangeAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                ),
                onPressed: ()
                {
                  if(checkoutList.isNotEmpty) {
                    FirebaseFirestore.instance.collection("User").doc(e.userUID).collection("My Order").
                    doc(orderID).set({
                      "Items": checkoutList.map((c) {
                        return
                          { "name": c.model!.itemTitle,
                            "price": c.model!.price,
                            "quantity": c.quantity,
                            "size": c.size,
                            "image":c.model!.image,
                            "sellerName":c.model!.sellerName,
                            "sellerUID":c.model!.sellerUID
                          };
                      }
                      ).toList(),

                      "totalPrice": total!.toStringAsFixed(2),
                      "userName": e.username,
                      "userEmail": e.useremail,
                      "userAddress": e.userAddress,
                      "userPhoneNumber":e.userPhonenumber,
                      "userUid": user!.uid,
                      "orderID": orderID,
                      "orderTime": orderTime,
                      "orderStatus": "normal",
                      "sellerUIDS": cartProvider.getCartItemSellerUIDs()
                    }).whenComplete((){
                      FirebaseFirestore.instance.collection("Orders").
                      doc(orderID).set({
                        "Items": checkoutList.map((c) {
                          return
                            { "name": c.model!.itemTitle,
                              "price": c.model!.price,
                              "quantity": c.quantity,
                              "size": c.size,
                              "image":c.model!.image,
                              "sellerName":c.model!.sellerName,
                              "sellerUID":c.model!.sellerUID
                            };
                        }
                        ).toList(),

                        "totalPrice": total!.toStringAsFixed(2),
                        "userName": e.username,
                        "userEmail": e.useremail,
                        "userAddress": e.userAddress,
                        "userPhoneNumber":e.userPhonenumber,
                        "userUid": user!.uid,
                        "orderID": orderID,
                        "orderTime": orderTime,
                        "orderStatus": "normal",
                        "sellerUIDS": cartProvider.getCartItemSellerUIDs()
                    });
                    cartProvider.clearCartProduct();
                  });}
                  else
                    Fluttertoast.showToast(msg: "No item found in the cart"); },
                child: Text('Buy', style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),),
              )

          );

        }).toList(),
      );});
    }

    @override
    Widget build(BuildContext context) {

      double subTotal=0;
      double discount= 0;
      double discountRupees;

      var provider= Provider.of<CartProvider>(context);
      final checkoutlist= provider.getCartModelList;

      checkoutlist.forEach((element) {
        subTotal += double.parse(element.model!.price!) * double.parse(element.quantity!);
      });
      discountRupees= (discount/100) * subTotal;
      total= (subTotal)- discountRupees;
      if(checkoutlist.isEmpty){
        total=0.0;
        discount=0.0;
      }

      return Scaffold(
          appBar: AppBar(
            title: Text("Check Out", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            elevation: 0.0,
            backgroundColor: Colors.deepOrangeAccent,
            actions: <Widget>[
            ],
          ),

          body: Container(padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height:480,
                      child: ListView.builder(
                          itemCount:provider.getCartModelListLength,
                          itemBuilder:(context, index ){
                            return  CartSingleProduct(
                                index: index,
                                model: checkoutlist[index],);})),

                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildBottomDetail(startname: "SubTotal",
                            endname: "\$ ${subTotal.toStringAsFixed(2)}"),

                        _buildBottomDetail(startname: "Discount",
                            endname: "${discount.toStringAsFixed(2)}%"),

                        _buildBottomDetail(startname: "Total", endname:
                        "\$ ${total?.toStringAsFixed(2)}")

                      ],
                    ),
                  )
                  ,
                  Center(child: _buildButton())
                ],

              )
          )
      );
    }

  }

