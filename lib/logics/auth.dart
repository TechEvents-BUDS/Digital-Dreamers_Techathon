// ignore_for_file: empty_catches, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  Future getInfo() async {
    var email = auth.currentUser!.email;
    var datas;
    try {
      final response = await firestore.collection('user').get();
      final data =
          response.docs.where((element) => element['email'] == email).first;
      datas = data;
    } catch (e) {}
    return datas;
  }
}
