import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taiwo_ecommerce_app/model/user_model.dart';
import 'package:provider/provider.dart';

import '../model/cart_model.dart';
import '../model/products_model.dart';
class ProductProvider with ChangeNotifier{




  List<ProductModel>featureList=[];
  List<ProductModel>newarchiveList=[];
  List<ProductModel>homefeatureList=[];
  List<ProductModel>homearchiveList=[];



  Future<void> getFeatureData() async{
    List<ProductModel> newList=[];
    QuerySnapshot featuresnapShot= await FirebaseFirestore.instance.collection("items")
        .orderBy("publishedDate", descending: true)
        .get();
    featuresnapShot.docs.forEach(
            (element) {
         ProductModel featureData=  ProductModel(
           itemID: element["itemID"],
           itemTitle: element["itemTitle"],
           longDescription:  element["longDescription"],
           price:  element["price"],
           publishedDate:  element["publishedDate"],
           sellerName:  element["sellerName"],
           sellerUID:  element["sellerUID"],
           type:   element["type"],
           image:  element["image"],);
          newList.add(featureData);
        });
    featureList=newList;
    notifyListeners();
  }
  List<ProductModel> get getFeatureList{
    return featureList;

  }



  Future<void> getNewArchiveData() async{
    List<ProductModel> newList=[];
    QuerySnapshot newarchivesnapShot= await FirebaseFirestore.instance.collection("items")
        .orderBy("publishedDate", descending: true)
        .get();
    newarchivesnapShot.docs.forEach(
            (element) {
         ProductModel newarchiveData=  ProductModel(
           itemID: element["itemID"],
           itemTitle: element["itemTitle"],
           longDescription:  element["longDescription"],
           price:  element["price"],
           publishedDate:  element["publishedDate"],
           sellerName:  element["sellerName"],
           sellerUID:  element["sellerUID"],
           type:   element["type"],
           image:  element["image"],);
          newList.add(newarchiveData);
        });
    newarchiveList=newList;
    notifyListeners();
  }
  List<ProductModel> get getNewArchiveList{
    return newarchiveList;

  }



  Future<void> getHomeFeatureData() async{
    List<ProductModel> newList=[];
    QuerySnapshot featuresnapShot= await FirebaseFirestore.instance.collection("items")
        .orderBy("publishedDate", descending: true)
        .get();
    featuresnapShot.docs.forEach(
            (element) {
          ProductModel homefeatureData=  ProductModel(
            itemID: element["itemID"],
            itemTitle: element["itemTitle"],
            longDescription:  element["longDescription"],
            price:  element["price"],
            publishedDate:  element["publishedDate"],
            sellerName:  element["sellerName"],
            sellerUID:  element["sellerUID"],
            type:   element["type"],
            image:  element["image"],);
          newList.add(homefeatureData);
        });
    homefeatureList=newList;
    notifyListeners();
  }
  List<ProductModel> get getHomeFeatureList{
    return homefeatureList;

  }


  Future<void> getHomeArchiveData() async{
    List<ProductModel> newList=[];
    QuerySnapshot archivesnapShot= await FirebaseFirestore.instance.collection("items")
        .orderBy("publishedDate", descending: true)
        .get();
    archivesnapShot.docs.forEach(
            (element) {
         ProductModel homearchiveData=  ProductModel(
           itemID: element["itemID"],
           itemTitle: element["itemTitle"],
           longDescription:  element["longDescription"],
           price:  element["price"],
           publishedDate:  element["publishedDate"],
           sellerName:  element["sellerName"],
           sellerUID:  element["sellerUID"],
           type:   element["type"],
           image:  element["image"],);
          newList.add(homearchiveData);
        });
    homearchiveList=newList;
    notifyListeners();
  }
  List<ProductModel> get getHomeArchiveList{
    return homearchiveList;

  }




   List<ProductModel> searchlist=[];

  void getSearchList({required List<ProductModel>list}){
    searchlist=list;
    notifyListeners();
  }
  List<ProductModel> searchProductList(String query){
    List<ProductModel> searchProduct = searchlist.where((element){
      return element.itemTitle!.toUpperCase().contains(query) ||
          element.itemTitle!.toLowerCase().contains(query);
    }).toList();
    return searchProduct;
  }

}