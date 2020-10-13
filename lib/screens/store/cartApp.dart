import 'package:cart/models/ProductModel.dart';
import 'package:cart/screens/store/CheckoutScreen.dart';
import 'package:cart/screens/store/ProductScreen.dart';
import 'package:cart/services/auth.dart';
import 'package:flutter/material.dart';

//main widget of app, implement tab views and screen
class CartApp extends StatefulWidget {
  @override
  _CartAppState createState() => _CartAppState();
}

class _CartAppState extends State<CartApp> {
  //global access to cart
  List<ProductModel> cart = [];
  int sum = 0;
  Map cartItems = {'Shirt': 0, 'Pants': 0, 'Shoes': 0, 'Socks': 0};
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    //Create the defaul tab controller with 2 tabs
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurpleAccent,
              title: Text('Shopping Cart'),
              bottom: TabBar(
                //define the two tabs
                tabs: <Widget>[
                  Tab(
                    text: "Store",
                  ),
                  Tab(text: "Checkout")
                ],
              ),
              actions: [
                FlatButton.icon(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    icon: Icon(Icons.person),
                    label: Text('logout'))
              ],
            ),
            //define the TabBarView
            body: TabBarView(
              children: <Widget>[
                //Product tab
                ProductScreen(
                    //function that adds the selected product to file
                    (product) {
                  //changes ui of app
                  setState(() {
                    if (cartItems[product.getName()] < 1) {
                      cart.add(product);
                    }
                    cartItems[product.getName()]++;
                    sum = 0;
                    cart.forEach((element) {
                      sum += element.getPrice() * cartItems[element.getName()];
                    });
                  });
                }),
                //Checkout tab
                //CheckoutScreen(cart, sum)
                CheckoutScreen(cart, sum, cartItems, (product) {
                  //changes ui of app
                  setState(() {
                    if (cartItems[product.getName()] < 2) {
                      cart.remove(product);
                      cartItems[product.getName()] = 0;
                    }
                    cartItems[product.getName()] < 1
                        ? cartItems[product.getName()] = 0
                        : cartItems[product.getName()]--;
                    sum = 0;
                    cart.forEach((element) {
                      sum += element.getPrice() * cartItems[element.getName()];
                    });
                  });
                })
              ],
            )));
  }
}
