import 'package:cart/models/ProductModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference checkoutCollection =
      Firestore.instance.collection('checkouts');

  //gets reference to documents and updates data
  Future updateUserData(
      List<ProductModel> cart, int sum, String name, Map cartItems) async {
    return await checkoutCollection.document(uid).setData({
      'cart': cart,
      'sum': sum,
      'string': name,
      'cartItems': cartItems
    }); //gets a reference to the document of uid or create one if doesn't exist
  }
}
