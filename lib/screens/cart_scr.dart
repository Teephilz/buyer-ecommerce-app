import 'package:flutter/material.dart';
import 'package:taiwo_ecommerce_app/provider/product_provider.dart';
import 'package:taiwo_ecommerce_app/screens/check_out.dart';
import 'package:taiwo_ecommerce_app/widgets/cart_single_product.dart';
import 'package:provider/provider.dart';

import '../model/cart_model.dart';
import '../widgets/notification_button.dart';
class CartScreen extends StatefulWidget {

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
   final productProvider= Provider.of<ProductProvider>(context);
    final cartmodelist= productProvider.getCartModelList;

    return Scaffold(
        appBar: AppBar(
          title: Text("Cart", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          elevation: 0.0,
          backgroundColor: Colors.deepOrangeAccent,
          actions: <Widget>[
            NotificationButton()
          ],
        ),
        bottomNavigationBar: Container(
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
              productProvider.addNotification("Notification");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CheckOut(


                  )));

            },
            child: Text('Continous', style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),),
          )),

        body: ListView.builder(
            itemCount:productProvider.getCartModelListLength,
            itemBuilder:(context, index){
              return  CartSingleProduct(
              index: index,
              name:  cartmodelist[index].name,
              image: cartmodelist[index].image,
             quantity: cartmodelist[index].quantity,
              size:  cartmodelist[index].size,
              color:  cartmodelist[index].color,
              price: cartmodelist[index].price);}));
            }

  }

