import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/*
* loading screen  
*/

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Center(
        child: SpinKitCubeGrid(color: Colors.deepPurpleAccent, size: 50.0),
      ),
    );
  }
}
