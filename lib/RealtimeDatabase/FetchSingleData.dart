import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FetchByUsernamePage extends StatefulWidget {
  @override
  _FetchByUsernamePageState createState() => _FetchByUsernamePageState();
}

class _FetchByUsernamePageState extends State<FetchByUsernamePage> {
  final DatabaseReference ref = FirebaseDatabase.instance.reference().child('posts/1708028117192');
  late String username = 'No data Found';

  @override
  void initState() {
    super.initState();
    fetchDataByUsername();
  }

  Future<void> fetchDataByUsername() async {
    try {
      final event = await ref.once(DatabaseEventType.value);
      final data = event.snapshot.value as Map<dynamic, dynamic>?; // Cast value to Map<dynamic, dynamic>
      setState(() {
        username = data?['firstName'] ?? 'Anonymous';
      });
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fetch by Username"),
      ),
      body: Center(
        child: Text(
          'Username: $username',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
