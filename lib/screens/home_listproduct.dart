import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taiwo_ecommerce_app/widgets/singleproducts.dart';

import '../model/products_model.dart';
import 'detailscreen.dart';
class   HomeListProducts extends StatelessWidget {
  final List<ProductModel>snapShot;

  HomeListProducts({required this.snapShot});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 270,
        child: GridView.count(
          crossAxisCount: 1,
          childAspectRatio: 7/5,
          scrollDirection: Axis.horizontal,
          children: snapShot.map((e){
              return SingleProducts(
                  name: e.name,
                  image: e.image,
                  price: e.price,
                  descript: e.descript);}).toList(),


        )
    );
  }

}