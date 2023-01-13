import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taiwo_ecommerce_app/model/products_model.dart';
import 'package:taiwo_ecommerce_app/screens/listproducts.dart';
import 'package:taiwo_ecommerce_app/model/products_model.dart';
class CategoryProvider with ChangeNotifier{

  List<ProductModel>shirtList=[];
  List<ProductModel>blazerList=[];
  List<ProductModel>shoeList=[];
  List<ProductModel>shortList=[];
  List<ProductModel>trouserList=[];
  List<ProductModel>sweaterList=[];
  List<ProductModel>watchList=[];


  Future<void> getShirtData() async{
    List<ProductModel> newList= [];
    QuerySnapshot shirtsnapShot= await FirebaseFirestore.instance.collection("category")
    .doc("OlGbeoKClOEnQFclxLdo")
    .collection("TShirt")
    .get();
    shirtsnapShot.docs.forEach(
      (element) {
     ProductModel shirtData=  ProductModel(
       descript: element.get("descript"),
        image: element.get("image"),
        name: element.get("name"),
        price: element.get("price"));
     newList.add(shirtData);
      });
     shirtList=newList;
    notifyListeners();
  }
  List<ProductModel> get getShirtList{
    return shirtList;

  }


  Future<void> getBlazerData() async{
    List<ProductModel> newList= [];
    QuerySnapshot blazersnapShot= await FirebaseFirestore.instance.collection("category")
        .doc("OlGbeoKClOEnQFclxLdo")
        .collection("blazer")
        .get();
    blazersnapShot.docs.forEach(
            (element) {
       ProductModel  blazerData=  ProductModel(
              descript: element.get("descript"),
              image: element.get("image"),
              name: element.get("name"),
              price: element.get("price"));
            newList.add(blazerData);
        });
    blazerList=newList;
    notifyListeners();
  }
  List<ProductModel> get getBlazerList{
    return blazerList;

  }


  Future<void> getShoesData() async{
    List<ProductModel> newList= [];
    QuerySnapshot shoesnapShot= await FirebaseFirestore.instance.collection("category")
        .doc("OlGbeoKClOEnQFclxLdo")
        .collection("shoes")
        .get();
    shoesnapShot.docs.forEach(
            (element) {
         ProductModel shoeData=  ProductModel(
              descript: element.get("descript"),
              image: element.get("image"),
              name: element.get("name"),
              price: element.get("price"));
         newList.add(shoeData);
        });
    shoeList=newList;
    notifyListeners();
  }
  List<ProductModel> get getShoeList{
    return shoeList;

  }




  Future<void> getShortsData() async{
    List<ProductModel> newList= [];
    QuerySnapshot shortsnapShot= await FirebaseFirestore.instance.collection("category")
        .doc("OlGbeoKClOEnQFclxLdo")
        .collection("shorts")
        .get();
    shortsnapShot.docs.forEach(
            (element) {
          ProductModel shortData=  ProductModel(
              descript: element.get("descript"),
              image: element.get("image"),
              name: element.get("name"),
              price: element.get("price"));
          newList.add(shortData);
        });
    shortList=newList;
    notifyListeners();
  }
  List<ProductModel> get getShortsList{
    return shortList;

  }



  Future<void> getSweaterData() async{
    List<ProductModel> newList= [];
    QuerySnapshot shoesnapShot= await FirebaseFirestore.instance.collection("category")
        .doc("OlGbeoKClOEnQFclxLdo")
        .collection("sweater")
        .get();
    shoesnapShot.docs.forEach(
            (element) {
        ProductModel  sweaterData=  ProductModel(
              descript: element.get("descript"),
              image: element.get("image"),
              name: element.get("name"),
              price: element.get("price"));
        newList.add(sweaterData);
        });
    sweaterList=newList;
    notifyListeners();
  }
  List<ProductModel> get getSweaterList{
    return sweaterList;

  }


  Future<void> getTrouserData() async{
    List<ProductModel> newList= [];
    QuerySnapshot trousersnapShot= await FirebaseFirestore.instance.collection("category")
        .doc("OlGbeoKClOEnQFclxLdo")
        .collection("trouser")
        .get();
    trousersnapShot.docs.forEach(
            (element) {
          ProductModel trouserData=  ProductModel(
              descript: element.get("descript"),
              image: element.get("image"),
              name: element.get("name"),
              price: element.get("price"));
         newList.add(trouserData);
        });
    trouserList=newList;
    notifyListeners();
  }
  List<ProductModel> get getTrouserList{
    return trouserList;

  }


  Future<void> getWatchData() async{
    List<ProductModel> newList= [];
    QuerySnapshot watchsnapShot= await FirebaseFirestore.instance.collection("category")
        .doc("OlGbeoKClOEnQFclxLdo")
        .collection("wristwatch")
        .get();
    watchsnapShot.docs.forEach(
            (element) {
          ProductModel watchData=  ProductModel(
              descript: element.get("descript"),
              image: element.get("image"),
              name: element.get("name"),
              price: element.get("price"));
          newList.add(watchData);
        });
    watchList=newList;
    notifyListeners();
  }
  List<ProductModel> get getWatchList{
    return watchList;

  }

   List<ProductModel> searchlist =[];
  void getSearchList({required List<ProductModel>list}){
    searchlist=list;
    notifyListeners();
  }
  List<ProductModel> searchCategoryList(String query){
    List<ProductModel> searchCategory = searchlist.where((element){
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query);
    }).toList();
    return searchCategory;
  }

}