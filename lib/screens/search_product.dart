import 'package:flutter/material.dart';
import 'package:taiwo_ecommerce_app/model/products_model.dart';
import 'package:taiwo_ecommerce_app/provider/category_provider.dart';
import 'package:taiwo_ecommerce_app/provider/product_provider.dart';
import 'package:taiwo_ecommerce_app/widgets/singleproducts.dart';
import 'package:provider/provider.dart';
class SearchProduct extends SearchDelegate<void> {

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
    ProductProvider productProvider=Provider.of(context);
    List<ProductModel> searchproduct =productProvider.searchProductList(query);

    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: searchproduct.length,
        gridDelegate:  const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 4/6,
            crossAxisSpacing: 8,
            mainAxisSpacing: 10),
        itemBuilder: (context, index){

          return SingleProducts(model: searchproduct[index]);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ProductProvider productProvider=Provider.of(context);
    List<ProductModel> searchproduct =productProvider.searchProductList(query);

    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: searchproduct.length,
        gridDelegate:  const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 4/6,
            crossAxisSpacing: 8,
            mainAxisSpacing: 10),
        itemBuilder: (context, index){

          return SingleProducts(model: searchproduct[index]);
        });
  }
}
