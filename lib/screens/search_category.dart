import 'package:flutter/material.dart';
import 'package:taiwo_ecommerce_app/model/products_model.dart';
import 'package:taiwo_ecommerce_app/provider/category_provider.dart';
import 'package:taiwo_ecommerce_app/provider/product_provider.dart';
import 'package:taiwo_ecommerce_app/widgets/singleproducts.dart';
import 'package:provider/provider.dart';
class SearchCategory extends SearchDelegate<void> {
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: (){
      query = "";
    },
        icon: Icon(Icons.clear))];

  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, null);
    },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
   CategoryProvider categoryProvider=Provider.of(context);
   List<ProductModel> searchproduct=categoryProvider.searchCategoryList(query);
   
    return GridView.count(crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        scrollDirection: Axis.vertical,
                children: searchproduct.map((e){
                  return SingleProducts(
                      name: e.name,
                      image: e.image,
                      price: e.price,
                      descript: e.descript);
                }).toList(),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    CategoryProvider categoryProvider=Provider.of(context);
    List<ProductModel> searchproduct=categoryProvider.searchCategoryList(query);

    return GridView.count(crossAxisCount: 2,
            childAspectRatio: 0.7,
            scrollDirection: Axis.vertical,
            children: searchproduct.map((e){
          return SingleProducts(
            name: e.name,
            image: e.image,
            price: e.price,
            descript: e.descript);
      }).toList(),);
  }
}
