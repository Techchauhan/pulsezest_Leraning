import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pulsezest_testing/CloudFireStore/FetchDetailsCloud.dart';
import 'package:pulsezest_testing/CloudFireStore/addDetailsCloud.dart';
import 'package:pulsezest_testing/CloudFireStore/setDataInsideDocument.dart';

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
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDetailsCloud()));
                }, child: const Text("ADD user")
                ),

                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SetDataInDocumentPage()));
                }, child: const Text("Set Details Inside Documents")
                ),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FetchAllUsersCloud()));
                }, child: const Text("Fetch User")
                ),
              ],
            ),
      ),
    );
  }
}
