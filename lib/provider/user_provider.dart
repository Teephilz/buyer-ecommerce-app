import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../model/user_model.dart';

class UserProvider extends ChangeNotifier
{
  List<UserModel>usermodelList=[];

  Future<void> getUserData() async{
    List<UserModel> newList= [];
    User? currentUser= FirebaseAuth.instance.currentUser;
    QuerySnapshot usersnapShot= await FirebaseFirestore.instance.collection("User").
    where("UserID", isEqualTo: currentUser!.uid).get();
    usersnapShot.docs.forEach(
            (element) {
                UserModel userModel = UserModel(
                    userUID: element.get("UserID"),
                    userImage: element.get("UserImage"),
                    useremail: element.get("UserEmail"),
                    username: element.get("Username"),
                    usergender: element.get("UserGender"),
                    userPhonenumber: element.get("UserPhoneNumber"),
                    userAddress: element.get("UserAddress"));
                newList.add(userModel);
                });
    usermodelList= newList;
    notifyListeners();
  }

  List<UserModel> get getUsermodelList{
    return usermodelList;
  }
}