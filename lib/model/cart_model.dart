import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taiwo_ecommerce_app/model/products_model.dart';
class CartModel {
  ProductModel? model;
  String? size;
String? quantity;



  CartModel({
    this.model,
    this.size,
    this.quantity

});


}
