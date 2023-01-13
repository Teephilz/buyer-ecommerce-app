import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taiwo_ecommerce_app/model/cart_model.dart';
import 'package:taiwo_ecommerce_app/model/user_model.dart';
import 'package:taiwo_ecommerce_app/provider/product_provider.dart';
import 'package:taiwo_ecommerce_app/widgets/cart_single_product.dart';
import 'package:taiwo_ecommerce_app/widgets/notification_button.dart';
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
    ProductProvider productProvider=Provider.of<ProductProvider>(context);
  final checkoutList= productProvider.getCartModelList;
 final usermodelList=productProvider.getUsermodelList;
    String orderID= DateTime.now().millisecondsSinceEpoch.toString();
    return Column(
      children:usermodelList.map((e) {
        return  Container(
          height: 70,
          width: 100,
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
                FirebaseFirestore.instance.collection("Order").
                doc(orderID).set({
                  "Product": checkoutList.map((c) {
                    return
                      { "Product name": c.name,
                        "Product price": c.price,
                        "Product Quantity": c.quantity,
                        "Product Color": c.color,
                        "Ptoduct Size": c.size,
                      };
                  }
                  ).toList(),

                  "Total Price": total!.toStringAsFixed(2),
                  "Username": e.username,
                  "UserEmail": e.useremail,
                  "UserAddress": e.userAddress,
                  "UserUid": user!.uid,
                });
                productProvider.clearCartProduct();
              }
              else
                Fluttertoast.showToast(msg: "No item found in the cart"); },
            child: Text('Buy', style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),),
          )

        );

      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {

    double subTotal=0;
    double discount= 3;
    double discountRupees;
    double dispatch= 7;


    ProductProvider productProvider= Provider.of<ProductProvider>(context);
   final checkoutlist= productProvider.getCartModelList;
    checkoutlist.forEach((element) {
     subTotal += element.price * element.quantity;
    });
    discountRupees= (discount/100) * subTotal;
    total= (subTotal + dispatch)- discountRupees;
    if(checkoutlist.isEmpty){
      total=0.0;
      discount=0.0;
      dispatch=0.0;

    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Check Out", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        elevation: 0.0,
        backgroundColor: Colors.deepOrangeAccent,
        actions: <Widget>[
         NotificationButton()
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
                            itemCount:productProvider.getCartModelListLength,
                            itemBuilder:(context, index ){
                            return  CartSingleProduct(
                            index: index,
                            name: checkoutlist[index].name,
                            image: checkoutlist[index].image,
                            quantity:checkoutlist[index].quantity,
                            size: checkoutlist[index].size,
                            color:checkoutlist[index].color,
                            price: checkoutlist[index].price);})),

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

                            _buildBottomDetail(startname: "Dispatch fee", endname:
                            "\$ ${dispatch.toStringAsFixed(2)}"),

                            _buildBottomDetail(startname: "Total", endname:
                            "\$ ${total?.toStringAsFixed(2)}")

                          ],
                        ),
                      )
                      ,
                      Center(child: _buildButton())
                    ],

                    ),
                  ),



          );

              }

        }
