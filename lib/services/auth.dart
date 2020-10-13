import 'package:cart/models/user.dart';
import 'package:cart/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth
      .instance; //instance of firebase auth, lets us interact w/ FirebaseAuth

  //create User obj
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream: tells us is user signed in/signed out
  //also maps FirebaseUser to our custom user
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result
          .user; // we turn FirebaseUser to custom User class for abstraction
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in w/ email & pwd
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register
  // we also set up a database record
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      //create a new doc for user w/ uid
      await DatabaseService(uid: user.uid).updateUserData(
          [], 0, 'new user', {'Shirt': 0, 'Pants': 0, 'Shoes': 0, 'Socks': 0});

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut(); //_auth signOut NOT same function
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
