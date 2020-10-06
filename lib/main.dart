import 'package:cart/ProductModel.dart';
import 'package:cart/Screens/CheckoutScreen.dart';
import 'package:cart/Screens/ProductScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CartApp(),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    //Create the defaul tab controller with 2 tabs
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
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
                      print('in remove');
                      cart.remove(product);
                      cartItems[product.getName()] = 0;
                    }
                    print(cartItems[product.getName()]);
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
