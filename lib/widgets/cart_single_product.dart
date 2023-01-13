import 'package:flutter/material.dart';
import 'package:taiwo_ecommerce_app/provider/product_provider.dart';
import 'package:provider/provider.dart';
class CartSingleProduct extends StatefulWidget {
  final String name;
  final String image;
  int quantity;
  final String color;
  final String size;
  final double price;
  final int index;

  CartSingleProduct({required this.name, required this.image,
    required this.quantity, required this.size, required this.color,required this.price, required this.index});


  @override
  State<CartSingleProduct> createState() => _CartSingleProductState();
}

class _CartSingleProductState extends State<CartSingleProduct> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider=Provider.of<ProductProvider>(context);

    return Container(
          height: 190,
          width: double.infinity,
          child: Card(
            child: Row(
              children: [
                Container(
                    width: 140,
                    height: 130,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(widget.image))
                    )
                ),

                Expanded(
                  child: Container(
                    height: 190,
                    width: 190,
                    child: ListTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(widget.name,style: TextStyle(fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                              ),

                              Expanded(
                                child: IconButton(onPressed:
                                    (){
                                      productProvider.deleteCartProduct(widget.index);
                                    },
                                    icon: Icon(Icons.close,color: Colors.black)),
                              )
                            ]
                          ),
                          Text("\$ ${widget.price} ",style: TextStyle(fontSize: 18,
                              fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent)),

                      Container(
                        height: 40,
                        width: 110,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Quantity:",style:TextStyle(color: Colors.black,fontSize: 17),),

                              Text(widget.quantity .toString() , style: TextStyle(fontSize: 18),),

                            ],
                          ),
                        ),

                      ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                          Text("Color:",style:TextStyle(color: Colors.black,fontSize: 17, fontWeight: FontWeight.bold),),
                          SizedBox(width:25),
                          Text(widget.color, style: TextStyle(fontSize: 18),),

                        ],),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                            Text("Size:",style:TextStyle(color: Colors.black,fontSize: 17, fontWeight: FontWeight.bold),),
                              SizedBox(width:25),
                            Text(widget.size , style: TextStyle(fontSize: 18),),

                          ],),
                      ]
                      )
                    ),
                  ),
                )
              ],
            ),
          ),

    );
  }
}
