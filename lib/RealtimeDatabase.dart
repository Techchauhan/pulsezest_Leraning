import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pulsezest_testing/RealtimeDatabase/FetchSingleData.dart';
import 'package:pulsezest_testing/RealtimeDatabase/addDetails.dart';
import 'package:pulsezest_testing/RealtimeDatabase/fetchDetails.dart';


class RealtimeDatabase extends StatelessWidget {
  final DatabaseReference ref = FirebaseDatabase.instance.reference().child('posts');

    RealtimeDatabase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Real Time Database"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddDetails()));
              },
              child: const Text("ADD the Data"),
            ),
            ElevatedButton(onPressed:  (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FetchDetails()));
            }, child: const Text("Fetch the Data")),
            ElevatedButton(onPressed:  (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FetchByUsernamePage()));
            }, child: const Text("Fetch Single Data"))
          ],
        ),
      ),
    );
  }
}
