import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taiwo_ecommerce_app/model/user_model.dart';
import 'package:provider/provider.dart';

import '../model/cart_model.dart';
import '../model/products_model.dart';
class ProductProvider with ChangeNotifier{


  List<CartModel> cartModelList= [];

  List<ProductModel>featureList=[];
  List<ProductModel>newarchiveList=[];
  List<ProductModel>homefeatureList=[];
  List<ProductModel>homearchiveList=[];
  List<UserModel>usermodelList=[];


  void getCartData({
    String? name,
    String? image,
    String? size,
    String? color,
    int? quantity,
    double? price
  }) {

    CartModel cartModel= CartModel(
        name: name!,
        image: image!,
         color: color!,
        size: size!,
        quantity: quantity!,
         price: price!,

         );
    cartModelList.add(cartModel);
  }

  int get getCartModelListLength{
    return cartModelList.length;
  }

  List<CartModel> get getCartModelList{
    return cartModelList;
  }


  void deleteCartProduct (int index){
    cartModelList.removeAt(index);
    notifyListeners();
  }

  void clearCartProduct(){
    cartModelList.clear();
    notifyListeners();
  }




  Future<void> getFeatureData() async{
    List<ProductModel> newList=[];
    QuerySnapshot featuresnapShot= await FirebaseFirestore.instance.collection("products")
        .doc("bDtyDveFwUydnJKeOuRE")
        .collection("featureproduct")
        .get();
    featuresnapShot.docs.forEach(
            (element) {
         ProductModel featureData=  ProductModel(
              descript: element["descript"],
              image: element["image"],
              name: element["name"],
              price: element["price"]);
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
    QuerySnapshot newarchivesnapShot= await FirebaseFirestore.instance.collection("products")
        .doc("bDtyDveFwUydnJKeOuRE")
        .collection("archiveproduct")
        .get();
    newarchivesnapShot.docs.forEach(
            (element) {
         ProductModel newarchiveData=  ProductModel(
              descript: element.get("descript"),
              image: element.get("image"),
              name: element.get("name"),
              price: element.get("price"));
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
    QuerySnapshot featuresnapShot= await FirebaseFirestore.instance.collection("products")
        .doc("bDtyDveFwUydnJKeOuRE")
        .collection("homefeature")
        .get();
    featuresnapShot.docs.forEach(
            (element) {
          ProductModel homefeatureData=  ProductModel(
              descript: element.get("descript"),
              image: element.get("image"),
              name: element.get("name"),
              price: element.get("price"));
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
    QuerySnapshot archivesnapShot= await FirebaseFirestore.instance.collection("products")
        .doc("bDtyDveFwUydnJKeOuRE")
        .collection("homearchive")
        .get();
    archivesnapShot.docs.forEach(
            (element) {
         ProductModel homearchiveData=  ProductModel(
              descript: element.get("descript"),
              image: element.get("image"),
              name: element.get("name"),
              price: element.get("price"));
          newList.add(homearchiveData);
        });
    homearchiveList=newList;
    notifyListeners();
  }
  List<ProductModel> get getHomeArchiveList{
    return homearchiveList;

  }


  Future<void> getUserData() async{
    List<UserModel> newList= [];
    User? currentUser= FirebaseAuth.instance.currentUser;
    QuerySnapshot usersnapShot= await FirebaseFirestore.instance.collection("User")
        .get();
    usersnapShot.docs.forEach(
            (element) {
              if (currentUser?.uid == element.get("UserID")) {
                UserModel  userModel = UserModel(
                   userImage: element.get("UserImage"),
                    useremail: element.get("UserEmail"),
                    username: element.get("Username"),
                  usergender: element.get("UserGender"),
                userPhonenumber: element.get("UserPhoneNumber"),
                userAddress: element.get("UserAddress"));
                  newList.add(userModel);
              }
            });
    usermodelList= newList;
    notifyListeners();
    }

   List<UserModel> get getUsermodelList{
    return usermodelList;
    }

  List<String> notificationList =[];

  void addNotification(String notification){
    notificationList.add(notification);
  }

  int get getNotificationIndex{
    return notificationList.length;
  }

   List<ProductModel> searchlist=[];

  void getSearchList({required List<ProductModel>list}){
    searchlist=list;
    notifyListeners();
  }
  List<ProductModel> searchProductList(String query){
    List<ProductModel> searchProduct = searchlist.where((element){
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query);
    }).toList();
    return searchProduct;
  }

}