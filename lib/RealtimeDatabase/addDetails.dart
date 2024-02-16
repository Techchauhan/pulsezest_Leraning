import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddDetails extends StatefulWidget {
  const AddDetails({Key? key}) : super(key: key);

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final DatabaseReference ref = FirebaseDatabase.instance.reference().child('posts');

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adding into RealTime."),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                sendData(_firstNameController.text, _lastNameController.text, _phoneNumberController.text);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void sendData(String name, String lastName, String number) {
    try {
      var timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

      DatabaseReference newPostRef = ref.child(timeStamp);

      newPostRef.set({
        "firstName": name,
        "lastName": lastName,
        "Number": number,
      }).then((_) {
        // Data sent successfully
        print("Data sent successfully!");
        // After sending data, navigate to the update page with the newly added details
        Navigator.pop(context);
      }).catchError((error) {
        // Handle errors here
        print("Error sending data: $error");
      });
    } catch (e) {
      print("Exception occurred: $e");
    }
  }
}
