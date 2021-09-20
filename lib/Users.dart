import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class addUser{
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static void userRegister({
    @required String? name,
    @required String? email,
    @required String? password,
    @required String? phone,
  }) async {
    await _auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
    final User? user = _auth.currentUser;
    final _uid = user!.uid;
   await FirebaseFirestore.instance.collection('users').doc('ID').set({
      'id': _uid,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    });
  }

  static void userLogin(
      {@required String? email, @required String? password}) async {
    await _auth
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
    });
  }

  static void userLogout() async {
    await _auth.signOut();
  }
}
