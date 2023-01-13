import 'package:flutter/material.dart';
import 'package:taiwo_ecommerce_app/provider/product_provider.dart';
import 'package:taiwo_ecommerce_app/screens/check_out.dart';
import 'package:provider/provider.dart';
import '../widgets/notification_button.dart';
import 'cart_scr.dart';
class DetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final double price;
  final String descript;


  DetailScreen({required this.image, required this.name,required this.price, required this.descript, });


  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int count= 1;


  Widget _buildColorProduct({required Color color}){
    return Container(
      height: 40,
      width: 40,
      color: color
      );

  }
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


  void getColor(){
    if(colorIndex == 0){
      setState(() {
        color= "blue";

      });
    }else if(colorIndex == 1){
      setState(() {
        color= "green";

      });
    }
    else if(colorIndex == 2){
      setState(() {
        color= "yellow";

      });
    }
    else if(colorIndex == 3){
      setState(() {
        color= "orange";

      });
    }
  }
  @override
  Widget build(BuildContext context) {
   var productProvider=Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.deepOrangeAccent,

        actions: <Widget>[
          NotificationButton()
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
                              image: NetworkImage(widget.image)
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
                        Text(widget.name.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("\$ ${widget.price.toString()}", style: TextStyle(fontSize: 18, color: Colors.deepOrangeAccent,fontWeight: FontWeight.bold)),

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
                      Text(widget.descript)
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

                Text("Color",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),

                SizedBox(
                  height: 10,
                ),


                Container(
                    width:265,
                    child: ToggleButtons(
                      fillColor: Colors.blueAccent,
                      renderBorder: false,
                      children: [
                        _buildColorProduct(color: Colors.blueAccent.withOpacity(0.6)),
                        _buildColorProduct(color: Colors.green.withOpacity(0.6)),
                        _buildColorProduct(color: Colors.yellow.withOpacity(0.6)),
                        _buildColorProduct(color: Colors.orangeAccent.withOpacity(0.6)),

                      ],

                      onPressed: (int index){
                        setState(() {
                          for(int indexBtn=0; indexBtn< colored.length; indexBtn++){
                            if(indexBtn== index){
                             colored[indexBtn]= true;
                            }else{
                              colored[indexBtn]= false;
                            }
                          }
                        });
                        setState(() {
                          colorIndex=index;
                        });
                      },

                      isSelected:colored,
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
                        getSize();
                        getColor();
                        productProvider.getCartData(
                          image:widget.image,
                          name: widget.name,
                          size:size,
                          color:color,
                          price: widget.price,
                          quantity: count,
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));

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
