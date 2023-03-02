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
  List<ProductModel>otherList=[];


  Future<void> getShirtData() async{
    List<ProductModel> newList= [];
    QuerySnapshot shirtsnapShot= await FirebaseFirestore.instance.collection("items")
        .where("type", isEqualTo: "Tshirt").orderBy("publishedDate", descending: true)
    .get();
    shirtsnapShot.docs.forEach(
      (element) {
     ProductModel shirtData=  ProductModel(
       itemID: element["itemID"],
       itemTitle: element["itemTitle"],
       longDescription:  element["longDescription"],
       price:  element["price"],
       publishedDate:  element["publishedDate"],
       sellerName:  element["sellerName"],
       sellerUID:  element["sellerUID"],
       type:   element["type"],
       image:  element["image"],
      );
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
    QuerySnapshot blazersnapShot= await FirebaseFirestore.instance.collection("items")
        .where("type", isEqualTo: "blazer").orderBy("publishedDate", descending: true)
        .get();
    blazersnapShot.docs.forEach(
            (element) {
       ProductModel  blazerData=  ProductModel(
         itemID: element["itemID"],
         itemTitle: element["itemTitle"],
         longDescription:  element["longDescription"],
         price:  element["price"],
         publishedDate:  element["publishedDate"],
         sellerName:  element["sellerName"],
         sellerUID:  element["sellerUID"],
         type:   element["type"],
         image:  element["image"],);
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
    QuerySnapshot shoesnapShot= await FirebaseFirestore.instance.collection("items")
        .where("type", isEqualTo: "shoe").orderBy("publishedDate", descending: true)
        .get();
    shoesnapShot.docs.forEach(
            (element) {
         ProductModel shoeData=  ProductModel(
           itemID: element["itemID"],
           itemTitle: element["itemTitle"],
           longDescription:  element["longDescription"],
           price:  element["price"],
           publishedDate:  element["publishedDate"],
           sellerName:  element["sellerName"],
           sellerUID:  element["sellerUID"],
           type:   element["type"],
           image:  element["image"],);
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
    QuerySnapshot shortsnapShot= await FirebaseFirestore.instance.collection("items")
        .where("type", isEqualTo: "shorts").orderBy("publishedDate", descending: true)
        .get();
    shortsnapShot.docs.forEach(
            (element) {
          ProductModel shortData=  ProductModel(
            itemID: element["itemID"],
            itemTitle: element["itemTitle"],
            longDescription:  element["longDescription"],
            price:  element["price"],
            publishedDate:  element["publishedDate"],
            sellerName:  element["sellerName"],
            sellerUID:  element["sellerUID"],
            type:   element["type"],
            image:  element["image"],);
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
    QuerySnapshot shoesnapShot= await FirebaseFirestore.instance.collection("items")
        .where("type", isEqualTo: "sweater").orderBy("publishedDate", descending: true)
        .get();
    shoesnapShot.docs.forEach(
            (element) {
        ProductModel  sweaterData=  ProductModel(
          itemID: element["itemID"],
          itemTitle: element["itemTitle"],
          longDescription:  element["longDescription"],
          price:  element["price"],
          publishedDate:  element["publishedDate"],
          sellerName:  element["sellerName"],
          sellerUID:  element["sellerUID"],
          type:   element["type"],
          image:  element["image"],);
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
    QuerySnapshot trousersnapShot= await FirebaseFirestore.instance.collection("items")
        .where("type", isEqualTo: "trouser").orderBy("publishedDate", descending: true)
        .get();
    trousersnapShot.docs.forEach(
            (element) {
          ProductModel trouserData=  ProductModel(
            itemID: element["itemID"],
            itemTitle: element["itemTitle"],
            longDescription:  element["longDescription"],
            price:  element["price"],
            publishedDate:  element["publishedDate"],
            sellerName:  element["sellerName"],
            sellerUID:  element["sellerUID"],
            type:   element["type"],
            image:  element["image"],);
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
    QuerySnapshot watchsnapShot= await FirebaseFirestore.instance.collection("items")
        .where("type", isEqualTo: "wristWatch").orderBy("publishedDate", descending: true)
        .get();
    watchsnapShot.docs.forEach(
            (element) {
          ProductModel watchData=  ProductModel(
            itemID: element["itemID"],
            itemTitle: element["itemTitle"],
            longDescription:  element["longDescription"],
            price:  element["price"],
            publishedDate:  element["publishedDate"],
            sellerName:  element["sellerName"],
            sellerUID:  element["sellerUID"],
            type:   element["type"],
            image:  element["image"],);
          newList.add(watchData);
        });
    watchList=newList;
    notifyListeners();
  }
  List<ProductModel> get getWatchList{
    return watchList;

  }

  Future<void> getOtherData() async{
    List<ProductModel> newList= [];
    QuerySnapshot watchsnapShot= await FirebaseFirestore.instance.collection("items")
        .where("type", isEqualTo: "other").orderBy("publishedDate", descending: true)
        .get();
    watchsnapShot.docs.forEach(
            (element) {
          ProductModel watchData=  ProductModel(
            itemID: element["itemID"],
            itemTitle: element["itemTitle"],
            longDescription:  element["longDescription"],
            price:  element["price"],
            publishedDate:  element["publishedDate"],
            sellerName:  element["sellerName"],
            sellerUID:  element["sellerUID"],
            type:   element["type"],
            image:  element["image"],);
          newList.add(watchData);
        });
    otherList=newList;
    notifyListeners();
  }
  List<ProductModel> get getOtherList{
    return otherList;

  }

   List<ProductModel> searchlist =[];
  void getSearchList({required List<ProductModel>list}){
    searchlist=list;
    notifyListeners();
  }
  List<ProductModel> searchCategoryList(String query){
    List<ProductModel> searchCategory = searchlist.where((element){
      return element.itemTitle!.toUpperCase().contains(query) ||
          element.itemTitle!.toLowerCase().contains(query);
    }).toList();
    return searchCategory;
  }

}