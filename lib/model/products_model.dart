import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

 class ProductModel {
   String? itemID;
   String? itemTitle;
   String? longDescription;
   String? price;
   Timestamp? publishedDate;
   String? sellerName;
   String? sellerUID;
   String? type;
   String? image;


   ProductModel({
     this.itemID,
     this.itemTitle,
     this.longDescription,
     this.price,
     this.publishedDate,
     this.sellerName,
     this.sellerUID,
     this.type,
     this.image,
  }
 );
 }
