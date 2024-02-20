import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class Summarise extends StatefulWidget {
  const Summarise({super.key});

  @override
  State<Summarise> createState() => _SummariseState();
}

class _SummariseState extends State<Summarise> {
  @override
  Widget build(BuildContext context) {

    final DatabaseReference ref = FirebaseDatabase.instance.reference().child('dummy');
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return   Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                  ElevatedButton(onPressed: (){
                      ref.set({
                        "firstName": "Rishab",
                        "lastName": "Chauhan"

                      });
                  }, child: const Text("RealTime set")),
            ElevatedButton(onPressed: (){
                  _firestore.collection('dummy').doc().set( {
                    "name": "Rishab",
                    "lastName": "Chauhan"
                  });
            }, child: const Text("Add the Data(CloudFirestore)")),
          ],
        ),
      ),
    );
  }
}
