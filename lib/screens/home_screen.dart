import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taiwo_ecommerce_app/model/products_model.dart';
import 'package:taiwo_ecommerce_app/model/user_model.dart';
import 'package:taiwo_ecommerce_app/provider/cart_provider.dart';
import 'package:taiwo_ecommerce_app/provider/category_provider.dart';
import 'package:taiwo_ecommerce_app/provider/product_provider.dart';
import 'package:taiwo_ecommerce_app/provider/user_provider.dart';
import 'package:taiwo_ecommerce_app/screens/cart_scr.dart';
import 'package:taiwo_ecommerce_app/screens/home_listproduct.dart';
import 'package:taiwo_ecommerce_app/screens/login_screen.dart';
import 'package:taiwo_ecommerce_app/screens/order_screen.dart';
import 'package:taiwo_ecommerce_app/screens/profile_page.dart';
import 'package:taiwo_ecommerce_app/screens/search_category.dart';


import 'package:provider/provider.dart';

import '../model/products_model.dart';
import '../provider/order_provider.dart';
import 'listproducts.dart';
class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();

}
class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState>_key= GlobalKey<ScaffoldState>();

  Widget image_carousel= new Container(
    height: 250.00,
    child: Carousel(
      boxFit: BoxFit.cover,
      images: [
        AssetImage('images/twomen.jpg'),
        AssetImage('images/man.jpg'),
        AssetImage('images/sweater.jpeg'),
        AssetImage('images/woman.jpg'),
      ],
      autoplay: true,
      dotSize: 4.0,
      dotColor: Colors.white,
      dotBgColor: Colors.transparent,
      indicatorBgPadding: 2.0,
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 1000),

    ),
  );

  Widget _buildCategoryProduct({ required String image, required String name}){
    return Container(
      width: 100,
      child: ListTile(
        title: Image.asset(
          image,
          height: 80,
          width: 100,
        ),
        subtitle: Container(
          alignment: Alignment.topCenter,
          child: Text(name,style: TextStyle(fontSize: 12),
          ),

        ),
      ),
    );
  }

  Widget _buildAccountDrawerHeader(){
    var provider = Provider.of<UserProvider>(context);
    provider.getUserData();
    final userModel= provider.getUsermodelList;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: userModel.map((e) =>
            UserAccountsDrawerHeader(
              accountName:
              Text(e.username,style: TextStyle(color: Colors.white,
              fontSize: 16)),
              accountEmail:
              Text(e.useremail,style: TextStyle(color: Colors.white),),
              currentAccountPicture: GestureDetector(
                onTap: (){
                },
                child:  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(e.userImage)

                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.deepOrange
              ),)
        ).toList()
    );

  }

  @override
  Widget build(BuildContext context) {
    CategoryProvider cartegoryprovider = Provider.of<CategoryProvider>(context);
    cartegoryprovider.getShirtData();
    cartegoryprovider.getBlazerData();
    cartegoryprovider.getShoesData();
    cartegoryprovider.getShortsData();
    cartegoryprovider.getTrouserData();
    cartegoryprovider.getSweaterData();
    cartegoryprovider.getWatchData();
    cartegoryprovider.getOtherData();

   final shirts= cartegoryprovider.getShirtList;
   final blazers= cartegoryprovider.getBlazerList;
   final shoes=cartegoryprovider.getShoeList;
   final shorts= cartegoryprovider.getShortsList;
   final trousers= cartegoryprovider.getTrouserList;
   final sweaters= cartegoryprovider.getSweaterList;
  final watches= cartegoryprovider.getWatchList;
  final others=cartegoryprovider.getOtherList;

    ProductProvider productprovider = Provider.of<ProductProvider>(context);
    productprovider.getFeatureData();
    productprovider.getNewArchiveData();
    productprovider.getHomeFeatureData();
    productprovider.getHomeArchiveData();


    final features= productprovider.getFeatureList;
    final newarchives= productprovider.getNewArchiveList;
    final homefeatures= productprovider.getHomeFeatureList;
     final homearchive= productprovider.getHomeArchiveList;





    return Scaffold(
        drawer: Consumer2<CartProvider,OrderProvider>(builder: (context,cartProvider, provider,c){
          provider.getOrderData();
          return
            Drawer(
              child:ListView(
                children:<Widget> [
                  _buildAccountDrawerHeader(),
                  //create the body forthe drawer
                  InkWell(
                    child: ListTile (
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>ProfileScreen() ));
                      },
                      title: Text('Profile'),
                      leading: Icon(Icons.person, color: Colors.deepOrangeAccent),
                    ),
                  ),

                  InkWell(
                    child: ListTile (
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(
                          ) ));
                        },
                        title: Text('Shopping Cart'),
                        leading: Stack(
                          children: [
                            IconButton(
                              onPressed: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
                              },

                              icon: const Icon(
                                Icons.shopping_cart,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                            Positioned(
                              child: Stack(
                                children: [

                                  const Icon(
                                    Icons.brightness_1,
                                    size: 20,
                                    color: Colors.black,
                                  ),

                                  Positioned(
                                    top: 2,
                                    right: 6,
                                    child: Center(
                                        child: Text(
                                          "${cartProvider.getCartModelListLength}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        )

                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                    ),
                  ),

                  Divider(),

                  InkWell(
                    child: ListTile (
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderScreen()));
                      },
                      title: Text('Orders'),
                      leading: Stack(
                        children: [
                          IconButton(
                            onPressed: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderScreen()));
                            },

                            icon: const Icon(
                              Icons.shopping_basket_rounded,
                              color: Colors.deepOrangeAccent,
                            ),
                          ),
                          Positioned(
                            child: Stack(
                              children: [

                                const Icon(
                                  Icons.brightness_1,
                                  size: 20,
                                  color: Colors.black,
                                ),

                                Positioned(
                                  top: 2,
                                  right: 6,
                                  child: Center(
                                      child: Text(
                                        "${provider.getOrderListLength}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      )

                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    child: ListTile (
                      onTap: (){
                        FirebaseAuth.instance.signOut().then((value) {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => LogInScreen()));
                        }
                        );

                      },
                      title: Text('Log Out'),
                      leading: Icon(Icons.exit_to_app, color: Colors.deepOrange,),
                    ),
                  ),

                ],
              ),

            );
        },),
        appBar: AppBar(
          title: Text("HomePage", style: TextStyle(color: Colors.white, fontSize: 24),),
          centerTitle: true,
          elevation:0.0,
          backgroundColor: Colors.deepOrangeAccent,
          actions: <Widget> [

          ],
        ),
        body: Padding(

          padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          child: ListView(
            children: [
              image_carousel,
              SizedBox(
                height: 10,
              ),
              Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Categories", style: TextStyle(fontSize: 17,
                        fontWeight: FontWeight.bold,color: Colors.black),),
                  ],
                ),
              ),
              Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:<Widget> [
                    GestureDetector(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) => ListProducts(name: "Blazers",
                                  snapShot: blazers,
                                isCategory: true,)));
                        },
                        child: _buildCategoryProduct(image: "images/blazervct.jpg",
                            name: "Blazer")),

                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context) => ListProducts(name: "Sweaters",
                              snapShot: sweaters,
                            isCategory: true,)));
                      },

                      child: _buildCategoryProduct(image: "images/sweatervct.jpg",
                          name: "Sweater"),
                    ),

                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context) => ListProducts(name: "Trousers",
                                snapShot: trousers,
                              isCategory: true,)));
                      },

                      child: _buildCategoryProduct(image: "images/trouservct.jpg",
                          name: "Trouser"),
                    ),


                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context) => ListProducts(name: "T-shirts",
                                snapShot: shirts,
                              isCategory: true,)));
                      },

                      child: _buildCategoryProduct(image: "images/tshirtvct.jpg",
                          name: "TShirt"),
                    ),

                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context) => ListProducts(name: "Shorts",
                                snapShot: shorts,
                              isCategory: true,)));
                      },

                      child: _buildCategoryProduct(image: "images/short.jpg",
                          name: "Shorts"),
                    ),

                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context) => ListProducts(name: "Shoes",
                                snapShot: shoes,
                              isCategory: true,)));
                      },

                      child: _buildCategoryProduct(image: "images/maleshoevct.jpg",
                          name: "Shoe"),
                    ),

                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context) => ListProducts(name: "Wrist Watch",
                                snapShot:watches,
                              isCategory: true,)));
                      },
                      child: _buildCategoryProduct(image: "images/wristvct.jpg",
                          name: "Wrist watch"),
                    ),

                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context) => ListProducts(name: "Others",
                          snapShot:others,
                          isCategory: true,)));
                      },
                      child: _buildCategoryProduct(image: "images/other.jpg",
                          name: "Others"),
                    ),
                  ],

                ),
              ),

              SizedBox(height: 5,),

              Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:<Widget> [
                    Text("Featured", style: TextStyle(
                        fontSize: 17,fontWeight: FontWeight.bold
                    ),),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder:(context)
                        =>ListProducts(name:"Featured",
                          snapShot:features,
                          isCategory: false,)));
                      },
                      child: Text("View more", style: TextStyle(
                          fontSize: 17,fontWeight: FontWeight.bold
                      ),),
                    )
                  ],
                ),
              ),

              SizedBox(height: 5,),

              HomeListProducts(snapShot: homefeatures),


              Container(
                height: 30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget> [
                        Text("New Archives", style: TextStyle(
                            fontSize: 17,fontWeight: FontWeight.bold
                        ),),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder:(context)
                            =>ListProducts(name:"New Archives",
                              snapShot:newarchives,
                              isCategory: false,),));
                          },
                          child: Text("View more", style: TextStyle(
                              fontSize: 17,fontWeight: FontWeight.bold
                          ),),
                        ),

                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 5,),

              HomeListProducts(snapShot: homearchive),

            ],
          ),
        )

    );

  }

}



