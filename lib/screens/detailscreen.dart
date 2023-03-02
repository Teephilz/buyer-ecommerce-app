import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:taiwo_ecommerce_app/provider/cart_provider.dart';
import 'package:taiwo_ecommerce_app/provider/product_provider.dart';
import 'package:taiwo_ecommerce_app/screens/check_out.dart';
import 'package:provider/provider.dart';
import '../model/products_model.dart';
import 'cart_scr.dart';
class DetailScreen extends StatefulWidget {
 ProductModel model;


  DetailScreen({
   required this.model
});


  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int count= 1;


var isSelected = [true, false, false, false];
var colored= [true, false, false, false];
  int sizeIndex= 0;
  int colorIndex= 0;
  late String size;
  late String color;

  void getSize(){
    if(sizeIndex == 0){
      setState(() {
        size= "S";

      });
    }else if(sizeIndex == 1){
      setState(() {
        size= "M";

      });
    }
    else if(sizeIndex == 2){
      setState(() {
        size= "L";

      });
    }
    else if(sizeIndex == 3){
      setState(() {
        size= "XL";

      });
    }
  }


  @override
  Widget build(BuildContext context) {
    var formatter=NumberFormat.decimalPattern('en_us');
   var provider=Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.deepOrangeAccent,

        actions: <Widget>[
          Stack(
            children: [
              IconButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
                  },

                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
              Positioned(
                child: Stack(
                  children: [

                    const Icon(
                      Icons.brightness_1,
                      size: 20,
                      color: Colors.white,
                    ),

                    Positioned(
                      top: 2,
                      right: 6,
                      child: Center(
                        child: Text(
                              "${provider.getCartModelListLength}",
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            )

                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: ListView(
          children: [
           Padding(
             padding: const EdgeInsets.all(13),
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child:Container(
                    height: 300,
                   width: 300,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Container(
                        height: 220,
                        decoration: BoxDecoration(
                          image: DecorationImage( fit:BoxFit.fill,
                              image: NetworkImage(widget.model.image.toString())
                        )
                      ),
                  ),
                    )
                  ),
                )
                ),

                Container(
                  height: 80,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: (
                    Column(
                      mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.model.itemTitle!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("₦${formatter.format(double.parse(widget.model.price.toString()))}", style: TextStyle(fontSize: 18, color: Colors.deepOrangeAccent,fontWeight: FontWeight.bold)),

                      ],
                    )
                  ),
                ),

                Text("Description", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                SizedBox(height: 7,),

                Container(
                  height: 100,
                  child: Wrap(
                    children: [
                      Text(widget.model.longDescription!)
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Text("Size",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),

                SizedBox(
                  height: 10,
                ),

                Container(
                  width:265,
                  child: ToggleButtons(
                    children: [
                      Text("S"),
                      Text("M"),
                     Text("L"),
                      Text("XL"),
                    ],

                    onPressed: (int index){
                      setState(() {
                        for(int indexBtn=0; indexBtn< isSelected.length; indexBtn++){
                          if(indexBtn== index){
                            isSelected[indexBtn]= true;
                          }else{
                            isSelected[indexBtn]= false;
                          }
                        }
                      });
                        setState(() {
                        sizeIndex=index;
                        });
                        },

                    isSelected:isSelected,
                  )
                ),

                SizedBox(
                  height: 10,
                ),


                Text("Quantity",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),

                SizedBox(
                  height: 10,
                ),

                Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.cyan.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Icon(Icons.remove),
                        onTap: (){
                          if(count > 1){
                          setState(() {
                            count --;
                          });}
                        }
                      ),

                      Text(count.toString() , style: TextStyle(fontSize: 18),),

                      GestureDetector(
                        child: Icon(Icons.add),
                        onTap: (){
                          setState(() {
                            count ++;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 15,
                ),

                Container(
                  height: 60,
                  width: double.infinity,
                  child:
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrangeAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                      ),
                      onPressed: ()
                      {
                        if(provider.getCartProductModels().contains(widget.model)){
                          Fluttertoast.showToast(msg: "item is already in the cart");

                        }
                        else{
                          getSize();
                          provider.getCartData(
                         model: widget.model,
                          size:  size,
                          quantity: count.toString()
                          );
                          Fluttertoast.showToast(msg: "item added to cart");
                        }

                      },
                      child: Text('Add to Cart', style: TextStyle(fontSize: 17, color: Colors.white,fontWeight: FontWeight.bold),),
                  )
                )


              ],
          ),
           ),
        ]),
      ),
    );
  }
}
