import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taiwo_ecommerce_app/provider/category_provider.dart';
import 'package:taiwo_ecommerce_app/provider/product_provider.dart';
import 'package:taiwo_ecommerce_app/screens/search_category.dart';
import 'package:taiwo_ecommerce_app/screens/search_product.dart';

import 'package:taiwo_ecommerce_app/widgets/singleproducts.dart';
import 'package:provider/provider.dart';

import '../model/products_model.dart';
import 'detailscreen.dart';
class   ListProducts extends StatelessWidget {
final  String name;
final List<ProductModel>snapShot;
bool isCategory =true;

  ListProducts({required this.name, required this.snapShot, required this.isCategory});

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider=Provider.of<CategoryProvider>(context);
    ProductProvider productProvider=Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.deepOrangeAccent,
        actions: <Widget>[
          isCategory == true? IconButton( icon: Icon(Icons.search),onPressed: (){
            categoryProvider.getSearchList(list: snapShot);
            showSearch(context: context, delegate: SearchCategory());
          }) :
          IconButton( icon: Icon(Icons.search),onPressed: (){
            productProvider.getSearchList(list: snapShot);
            showSearch(context: context, delegate: SearchProduct());
          }),
        ],
      ),

      body:ListView(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.all(5.0),
                child: Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:<Widget> [
                      Text(name, style: TextStyle(
                          fontSize: 17,fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),
              ),
              Container(
                height: 700,
                  child:
                  GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 4/6,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      children: snapShot.map((e){
                        return SingleProducts(model: e);
                      }).toList(),)

              )
            ],
      ));
        }
}
