import 'package:cart/models/user.dart';
import 'package:cart/screens/authenticate/authenticate.dart';
import 'package:cart/screens/store/cartApp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    }
    //return either cartApp or authenticate widget
    return CartApp();
  }
}
