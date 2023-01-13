import 'package:flutter/material.dart';
class CartModel {
  final String name;
  final String image;
  final String color;
  final String size;
  final double price;
  final int quantity;

  CartModel({ required this.name, required this.image, required this.price, required this.quantity,
  required this.size, required this.color});


}
