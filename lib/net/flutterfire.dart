import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String passw) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: passw);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> register(
  String email,
  String passw,
) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: passw);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> addCoin(String id, String amount, bool tap) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var value = double.tryParse(amount);
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Coins')
        .doc(id);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      Future.delayed(Duration(seconds: 0), () {
        if (snapshot.exists) {
          double newAmount = snapshot['Amount'] + value;
          transaction.update(documentReference, {'Amount': newAmount});
          return true;
        } else if (!(snapshot.exists)) {
          documentReference.set({'Amount': value});
          return true;
        }
        return true;
      });
    });
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> removeCoins(String id) async {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore.instance
      .collection('Users')
      .doc(uid)
      .collection('Coins')
      .doc(id)
      .delete();
  return true;
}
