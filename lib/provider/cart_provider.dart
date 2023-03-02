import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/cart_model.dart';
import '../model/products_model.dart';

class CartProvider extends ChangeNotifier{
  List<CartModel> cartModelList= [];
  CartModel? cartModel;

  void getCartData({
  ProductModel? model,
    String? size,
     String? quantity,
  }) {

    cartModel= CartModel(

      model: model,
      size:  size,
      quantity: quantity
    );
    cartModelList.add(cartModel!);
    notifyListeners();
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

  getCartProductModels(){
    List<ProductModel>itemModels=[];
    ProductModel? itemModel;
    for(int i=0; i<cartModelList.length; i++){
      itemModel= cartModelList[i].model!;
      itemModels.add(itemModel);
    }
    return itemModels;
  }


  getCartItemSellerUIDs(){
    List<String>sellerUIDs= [];
    String sellerID='';
    for(int i=0; i<cartModelList.length; i++ ){
      sellerID= cartModelList[i].model!.sellerUID!;
      sellerUIDs.add(sellerID);
    }
    return sellerUIDs;

  }
}