import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CloudFirestore extends StatefulWidget {
  const CloudFirestore({super.key});

  @override
  State<CloudFirestore> createState() => _CloudFirestoreState();
}

class _CloudFirestoreState extends State<CloudFirestore> {

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {

    Future<void> addUser(){
      return users.add({
        'fullName': "Rishab Chauhan",
        "email" : "rishabkumarchuahan@gmail.com",
        "number" : "6396219233",
        "address" : "Pashu Pati Vihar Colony"
      }).then((value) => debugPrint("User Added")).catchError((error)=> debugPrint("faild to add user $error"));
    }

    return  Scaffold(
      body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: addUser, child: Text("ADD user"))
              ],
            ),
      ),
    );
  }
}
