import 'package:badges/badges.dart';
import "package:flutter/material.dart";
import 'package:taiwo_ecommerce_app/provider/product_provider.dart';
import 'package:provider/provider.dart';
class NotificationButton extends StatelessWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider= Provider.of<ProductProvider>(context);
    return Badge(
      position: BadgePosition(
      start:25, top:8
      ),

      badgeContent: Text(productProvider.getNotificationIndex.toString(), style: TextStyle(color: Colors.deepOrangeAccent,
          fontSize: 10,fontWeight: FontWeight.bold
      ),),
      badgeColor: Colors.white,
      child: IconButton(icon: Icon(Icons.notifications_none, color: Colors.white,),
      onPressed: (){}
    ));
  }
}
