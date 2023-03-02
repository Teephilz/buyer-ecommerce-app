import 'package:flutter/material.dart';
import 'package:taiwo_ecommerce_app/provider/cart_provider.dart';
import 'package:taiwo_ecommerce_app/provider/product_provider.dart';
import 'package:taiwo_ecommerce_app/screens/check_out.dart';
import 'package:taiwo_ecommerce_app/widgets/cart_single_product.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
   final provider= Provider.of<CartProvider>(context);
    final cartmodelist= provider.getCartModelList;

    return Scaffold(
        appBar: AppBar(
          title: Text("Cart", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          elevation: 0.0,
          backgroundColor: Colors.deepOrangeAccent,
          actions: <Widget>[

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CheckOut(


                  )));

            },
            child: Text('Continous', style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),),
          )),

        body: ListView.builder(
            itemCount:provider.getCartModelListLength,
            itemBuilder:(context, index){
              return  CartSingleProduct(
              index: index,
              model: cartmodelist[index],);}));
            }

  }

