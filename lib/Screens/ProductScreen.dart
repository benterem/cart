import 'package:flutter/material.dart';
import 'package:cart/ProductModel.dart';

class ProductScreen extends StatelessWidget {
  //fields
  final ValueSetter<ProductModel> _valueSetter;

  //constructor
  ProductScreen(this._valueSetter);

  //list of our products
  final List<ProductModel> products = [
    ProductModel("Shirt", 20),
    ProductModel("Pants", 40),
    ProductModel("Shoes", 50),
    ProductModel("Socks", 5)
  ];

  @override
  Widget build(BuildContext context) {
    //ListView of our products
    return ListView.separated(
        itemBuilder: (context, index) => ListTile(
              title: Text(products[index].getName()),
              trailing: Text(
                "\$${products[index].getPrice()}",
              ),
              //senses when user taps particular item
              onTap: () => _valueSetter(products[index]),
            ),
        separatorBuilder: (context, index) => Divider(),
        itemCount: products.length);
  }
}
