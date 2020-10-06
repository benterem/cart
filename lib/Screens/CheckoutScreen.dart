import 'package:cart/ProductModel.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  //fields
  final cart;
  final sum;
  final cartItems;
  final ValueSetter<ProductModel> _valueSetter;

  //CheckoutScreen(this.cart, this.sum);
  CheckoutScreen(this.cart, this.sum, this.cartItems, this._valueSetter);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListView.separated(
          itemBuilder: (context, index) => ListTile(
              title: Text(cart[index].getName()),
              trailing: Text("\$${cart[index].getPrice()}"),
              subtitle: Text('Quantity: ${cartItems[cart[index].getName()]}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  )),
              onTap: () => _valueSetter(cart[index])),
          separatorBuilder: (context, index) => Divider(),
          itemCount: cart.length,
          shrinkWrap: true,
        ),
        Divider(),
        Text("Your total: \$$sum")
      ],
    );
  }
}
